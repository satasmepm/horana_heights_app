import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:horana_heights/screens/Profile/profile_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../progress/progress_screen.dart';
import 'custom_tile.dart';
import '../../utils/constatnt.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 30,
          child: Row(
            children: [
              Text(
                // "Powerd by satasme holdings (Pvt) Ltd, Sri lanka.",
                "Powerd by satasme holdings (Pvt) Ltd,Sri lanka.",
                style:
                    GoogleFonts.poppins(color: Colors.grey[800], fontSize: 9),
              ),
              const SizedBox(
                width: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset(
                  Constants.imageAsset("satasmelogo.png"),
                  scale: 3,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          child: Consumer<CustomerProvider>(
            builder: (context, value, child) {
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountEmail: const Text(''),
                    decoration: const BoxDecoration(color: Colors.purple),
                    accountName: Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: InkWell(
                            onTap: () {},
                            child: value.getCropImg.path == ""
                                ? (value.getCustomer != null &&
                                        (value.getCustomer!.cus_image !=
                                            "null"))
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage: NetworkImage(
                                            "https://satasmeappdev.shop/uploads/customers/" +
                                                value.getCustomer!.cus_image),
                                      )
                                    : const CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            AssetImage('assets/avatar.jpg'),
                                      )
                                : CircleAvatar(
                                    backgroundImage: FileImage(
                                      File(value.getCropImg.path),
                                    ),
                                    radius: 50,
                                  ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                value.getCustomer!.cus_name,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                value.getCustomer!.cus_email,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomListTile(
                        text: "Profile",
                        iconleading: CupertinoIcons.person,
                        onTap: () async {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ProfileScreen(),
                                inheritTheme: true,
                                ctx: context),
                          );
                        },
                      ),
                      const Divider(height: 15),
                      Consumer<CustomerProvider>(
                        builder: (context, value, child) {
                          return value.getCustomer!.role_id != "2"
                              ? CustomListTile(
                                  text: "Progress",
                                  iconleading: CupertinoIcons.at_circle,
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.rightToLeft,
                                          child: ProgressScreen(),
                                          inheritTheme: true,
                                          ctx: context),
                                    );
                                  },
                                )
                              : SizedBox();
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomListTile(
                        text: "Logout",
                        iconleading: CupertinoIcons.power,
                        onTap: () {
                          Provider.of<CustomerProvider>(context, listen: false)
                              .logOut(context);
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
