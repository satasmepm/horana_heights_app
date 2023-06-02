import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:horana_heights/provider/password_reset_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constatnt.dart';
import '../../utils/util_functions.dart';
import '../componants/custom_loader.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  final String email;
  ConfirmPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  bool launchAnimation = true;
  late PasswordResetProvider _passwordResetProvider;
  late InheritedWidget _ancestor;
  // bool _isHome = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _passwordResetProvider =
        Provider.of<PasswordResetProvider>(context, listen: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _passwordResetProvider.changeResetView();
    });
    password.dispose();
    confirmpassword.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final password = TextEditingController();
  final confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Consumer2<PasswordResetProvider, CustomerProvider>(
                builder: (context, value, value2, child) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ElasticInLeft(
                          animate: launchAnimation,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Reset password",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Please Enter the new password ",
                                  style: TextStyle(),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "",
                                  style: TextStyle(),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                customTextField(
                                    CupertinoIcons.lock,
                                    "Password",
                                    "Password",
                                    false,
                                    false,
                                    password, (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter password");
                                  }
                                  return null;

                                  // return null;
                                }, true, true),
                                customTextField(
                                    CupertinoIcons.lock,
                                    "Confirm Password",
                                    "Confirm Password",
                                    false,
                                    false,
                                    confirmpassword, (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter confirm password");
                                  }
                                  return null;

                                  // return null;
                                }, true, true),
                                const SizedBox(
                                  height: 50,
                                ),
                                value.isLoading
                                    ? Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.purple,
                                        child: Container(
                                          height: 48,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(.3),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: const Center(
                                            child: SpinKitRing(
                                              color: Colors.white,
                                              size: 25,
                                              lineWidth: 2,
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          value.checkNewPasswords(
                                              context,
                                              password.text,
                                              confirmpassword.text,
                                              widget.email,
                                              _formKey);
                                        },
                                        child: Material(
                                          elevation: 5,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.purple,
                                          child: Container(
                                            height: 48,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.blue.withOpacity(.3),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Reset",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              )),
        ),
      ),
    );
  }

  Padding customTextField(
    IconData icon,
    String hintText,
    String labelText,
    bool isPassword,
    bool isEmail,
    TextEditingController controller,
    String? Function(String?)? validator,
    bool suffics,
    bool obscure,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hintText,
            style: const TextStyle(fontSize: 13, color: Constants.labelText),
          ),
          const SizedBox(
            height: 8,
          ),
          Consumer<CustomerProvider>(
            builder: (context, value, child) {
              return TextFormField(
                obscureText: obscure == true ? value.isObscure : false,
                controller: controller,
                keyboardType:
                    isEmail ? TextInputType.emailAddress : TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 243, 245, 247),
                  prefixIcon: Icon(
                    icon,
                    color: Constants.iconColor,
                  ),
                  suffixIcon: suffics
                      ? IconButton(
                          onPressed: () {
                            value.changeObscure();
                          },
                          icon: Icon(value.isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                        )
                      : null,
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: hintText,
                  labelText: hintText,
                  hintStyle: const TextStyle(
                      fontSize: 14, color: Constants.textColor1),
                ),
                validator: validator,
              );
            },
          )
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.purple,
      elevation: 0,
      title: const Text(
        "Reset password",
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      leading: Container(
        margin: const EdgeInsets.all(10),
        // height: 25,
        // width: 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.purple),
        child: Builder(
          builder: (BuildContext context) {
            return IconButton(
              padding: const EdgeInsets.all(3),
              icon: const Icon(
                CupertinoIcons.chevron_left,
                size: 18,
              ),
              color: Colors.white,
              onPressed: () {
                UtilFuntions.goBack(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
    );
  }
}
