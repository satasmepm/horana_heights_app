import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/model/objects.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../../controller/house_controller.dart';
import '../Profile/profile_screen.dart';
import '../componants/custom_drawer.dart';
import '../customers/search_customers.dart';
import '../customers/search_floor_by_towerid_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFECF3F9),
      drawer: const SafeArea(
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(
            color: Colors.white), // Set the desired color here

        elevation: 0,
        title: const Text(
          "Admin home",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Consumer<CustomerProvider>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width - 85,
                                    child: RichText(
                                      maxLines: 1,
                                      text: TextSpan(children: [
                                        TextSpan(
                                          text: "Welcome ",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                        TextSpan(
                                          text: value.getCustomer!.cus_name,
                                          style: const TextStyle(
                                            color: Colors.amber,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                  Text(
                                    "Find details using customer",
                                    style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: const Color.fromARGB(
                                            255, 209, 208, 208)),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: ProfileScreen(),
                                        inheritTheme: true,
                                        ctx: context),
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, right: 20.0),
                                    child: Hero(
                                      tag: 'profile-img',
                                      child: CircleAvatar(
                                        radius: 22,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(55),
                                          child: value.getCropImg.path == ""
                                              ? (value.getCustomer != null &&
                                                      (value.getCustomer!
                                                              .cus_image !=
                                                          "null"))
                                                  ? CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage: NetworkImage(
                                                          "https://satasmeappdev.shop/uploads/customers/" +
                                                              value.getCustomer!
                                                                  .cus_image),
                                                    )
                                                  : const CircleAvatar(
                                                      radius: 50,
                                                      backgroundImage: AssetImage(
                                                          'assets/avatar.jpg'),
                                                    )
                                              : CircleAvatar(
                                                  backgroundImage: FileImage(
                                                    File(value.getCropImg.path),
                                                  ),
                                                  radius: 50,
                                                ),
                                          //  Image.asset(value.getImageFile!.path),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 42,
                        child: TextField(
                          readOnly: true,
                          cursorColor: Colors.black,
                          maxLines: 1,
                          style: const TextStyle(fontSize: 17),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.search,
                                color: Theme.of(context).iconTheme.color),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            // fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.zero,
                            hintText: 'Search....',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: const SeachCustomersScreen(),
                                  inheritTheme: true,
                                  ctx: context),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "Select Tower",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 320,
                child: course(),
              ),
            ]),
      ),
    );
  }

  Widget course() {
    return Consumer<CustomerProvider>(
      builder: (context, value, child) {
        return StreamBuilder<List<TowerModel>>(
          stream: HouseController().getAllTowers(value.getCustomer!.cus_nic),
          builder:
              (BuildContext context, AsyncSnapshot<List<TowerModel>> snapshot) {
            if (snapshot.hasData) {
              final towerList = snapshot.data;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: towerList!.length,
                itemBuilder: (BuildContext context, int index) {
                  final towers = towerList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 180,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: SeachFloorByTowerScreen(
                                        selectedIndex: towers.id.toString()),
                                    inheritTheme: true,
                                    ctx: context),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.network(
                                "https://satasmeappdev.shop/uploads/towers/" +
                                    towers.tower_image,
                                width: 180,
                                //   // height: height,
                                fit: BoxFit.fill,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;

                                  return const SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 55,
                              width: 260,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 236,
                                          height: 25,
                                          child: Text(
                                            towers.tower_name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          towers.tower_location,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
