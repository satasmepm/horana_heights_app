import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/screens/payment/payment_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../controller/auth_controller.dart';
import '../../controller/payment_controller.dart';
import '../../provider/customer_provider.dart';
import '../componants/custom_drawer.dart';
import '../notifications/notification_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController _userService = AuthController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const SafeArea(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 10, 8),
                  child: const Icon(
                    CupertinoIcons.bell,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: const NotificationScreen(),
                    inheritTheme: true,
                    ctx: context),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width,
                height: size.height / 10,
                color: Colors.purple,
              ),
            ],
          ),
          Positioned(
            top: 10,
            // bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              child: SlideInDown(
                child: Container(
                    width: size.width - 30,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    //  body: {"cus_nic": "632073428V", "home_id": "3", "cus_id": "39"});
                    child: Consumer<CustomerProvider>(
                      builder: (context, value, child) {
                        return value.getAsignHomeModel != null
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: StreamBuilder<dynamic>(
                                  stream: _userService.fetchHomeCardData(
                                      value.getCustomer!.cus_nic,
                                      value.getAsignHomeModel!.home.id,
                                      value.getCustomer!.id),
                                  // Replace with your API stream
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final data = snapshot.data!;
                                      final down_payment = data['down_payment'];
                                      final remainingPayment =
                                          data['remaining_payment'];
                                      final presentValue = data['present_val'];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 7,
                                                    width: 7,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.lightGreen,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 6,
                                                  ),
                                                  Text(
                                                    "Remaining to be paid",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                "Rs ${remainingPayment}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.3,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Down payment",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "Rs ${down_payment}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: CircularPercentIndicator(
                                                  radius: 35.0,
                                                  lineWidth: 3.5,
                                                  animation: true,
                                                  percent: (presentValue / 100),
                                                  center: Text(
                                                    "${presentValue} %",
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15.0),
                                                  ),
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                  progressColor: Colors.purple,
                                                ),
                                              ),
                                              if (value.getAsignHomeModel !=
                                                  null)
                                                if (value.getAsignHomeModel!.types.id == 1)
                                                  CustomBadge(
                                                      value.getAsignHomeModel!
                                                          .types.ps_type,
                                                      Colors.green)
                                                else if (value.getAsignHomeModel!.types.id ==
                                                    2)
                                                  CustomBadge(
                                                      value.getAsignHomeModel!
                                                          .types.ps_type,
                                                      Colors.amber)
                                                else if (value.getAsignHomeModel!
                                                        .types.id ==
                                                    3)
                                                  CustomBadge(
                                                      value.getAsignHomeModel!
                                                          .types.ps_type,
                                                      Colors.amber)
                                                else if (value.getAsignHomeModel!
                                                        .types.id ==
                                                    4)
                                                  CustomBadge(
                                                      value.getAsignHomeModel!
                                                          .types.ps_type,
                                                      Colors.red)
                                                else if (value.getAsignHomeModel!
                                                        .types.id ==
                                                    5)
                                                  CustomBadge(
                                                      value.getAsignHomeModel!
                                                          .types.ps_type,
                                                      Colors.red)
                                                else if (value
                                                        .getAsignHomeModel!
                                                        .types
                                                        .id ==
                                                    6)
                                                  CustomBadge(value.getAsignHomeModel!.types.ps_type, Colors.red)
                                                else
                                                  CustomBadge(value.getAsignHomeModel!.types.ps_type, Colors.blue),
                                            ],
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Center(
                                        child: Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                              255, 182, 182, 182),
                                          highlightColor: const Color.fromARGB(
                                              255, 219, 219, 219),
                                          child: Column(
                                            children: [
                                              CustomShimmerCard(),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                            : const Center(child: CircularProgressIndicator());
                      },
                    )),
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            child: Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Details",
                          style:
                              GoogleFonts.poppins(fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          child: Icon(CupertinoIcons.chart_bar_alt_fill),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: PaymentScreen(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // width: size.width - 30,
                    height: size.height / 1.4,
                    child: Consumer<CustomerProvider>(
                      builder: (context, value, child) {
                        return value.getAsignHomeModel != null
                            ? Container(
                                child: StreamBuilder<List<dynamic>>(
                                  stream: PaymentController()
                                      .fetchInstallemetByHome(
                                          value.getCustomer!.cus_nic,
                                          value.getAsignHomeModel!.home.id
                                              .toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<dynamic> payments = snapshot.data!;

                                      return ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          separatorBuilder: (context, index) {
                                            return const SizedBox(
                                              height: 0,
                                            );
                                          },
                                          itemCount: payments.length,
                                          itemBuilder: (context, index) {
                                            var payment = payments[index];
                                            // final NotificationModel item = items[index];
                                            if (payments[0][0] != "NO DATA") {
                                              return listCard(size, payment);
                                            } else {
                                              return Center(
                                                  child: Text(payments[0][0]));
                                            }
                                          });
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }

                                    // By default, show a loading spinner
                                    return Center(
                                      child: Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 182, 182, 182),
                                        highlightColor:
                                            Color.fromARGB(255, 219, 219, 219),
                                        child: Column(
                                          children: [
                                            CustomShimmerTile(),
                                            CustomShimmerTile(),
                                            CustomShimmerTile(),
                                            CustomShimmerTile(),
                                            CustomShimmerTile(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container CustomBadge(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }

  GestureDetector listCard(Size size, dynamic payment) {
    String originalDate = payment[5].toString();

    DateTime dateTime = DateTime.parse(originalDate);

    String formattedDate =
        DateFormat('MMM dd, yyyy hh:mm:ss a').format(dateTime);
    return GestureDetector(
      onTap: () {},
      child: GestureDetector(
        onTap: () {},
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey.withOpacity(0.08),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  //Center(child: CircularProgressIndicator()),
                  SizedBox(
                    width: size.width / 1,
                    // height: size.height / 9,
                    child: const ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                  ),

                  Container(
                    // height: 140,
                    width: size.width / 1.1,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: size.width / 1.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  payment[1],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Installment amount : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      payment[2].toString(),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Remaining : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      payment[3].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Balance : ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      payment[4].toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Pay date : ",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      payment[5].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "Pay amount : ",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Text(
                                      payment[6].toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          LeadingIcon(
                              const Color.fromARGB(255, 211, 252, 214),
                              CupertinoIcons.check_mark_circled_solid,
                              Colors.lightGreen)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, right: 10, bottom: 0, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container LeadingIcon(Color color, IconData iconname, Color icon_color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              spreadRadius: 1),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          iconname,
          color: icon_color,
        ),
      ),
    );
  }

  Padding CustomShimmerTile() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 252, 214),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: Colors.lightGreen,
            ),
          ),
        ],
      ),
    );
  }

  Padding CustomShimmerCard() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 30.0,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                Container(
                  width: 30.0,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.0),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 211, 252, 214),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: const Icon(
              CupertinoIcons.check_mark_circled_solid,
              color: Colors.lightGreen,
            ),
          ),
        ],
      ),
    );
  }
}
