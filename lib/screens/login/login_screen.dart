import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:horana_heights/screens/login/send_email_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../utils/constatnt.dart';
import 'confirm_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    final provider = Provider.of<CustomerProvider>(context, listen: false);
    provider.usernameController.dispose();
    provider.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Color(0xFF262D34),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/newback.jpg',
                ).image,
              ),
            ),
          ),
          SlideInDown(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome to",
                        style: TextStyle(
                          fontSize: 25,
                          letterSpacing: 2,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                    Text(
                      "Horana Heights,",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const Text(
                      "Sign in to Continue",
                      style: TextStyle(
                        letterSpacing: 1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: SlideInUp(
              child: Container(
                // height: 500,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 3, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 16, 5, 0),
                              child: Consumer<CustomerProvider>(
                                builder: (context, value, child) {
                                  return Form(
                                    key: _formKey,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 8, left: 15, right: 15),
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            "Login",
                                            style: GoogleFonts.poppins(
                                              letterSpacing: 1,
                                              color: Colors.purple[800],
                                              fontSize: 25,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          customTextField(
                                              CupertinoIcons.person,
                                              "Username",
                                              "Username",
                                              false,
                                              false,
                                              value.usernameController,
                                              (value) {
                                            if (value!.isEmpty) {
                                              return ("Please enter username");
                                            }
                                            return null;

                                            // return null;
                                          }, false, false),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          customTextField(
                                              CupertinoIcons.lock,
                                              "Password",
                                              "Password",
                                              false,
                                              false,
                                              value.passwordController,
                                              (value) {
                                            if (value!.isEmpty) {
                                              return ("Please enter password");
                                            }
                                            return null;

                                            // return null;
                                          }, true, true),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   PageTransition(
                                                //       type: PageTransitionType
                                                //           .rightToLeft,
                                                //       child: SendEmailScreen(),
                                                //       inheritTheme: true,
                                                //       ctx: context),
                                                // );

                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: SendEmailScreen(),
                                                      inheritTheme: true,
                                                      ctx: context),
                                                );
                                              },
                                              child: const Text(
                                                "Forgot Password?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
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
                                                      color: Colors.blue
                                                          .withOpacity(.3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
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
                                                    value.startLogin(
                                                        _formKey, context);
                                                  },
                                                  child: Material(
                                                    elevation: 5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color: Colors.purple,
                                                    child: Container(
                                                      height: 48,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue
                                                            .withOpacity(.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          "Login",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
}
