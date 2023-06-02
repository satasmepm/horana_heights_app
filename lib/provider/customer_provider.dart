import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:horana_heights/screens/Home/admin_home_screen.dart';
import 'package:horana_heights/screens/login/login_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../controller/auth_controller.dart';

import '../controller/house_controller.dart';
import '../model/objects.dart';
import '../screens/Home/home_screen.dart';
import '../screens/customers/customer_by_home_number.dart';
import '../screens/customers/not_asign_home_to_customer_screen.dart';

class CustomerProvider extends ChangeNotifier {
  File _file = File("");
  File get getCropImg => _file;

  XFile? _imageFile;
  XFile? get getImageFile => _imageFile;
  final ImagePicker _picker = ImagePicker();

  CustomerModel? _customerModel;
  CustomerModel? get getCustomer => _customerModel;

  CustomerModel? _selectedcustomerModel;
  CustomerModel? get getSeletedCustomer => _selectedcustomerModel;

  AsignHomeModel? _asignHomeModel;
  AsignHomeModel? get getAsignHomeModel => _asignHomeModel;

  AsignHomeModel? _asignHomeModelSelectedCustomer;
  AsignHomeModel? get getAsignHomeSelectedCustomerModel =>
      _asignHomeModelSelectedCustomer;

  final AuthController _authController = AuthController();
  final HouseController _houseController = HouseController();

  bool _isLoading = false;
  //get loading state
  BuildContext? _context;
  bool get isLoading => _isLoading;

  bool _isHome = false;
  bool get isHome => _isHome;

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  final username = TextEditingController();
  TextEditingController get usernameController => username;
  final password = TextEditingController();
  TextEditingController get passwordController => password;

  final name = TextEditingController();
  TextEditingController get nameController => name;
  final email = TextEditingController();
  TextEditingController get emailController => email;
  final phone = TextEditingController();
  TextEditingController get phoneController => phone;

  final tower = TextEditingController();
  TextEditingController get towerController => tower;
  final floor = TextEditingController();
  TextEditingController get floorController => floor;
  final home = TextEditingController();
  TextEditingController get homeController => home;

  late String tower_name;
  String get gettowerName => tower_name;
  late String floor_name;
  String get getfloorName => floor_name;
  late String home_name;
  String get gethomeName => home_name;

  String _isAvailableCustomer = "false";
  String get getIsAvailableCustomer => _isAvailableCustomer;

  //login function
  Future<void> startLogin(
    GlobalKey<FormState> _formKey,
    BuildContext context,
  ) async {
    setLoading(true);

    if (_formKey.currentState!.validate()) {
      try {
        _customerModel = await _authController.startLogin(
            username.text, password.text, context);
        setLoading();

        if (_customerModel!.id != 0) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login success.'),
            backgroundColor: Colors.green,
          ));
          final prefs = await SharedPreferences.getInstance();
          final json = jsonEncode(_customerModel!.toJson());
          prefs.setString('customer', json);

          if (json != null) {
            final map = jsonDecode(json) as Map<String, dynamic>;
            name.text = map['cus_name'];
            email.text = map['cus_email'];
            phone.text = map['cus_phone'];
          }

          if (_customerModel!.role_id == "2") {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: AdminHomeScreen(),
                  inheritTheme: true,
                  ctx: context),
            );
          } else {
            getAsignHome(context, _customerModel!.cus_nic,
                _customerModel!.id.toString());
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: HomeScreen(),
                  inheritTheme: true,
                  ctx: context),
            );
          }
        }

        notifyListeners();
      } catch (e) {
        setLoading();
      }
    } else {
      setLoading();
    }
  }

  //initialize and check whther the user signed in or not
  void initializeUser(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final json = prefs.getString('customer');

    if (json != null) {
      final map = jsonDecode(json) as Map<String, dynamic>;
      fetchSingleCustomer(
          context, map['cus_nic'].toString(), map['id'].toString());
      _customerModel = CustomerModel.fromJson(map);
      if (_customerModel!.role_id == "2") {
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: AdminHomeScreen(),
              inheritTheme: true,
              ctx: context),
        );
      } else {
        getAsignHome(
            context, _customerModel!.cus_nic, _customerModel!.id.toString());

        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: HomeScreen(),
              inheritTheme: true,
              ctx: context),
        );
      }

      final prefs = await SharedPreferences.getInstance();
      String? stringValue = prefs.getString('token');
      if (stringValue != null) {
        _authController.saveToken(_customerModel!.id.toString(), stringValue,
            _customerModel!.cus_nic);
      }
    } else {
      Logger().i('User is currently signed out');
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: LoginScreen(),
            inheritTheme: true,
            ctx: context),
      );
    }
    notifyListeners();
  }

  //change loading state
  void setLoading([bool val = false]) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> logOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

// Set the 'myKey' key to null
    prefs.remove('customer');
    prefs.remove('token');
    _customerModel = new CustomerModel(
        id: 0,
        cus_name: "",
        cus_nic: "",
        cus_address: "",
        cus_phone: "",
        cus_email: "",
        cus_password: "",
        cus_image: "null",
        cus_auth_token: "",
        cus_token: "null",
        role_id: '0',
        status: "0",
        created_at: "null",
        updated_at: "null");

    _asignHomeModel = null;
    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeft,
          child: LoginScreen(),
          inheritTheme: true,
          ctx: context),
    );
    notifyListeners();
  }

  void nicFront(ImageSource source) async {
    File file = await takePhoto(source);
    _file = file;

    _customerModel = await _authController.uploadProfileImage(
        _file, _customerModel!.id.toString(), _customerModel!.cus_nic);
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(_customerModel!.toJson());
    prefs.setString('customer', json);
    notifyListeners();
  }

  Future<File> takePhoto(ImageSource source) async {
    dynamic file;
    final pickedFile =
        await _picker.pickImage(source: source // ImageSource.gallery,
            );

    if (pickedFile != null) {
      file = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
      file = await comressImage(file.path, 35);

      notifyListeners();
    } else {
      Logger().e("no image selected");
    }

    return file!;
  }

  Future<File> comressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      newPath,
      quality: quality,
    );
    return result!;
  }

  Future<void> getAsignHome(BuildContext context, String nic, String id) async {
    _asignHomeModel = await _authController.asignHome(context, nic, id);
    tower.text = _asignHomeModel!.tower.tower_name;
    floor.text = _asignHomeModel!.floor.floor_number;
    home.text = _asignHomeModel!.home.home_number;
    notifyListeners();
  }

  Future<void> fetchSingleCustomer(
      BuildContext context, String nic, String id) async {
    final prefs = await SharedPreferences.getInstance();
    CustomerModel customerModel =
        await _authController.getCustomerById(context, nic, id);

    if (customerModel.id > 0) {
      final json = jsonEncode(_customerModel!.toJson());
      prefs.setString('customer', json);
    }

    final json = prefs.getString('customer');
    if (json != null) {
      final map = jsonDecode(json) as Map<String, dynamic>;
      name.text = map['cus_name'];
      email.text = map['cus_email'];
      phone.text = map['cus_phone'];
    }
    notifyListeners();
  }

  Future<void> updateCustomer(
    BuildContext context,
    GlobalKey<FormState> _formKey,
    CustomerModel? customer,
  ) async {
    setLoading(true);

    if (_formKey.currentState!.validate()) {
      try {
        CustomerModel customerModel;
        customerModel = await _authController.updateCustomer(
            context, customer, name.text, email.text, phone.text);

        setLoading();

        if (customerModel.id > 0) {
          final prefs = await SharedPreferences.getInstance();
          final json = jsonEncode(customerModel.toJson());
          prefs.setString('customer', json);
          _customerModel = customerModel;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Update success.'),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error.'),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        setLoading();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error.'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      setLoading();
    }

    notifyListeners();
  }

  void setSeletedCustomer(BuildContext context, CustomerModel? customer) async {
    _selectedcustomerModel = customer;
    tower_name = "";
    floor_name = "";
    home_name = "";
    getAsignHomeBySekectedCustomer(
        context, customer!.cus_nic, customer.id.toString());
    notifyListeners();
  }

  Future<void> getAsignHomeBySekectedCustomer(
      BuildContext context, String nic, String id) async {
    _asignHomeModelSelectedCustomer =
        await _authController.asignHome(context, nic, id);
    tower_name = _asignHomeModelSelectedCustomer!.tower.tower_name;
    floor_name = _asignHomeModelSelectedCustomer!.floor.floor_number;
    home_name = _asignHomeModelSelectedCustomer!.home.home_number;

    notifyListeners();
  }

  Future<void> isAvailableAsignedHome(
      BuildContext context, String nic, String home_id) async {
    // setLoading(true);
    _isHome = true;
    String response =
        await _houseController.isAvailableHome(context, nic, home_id);

    if (response == "true") {
      hideLoadingDialog(context);
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child:
                CustomerByHomeNumberScreen(selectedIndex: home_id.toString()),
            inheritTheme: true,
            ctx: context),
      );
      // notifyListeners();
    } else {
      hideLoadingDialog(context);
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: NotAssignHomeToCustomerScreen(),
            inheritTheme: true,
            ctx: context),
      );
    }
    notifyListeners();
  }

  void showLoadingDialog(BuildContext context) {
    _isHome = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20.0),
                Text("Loading..."),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      _isHome = false;
      notifyListeners();
    });
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
    _isHome = false;
    notifyListeners();
  }

  //change obscure state
  void changeObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<void> isAvailableCustomer(
      BuildContext context, String nic, String cus_id) async {
    _isAvailableCustomer =
        await _houseController.isAvailableCustomer(context, nic, cus_id);

    notifyListeners();
  }
}
