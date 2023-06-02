import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horana_heights/screens/login/login_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../controller/forgot_password.dart';
import '../screens/login/confirm_password_screen.dart';

class PasswordResetProvider extends ChangeNotifier {
  final PasswordResetController _passwordresetController =
      PasswordResetController();
  bool _isHome = true;
  bool get isHome => _isHome;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void changeResetView() {
    _isHome = true;
    notifyListeners();
  }

  Future<void> passwordReset(
    BuildContext context,
    String email,
    GlobalKey<FormState> _formKey,
  ) async {
    setLoading(true);
    if (_formKey.currentState!.validate()) {
      String result = await _passwordresetController.sendEmail(context, email);

      print("******************* : " + result);
      if (result == "success") {
        setLoading();
        _isHome = false;
      } else if (result == "notexist") {
        setLoading();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('The email address provided is not found in the database'),
          backgroundColor: Colors.red,
        ));
      } else {
        setLoading();
      }
    } else {
      setLoading();
    }

    notifyListeners();
  }

  Future<void> passwordResetCode(
    BuildContext context,
    String code,
    String email,
    GlobalKey<FormState> _formKey,
  ) async {
    setLoading(true);
    if (_formKey.currentState!.validate()) {
      String result =
          await _passwordresetController.checkCode(context, code, email);
      if (result == "success") {
        setLoading();
        _isHome = false;

        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ConfirmPasswordScreen(email: email),
              inheritTheme: true,
              ctx: context),
        );
      } else {
        setLoading();
      }
    } else {
      setLoading();
    }

    notifyListeners();
  }

  //change loading state
  void setLoading([bool val = false]) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> checkNewPasswords(
    BuildContext context,
    String password,
    String confirmpassword,
    String email,
    GlobalKey<FormState> _formKey,
  ) async {
    setLoading(true);
    if (_formKey.currentState!.validate()) {
      if (password == confirmpassword) {
        String result = await _passwordresetController.checkNewPasswords(
            context, password, email);
        if (result == "success") {
          setLoading();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Successfully reset password'),
            backgroundColor: Colors.green,
          ));
          _isHome = false;
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: LoginScreen(),
                inheritTheme: true,
                ctx: context),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error'),
            backgroundColor: Colors.red,
          ));
          setLoading();
        }
      } else {
        setLoading();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      setLoading();
    }

    notifyListeners();
  }
}
