import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:horana_heights/model/objects.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../controller/notification_controller.dart';
import '../../provider/customer_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import '../../utils/util_functions.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text(
          "Notifications",
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
      ),
      body: Consumer<CustomerProvider>(
        builder: (context, value, child) {
          return Container(
            child: StreamBuilder<List<NotificationModel>>(
              stream: NotificationController().fetchItems(
                  value.getCustomer!.cus_nic,
                  value.getAsignHomeModel!.home.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<NotificationModel> items = snapshot.data!;

                  return AnimationLimiter(
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 0,
                          );
                        },
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final NotificationModel item = items[index];
                          return AnimationConfiguration.staggeredList(
                            duration: const Duration(milliseconds: 375),
                            position: index,
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: listCard(size, item),
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                  child: Shimmer.fromColors(
                    baseColor: Color.fromARGB(255, 182, 182, 182),
                    highlightColor: Color.fromARGB(255, 219, 219, 219),
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
          );
        },
      ),
    );
  }

  GestureDetector listCard(Size size, NotificationModel data) {
    String originalDate = data.created_at;
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
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: size.width / 1.1,
                                  // height: 35,
                                  child: Text(
                                    data.title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: size.width / 1.1,
                                  child: Text(
                                    data.description,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  timeago.format(dateTime),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                  ),
                                )
                              ],
                            ),
                          ),
                          LeadingIcon(
                              Color.fromARGB(255, 255, 198, 198),
                              CupertinoIcons.exclamationmark_triangle,
                              Colors.red)
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
                  height: 10.0,
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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
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
}
