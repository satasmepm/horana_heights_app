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

class SendEmailScreen extends StatefulWidget {
  SendEmailScreen({Key? key}) : super(key: key);

  @override
  State<SendEmailScreen> createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {
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
    email.dispose();
    code.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final code = TextEditingController();

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
                      value.isHome == true
                          ? Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Forgot Your Password?",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Please Enter Your Email Address to Send",
                                    style: TextStyle(),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Verification code to Email",
                                    style: TextStyle(),
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  customTextField(
                                    MaterialCommunityIcons.email_outline,
                                    "Email Address",
                                    "Email Address",
                                    false,
                                    true,
                                    email,
                                    (value) {
                                      if (value!.isEmpty) {
                                        return ("Please enter your email");
                                      } else if (!RegExp(
                                              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                          .hasMatch(value)) {
                                        return ("Please Enter a valid email");
                                      }
                                      return null;
                                      // return null;
                                    },
                                    false,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  value.isLoading
                                      ? Material(
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
                                            // setState(() {
                                            //   _isHome = false;
                                            // });
                                            value.passwordReset(
                                                context, email.text, _formKey);
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
                                                  "Send",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : ElasticInLeft(
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
                                      "Verify Email",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Please Enter the Verification Code to",
                                      style: TextStyle(),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "Verify your Email",
                                      style: TextStyle(),
                                    ),
                                    const Text(
                                      "(If email not in the inbox, Please check your spam folder.)",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      height: 35,
                                    ),
                                    customTextField(
                                      MaterialCommunityIcons.account_outline,
                                      "Verification Code",
                                      "Verification Code",
                                      false,
                                      false,
                                      code,
                                      (value) {
                                        if (value!.isEmpty) {
                                          return ("Please enter code");
                                        }
                                        return null;
                                      },
                                      false,
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    value.isLoading
                                        ? Material(
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
                                              // setState(() {
                                              //   _isHome = false;
                                              // });
                                              value.passwordResetCode(
                                                  context,
                                                  code.text,
                                                  email.text,
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
                                                  color: Colors.blue
                                                      .withOpacity(.3),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    "Verify",
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
    bool isReadOnly, // New parameter
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              readOnly: isReadOnly,
              obscureText: false,
              controller: controller,
              keyboardType:
                  isEmail ? TextInputType.emailAddress : TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: isReadOnly
                    ? Color.fromARGB(255, 230, 232, 235)
                    : Color.fromARGB(255, 245, 245, 248),
                prefixIcon: Icon(
                  icon,
                  color: Constants.iconColor,
                ),
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
                hintStyle:
                    const TextStyle(fontSize: 14, color: Constants.textColor1),
              ),
              validator: validator),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.purple,
      elevation: 0,
      title: const Text(
        "Forgot password",
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
