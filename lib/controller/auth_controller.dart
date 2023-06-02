import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/objects.dart';

class AuthController {
  Future<CustomerModel> startLogin(
      String uname, String pword, BuildContext context) async {
    CustomerModel customerModel = CustomerModel(
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

    var url = "https://satasmeappdev.shop/api/loginCheck";
    var body = null;
    try {
      final response = await http.post(Uri.parse(url), body: {
        "username": uname,
        "password": pword,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);

        if (body["code"] == 200) {
          Map<String, dynamic> _token = body["data"];
          customerModel = CustomerModel.fromJson(_token);
          return customerModel;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login error.' + body.toString()),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login error.' + response.statusCode.toString()),
          backgroundColor: Colors.red,
        ));
      }
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No internnet connection.'),
        backgroundColor: Colors.red,
      ));
    }

    return customerModel;
  }

  Future<void> saveToken(
    String cid,
    String token,
    String nic,
  ) async {
    var url = "https://satasmeappdev.shop/api/save_token";

    final response = await http.post(Uri.parse(url),
        body: {"cid": cid, "token": token, "cus_nic": nic});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
    }
  }

  Future<CustomerModel> uploadProfileImage(
    File imgfile,
    String cid,
    String nic,
  ) async {
    CustomerModel customerModel = CustomerModel(
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
    final uri = Uri.parse('https://satasmeappdev.shop/api/upload_image');
    final request = http.MultipartRequest('POST', uri);
    final file = await http.MultipartFile.fromPath('image', imgfile.path);

    request.fields['cus_id'] = cid;
    request.fields['cus_nic'] = nic;
    request.files.add(file);
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      final bytes = await response.stream.toBytes();
      final body = String.fromCharCodes(bytes);
      final body1 = json.decode(body);

      Map<String, dynamic> _token = body1["data"];
      customerModel = CustomerModel.fromJson(_token);

      return customerModel;
    } else {
      print('Image upload failed with status ${response.statusCode}');
    }
    return customerModel;
  }

  Future<AsignHomeModel> asignHome(
      BuildContext context, String nic, String id) async {
    AsignHomeModel asignhomeModel = AsignHomeModel(
      id: 0,
      ah_reserve_date: "",
      ah_agreement: "",
      ah_reserve_recipt: "",
      ah_remark: "",
      types: PaymentStatusModel(id: 0, ps_type: ""),
      ah_down_payment: "",
      status: "0",
      tower: TowerModel(
        id: 0,
        tower_name: "",
        tower_location: "",
        tower_image: "null",
        status: "0",
        created_at: "",
        updated_at: "",
      ),
      floor: FloorModel(
        id: 0,
        tower_id: "",
        floor_number: "",
        status: "0",
        created_at: "",
        updated_at: "",
      ),
      home: HomeModel(
        id: 0,
        tower_id: "",
        floor_id: "",
        home_number: "",
        status: "0",
        created_at: "",
        updated_at: "",
      ),
      customer: CustomerModel(
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
        updated_at: "null",
      ),
      created_at: "",
      updated_at: "",
    );

    var url = "https://satasmeappdev.shop/api/get_home_by_customer_id";
    var body = null;
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_nic": nic,
        "cus_id": id,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);

        if (body["data"] != null) {
          Map<String, dynamic> _token = body["data"];
          asignhomeModel = AsignHomeModel.fromJson(_token);
        }

        return asignhomeModel;
      } else if (response.statusCode == 429) {
        // Retry the request after a delay
        await Future.delayed(
            Duration(seconds: 5)); // Adjust the delay duration as needed
        return asignHome(context, nic, id); // Retry the request recursively
      } else {
        // Handle other non-200 status codes if needed
      }
    } on SocketException {
      // Handle socket exception if needed
    }

    return asignhomeModel;
  }

  Future<CustomerModel> updateCustomer(BuildContext context,
      CustomerModel? customer, String name, String email, String phone) async {
    CustomerModel customerModel = CustomerModel(
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
    var url = "https://satasmeappdev.shop/api/update_customer_by_id";
    var body = null;

    print("update phone number : ***************** : " + phone);
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_nic": customer!.cus_nic,
        "cus_id": customer.id.toString(),
        "cus_name": name,
        "cus_email": email,
        "cus_phone": phone,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);

        if (body["data"] != 0) {
          Map<String, dynamic> _token = body["data"];
          print("!!! : " + _token.toString());
          customerModel = CustomerModel.fromJson(_token);
          return customerModel;
        } else {
          return customerModel;
        }
      } else {}
    } on SocketException {}
    return customerModel;
  }

  Future<CustomerModel> getCustomerById(
      BuildContext context, String nic, String id) async {
    CustomerModel customerModel = CustomerModel(
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

    var url = "https://satasmeappdev.shop/api/get_customer_by_id";
    var body = null;
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_nic": nic,
        "cus_id": id,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);

        Map<String, dynamic> _token = body["data"];

        customerModel = CustomerModel.fromJson(_token);
        return customerModel;
      } else if (response.statusCode == 429) {
        // Retry the request after a delay
        await Future.delayed(
            Duration(seconds: 5)); // Adjust the delay duration as needed
        return getCustomerById(
            context, nic, id); // Retry the request recursively
      } else {
        // Handle other non-200 status codes if needed
      }
    } on SocketException {
      // Handle socket exception if needed
    }

    return customerModel;
  }

  Future<List<CustomerModel>> getAllCustomers(
      int page, int limit, String query, String nic) async {
    final String baseUrl = 'https://satasmeappdev.shop/api/get_all_customers';
    final url = Uri.parse('$baseUrl?page=$page&limit=$limit');

    final Map<String, dynamic> requestData = {
      "query": query, // Use "email_like" key for the email search
      "cus_nic": nic,
      // Add additional key-value pairs as needed
    };

    final int maxRetryAttempts = 3;
    int retryAttempt = 0;
    bool shouldRetry = true;

    while (shouldRetry && retryAttempt < maxRetryAttempts) {
      try {
        final response = await http.post(url,
            body: jsonEncode(requestData),
            headers: {
              'Content-Type': 'application/json'
            }).timeout(Duration(seconds: 10)); // Add the timeout duration

        if (response.statusCode == 200) {
          final body = json.decode(response.body);
          final List<dynamic> data = body["data"];

          return List<CustomerModel>.from(
            data.map((user) => CustomerModel.fromJson(user)),
          );
        } else if (response.statusCode == 429) {
          // Rate limit exceeded, wait for a specific duration before retrying
          final retryAfter = response.headers['retry-after'];
          if (retryAfter != null) {
            final waitDuration = Duration(seconds: int.parse(retryAfter));
            await Future.delayed(waitDuration);
          } else {
            await Future.delayed(Duration(
                seconds:
                    5)); // Default wait duration if retry-after header is not provided
          }
          retryAttempt++;
        } else {
          shouldRetry = false; // Stop retrying for other error codes
        }
      } catch (e) {
        shouldRetry = false; // Stop retrying for other exceptions
      }
    }

    throw Exception('Failed to load users');
  }

  Stream<AsignHomeModel> asignHomeBySelectedCustomer(
      BuildContext context, String nic, String id) async* {
    AsignHomeModel asignhomeModel = AsignHomeModel(
      id: 0,
      ah_reserve_date: "",
      ah_agreement: "",
      ah_reserve_recipt: "",
      ah_remark: "",
      types: PaymentStatusModel(id: 0, ps_type: ""),
      ah_down_payment: "",
      status: "0",
      tower: TowerModel(
          id: 0,
          tower_name: "",
          tower_location: "",
          tower_image: "null",
          status: "0",
          created_at: "",
          updated_at: ""),
      floor: FloorModel(
        id: 0,
        tower_id: "",
        floor_number: "",
        status: "0",
        created_at: "",
        updated_at: "",
      ),
      home: HomeModel(
        id: 0,
        tower_id: "",
        floor_id: "",
        home_number: "",
        status: "0",
        created_at: "",
        updated_at: "",
      ),
      customer: CustomerModel(
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
        updated_at: "null",
      ),
      created_at: "",
      updated_at: "",
    );

    var url = "https://satasmeappdev.shop/api/get_home_by_customer_id";
    var body = null;
    int maxRetries = 3;
    int currentRetry = 0;

    while (currentRetry < maxRetries) {
      try {
        final response = await http.post(Uri.parse(url), body: {
          "cus_nic": nic,
          "cus_id": id,
        }).timeout(Duration(seconds: 10));

        if (response.statusCode == 200) {
          body = json.decode(response.body);

          if (body["data"] != null) {
            final data = body["data"];
            final item = AsignHomeModel.fromJson(data);

            yield item;
            return; // Exit the function after successful response
          }
        } else if (response.statusCode == 429) {
          // Retry after waiting for a specified duration
          final retryAfter = response.headers['retry-after'];
          if (retryAfter != null) {
            final waitDuration = Duration(seconds: int.parse(retryAfter));
            await Future.delayed(waitDuration);
          } else {
            // If the server does not provide a retry-after header, use a default wait time
            await Future.delayed(Duration(seconds: 5));
          }
        } else {
          throw Exception('Failed to fetch item');
        }
      } on SocketException {
        // Handle socket exception, e.g., display an error message to the user
      }

      currentRetry++;
    }
  }

  Stream<dynamic> fetchHomeCardData(
      String nic, int home_id, int cus_id) async* {
    var url = "https://satasmeappdev.shop/api/get_home_screen_card_data";

    final response = await http.post(Uri.parse(url), body: {
      "cus_nic": nic,
      "home_id": home_id.toString(),
      "cus_id": cus_id.toString()
    });

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      dynamic data = body["data"];

      yield data;
    } else {
      throw Exception('Failed to load item' + response.statusCode.toString());
    }
  }

  static Future<List<Map<String, dynamic>>> fetchUsers(String nic) async {
    final response = await http.post(
      Uri.parse('https://satasmeappdev.shop/api/get_all_users'),
      body: {
        'cus_nic': nic,
      },
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body["data"];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }
}
