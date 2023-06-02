import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constatnt.dart';
import '../../utils/util_functions.dart';
import '../componants/custom_loader.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
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
              child: Consumer<CustomerProvider>(
                builder: (context, value, child) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          value.getCropImg.path == ""
                              ? (value.getCustomer != null &&
                                      (value.getCustomer!.cus_image != "null"))
                                  ? Hero(
                                      tag: "profile-img",
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            "https://satasmeappdev.shop/uploads/customers/" +
                                                value.getCustomer!.cus_image),
                                      ),
                                    )
                                  : const Hero(
                                      tag: "profile-img",
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            AssetImage('assets/avatar.jpg'),
                                      ),
                                    )
                              : Hero(
                                  tag: "profile-img",
                                  child: CircleAvatar(
                                    backgroundImage: FileImage(
                                      File(value.getCropImg.path),
                                    ),
                                    radius: 50,
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                _showChoiceDialognew(context, value);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.purple,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.getCustomer!.cus_name,
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        value.getCustomer!.cus_email,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Text("{SDDDDDDD } : " +
                      //     value.getAsignHomeModel.toString()),
                      if (value.getAsignHomeModel != null)
                        if (value.getAsignHomeModel!.types.id == 1)
                          CustomStatus(
                              size,
                              Color.fromARGB(255, 203, 252, 204),
                              Colors.green,
                              "assets/80476-success-animation-var-1.json",
                              value.getAsignHomeModel!.types.ps_type,
                              "your account hase been Open status")
                        else if (value.getAsignHomeModel!.types.id == 2)
                          CustomStatus(
                              size,
                              Color.fromARGB(255, 252, 241, 203),
                              Colors.amber,
                              "assets/134878-warning-status.json",
                              value.getAsignHomeModel!.types.ps_type,
                              "your account hase been default status")
                        else if (value.getAsignHomeModel!.types.id == 3)
                          CustomStatus(
                              size,
                              Color.fromARGB(255, 252, 241, 203),
                              Colors.amber,
                              "assets/134878-warning-status.json",
                              value.getAsignHomeModel!.types.ps_type,
                              "your account hase been Fraud status")
                        else if (value.getAsignHomeModel!.types.id == 4)
                          CustomStatus(
                              size,
                              Color.fromARGB(255, 203, 252, 204),
                              Colors.amber,
                              "assets/134878-warning-status.json",
                              value.getAsignHomeModel!.types.ps_type,
                              "your account hase been Investigation status")
                        else if (value.getAsignHomeModel!.types.id == 5)
                          CustomStatus(
                              size,
                              Color.fromARGB(255, 252, 209, 203),
                              Colors.red,
                              "assets/134878-warning-status.json",
                              value.getAsignHomeModel!.types.ps_type,
                              "your account hase been Legal status")
                        else if (value.getAsignHomeModel!.types.id == 6)
                          CustomStatus(
                              size,
                              Color.fromARGB(255, 252, 209, 203),
                              Colors.red,
                              "assets/77333-error-close-remove-delete-warning-alert.json",
                              value.getAsignHomeModel!.types.ps_type,
                              "your account hase been Denied status")
                        else
                          CustomStatus(
                              size,
                              Color.fromARGB(255, 203, 252, 204),
                              Colors.green,
                              "assets/134878-warning-status.json",
                              value.getAsignHomeModel!.types.ps_type,
                              "your account hase been Closed status"),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Basic details",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              customTextField(
                                MaterialCommunityIcons.account_outline,
                                "Name",
                                "Name",
                                false,
                                false,
                                value.nameController,
                                (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter name");
                                  }
                                  return null;
                                },
                                false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              customTextField(
                                MaterialCommunityIcons.email_outline,
                                "Email Address",
                                "Email Address",
                                false,
                                true,
                                value.emailController,
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
                                height: 10,
                              ),
                              customTextField(
                                MaterialCommunityIcons.phone_outline,
                                "Mobile Number",
                                "Mobile Number",
                                true,
                                false,
                                value.phoneController,
                                (value) {
                                  if (value!.isEmpty) {
                                    return ("Please enter mobile number");
                                  }
                                  if (!RegExp(r'(^(?:[+0]9)?[0-9]{10}$)')
                                      .hasMatch(value)) {
                                    return ("Please Enter a valid phone number");
                                  }
                                  return null;
                                  // return null;
                                },
                                false,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              value.isLoading
                                  ? Container(
                                      height: 38,
                                      width: size.width / 5,
                                      // width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(.3),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Center(
                                        child: CustomLoader(loadertype: false),
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.purple,
                                        onPrimary: Colors.white,
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          value.updateCustomer(
                                            context,
                                            _formKey,
                                            value.getCustomer,
                                          );
                                        }
                                      },
                                      child: Text(
                                        "Update",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (value.getAsignHomeModel != null)
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 15,
                                  spreadRadius: 1,
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Home details",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                customTextField(
                                  CupertinoIcons.building_2_fill,
                                  "Tower name",
                                  "Tower name",
                                  false,
                                  true,
                                  value.towerController,
                                  (value) {
                                    if (value!.isEmpty) {
                                      return ("Please enter email");
                                    }
                                    return null;
                                  },
                                  true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                customTextField(
                                  CupertinoIcons.layers,
                                  "Floor Name",
                                  "Floor Name",
                                  false,
                                  false,
                                  value.floorController,
                                  (value) {
                                    if (value!.isEmpty) {
                                      return ("Please enter first name");
                                    }
                                    return null;
                                  },
                                  true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                customTextField(
                                  CupertinoIcons.house,
                                  "Home Name",
                                  "Home Name",
                                  false,
                                  false,
                                  value.homeController,
                                  (value) {
                                    if (value!.isEmpty) {
                                      return ("Please enter first name");
                                    }
                                    return null;
                                  },
                                  true,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
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

  Column CustomStatus(
    Size size,
    Color bColor,
    Color sColor,
    String icon_name,
    String title,
    String subtitle,
  ) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: size.width,
          decoration: BoxDecoration(
              color: bColor,
              // color: Color.fromARGB(255, 253, 241, 204),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Lottie.asset(
                      icon_name,
                      width: 70,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Status",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: sColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 10),
                            child: Text(
                              title,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
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

  Future<void> _showChoiceDialognew(
      BuildContext context, CustomerProvider value) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () => {value.nicFront(ImageSource.gallery)},
                    // onTap: () => getnewImage(source: ImageSource.gallery),
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () => {},
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.purple,
      elevation: 0,
      title: const Text(
        "Profile",
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
