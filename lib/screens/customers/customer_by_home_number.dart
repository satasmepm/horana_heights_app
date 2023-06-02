import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../controller/house_controller.dart';
import '../../model/objects.dart';
import '../../utils/constatnt.dart';
import 'installment_by_id_screen.dart';

class CustomerByHomeNumberScreen extends StatefulWidget {
  final String selectedIndex;
  const CustomerByHomeNumberScreen({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<CustomerByHomeNumberScreen> createState() =>
      _CustomerByHomeNumberScreenState();
}

class _CustomerByHomeNumberScreenState
    extends State<CustomerByHomeNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  var top = 0.0;
  late ScrollController _scrolController;
  HouseController _userService = HouseController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrolController = ScrollController();

    // Provider.of<UserProvider>(context, listen: false).checkUserUpdate(context);
    _scrolController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrolController,
            slivers: [
              SliverAppBar(
                pinned: true,
                leading: AnimatedOpacity(
                  opacity: top <= 130 ? 0.2 : 1.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    color: Colors.black,
                  ),
                  duration: const Duration(milliseconds: 300),
                ),
                expandedHeight: 250,
                flexibleSpace: Consumer<CustomerProvider>(
                  builder: (context, value, child) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        top = constraints.biggest.height;
                        return FlexibleSpaceBar(
                          centerTitle: true,
                          title: AnimatedOpacity(
                            opacity: top <= 130 ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                ),
                              ],
                            ),
                          ),
                          background: Image.asset("assets/avatar.jpg"),
                        );
                      },
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: Consumer<CustomerProvider>(
                builder: (context, value, child) {
                  return Container(
                    color: const Color(0xFFECF3F9),
                    // height: size.height,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            StreamBuilder<AsignHomeModel>(
                              stream: _userService.asigHomeBySelectedHome(
                                  context,
                                  value.getCustomer!.cus_nic,
                                  widget.selectedIndex),
                              // Replace with your API stream
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data!;
                                  final towerName = data.tower.tower_name;
                                  final floorName = data.floor.floor_number;
                                  final homeNumber = data.home.home_number;
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (data.types.id == 1)
                                        CustomStatus(
                                            size,
                                            Color.fromARGB(255, 203, 252, 204),
                                            Colors.green,
                                            "assets/80476-success-animation-var-1.json",
                                            data.types.ps_type,
                                            "your account hase been Open status")
                                      else if (data.types.id == 2)
                                        CustomStatus(
                                            size,
                                            Color.fromARGB(255, 252, 241, 203),
                                            Colors.amber,
                                            "assets/134878-warning-status.json",
                                            data.types.ps_type,
                                            "your account hase been default status")
                                      else if (data.types.id == 3)
                                        CustomStatus(
                                            size,
                                            Color.fromARGB(255, 252, 241, 203),
                                            Colors.amber,
                                            "assets/134878-warning-status.json",
                                            data.types.ps_type,
                                            "your account hase been Fraud status")
                                      else if (data.types.id == 4)
                                        CustomStatus(
                                            size,
                                            Color.fromARGB(255, 203, 252, 204),
                                            Colors.amber,
                                            "assets/134878-warning-status.json",
                                            data.types.ps_type,
                                            "your account hase been Investigation status")
                                      else if (data.types.id == 5)
                                        CustomStatus(
                                            size,
                                            Color.fromARGB(255, 252, 209, 203),
                                            Colors.red,
                                            "assets/134878-warning-status.json",
                                            data.types.ps_type,
                                            "your account hase been Legal status")
                                      else if (data.types.id == 6)
                                        CustomStatus(
                                            size,
                                            Color.fromARGB(255, 252, 209, 203),
                                            Colors.red,
                                            "assets/77333-error-close-remove-delete-warning-alert.json",
                                            data.types.ps_type,
                                            "your account hase been Denied status")
                                      else
                                        CustomStatus(
                                            size,
                                            Color.fromARGB(255, 203, 252, 204),
                                            Colors.green,
                                            "assets/134878-warning-status.json",
                                            data.types.ps_type,
                                            "your account hase been Closed status"),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Payment Details",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            InkWell(
                                              child: const Icon(CupertinoIcons
                                                  .chart_bar_alt_fill),
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: InstallmentByID(
                                                          home_id: data.home.id,
                                                          cus_id:
                                                              data.customer.id,
                                                          cus_nic: data
                                                              .customer.cus_nic,
                                                          asignHomeModel: data),
                                                      inheritTheme: true,
                                                      ctx: context),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Customer details",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              customTextField(
                                                CupertinoIcons.building_2_fill,
                                                "Customer name",
                                                "Customer name",
                                                false,
                                                true,
                                                data.customer.cus_name,
                                                (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please enter email");
                                                  }
                                                  return null;

                                                  // return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              customTextField(
                                                MaterialCommunityIcons
                                                    .email_outline,
                                                "Email Address",
                                                "Email Address",
                                                false,
                                                true,
                                                data.customer.cus_email,
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
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              customTextField(
                                                MaterialCommunityIcons
                                                    .phone_outline,
                                                "Mobile Number",
                                                "Mobile Number",
                                                true,
                                                false,
                                                data.customer.cus_phone,
                                                (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please enter mobile number");
                                                  }
                                                  if (!RegExp(
                                                          r'(^(?:[+0]9)?[0-9]{10}$)')
                                                      .hasMatch(value)) {
                                                    return ("Please Enter a valid phone number");
                                                  }
                                                  return null;
                                                  // return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              customTextField(
                                                MaterialCommunityIcons
                                                    .account_outline,
                                                "NIC Number",
                                                "NIC Number",
                                                true,
                                                false,
                                                data.customer.cus_nic,
                                                (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please enter Home number");
                                                  }
                                                  if (!RegExp(
                                                          r'(^(?:[+0]9)?[0-9]{10}$)')
                                                      .hasMatch(value)) {
                                                    return ("Please Enter a NIC number");
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              customTextField(
                                                MaterialCommunityIcons
                                                    .home_outline,
                                                "Address",
                                                "Address",
                                                true,
                                                false,
                                                data.customer.cus_address,
                                                (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please enter address");
                                                  }

                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Home details",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
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
                                                towerName,
                                                (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please enter email");
                                                  }
                                                  return null;
                                                },
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
                                                floorName,
                                                (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please enter first name");
                                                  }
                                                  return null;

                                                  // return null;
                                                },
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
                                                homeNumber,
                                                (value) {
                                                  if (value!.isEmpty) {
                                                    return ("Please enter first name");
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
            ],
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
    String controller,
    String? Function(String?)? validator,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
              obscureText: false,
              initialValue: controller,
              keyboardType:
                  isEmail ? TextInputType.emailAddress : TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 243, 245, 247),
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
}
