import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:horana_heights/screens/payment/payment_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../controller/payment_controller.dart';
import '../../model/payment_model.dart';
import '../../utils/util_functions.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0,
          title: const Text(
            "Payments",
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
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
          ),
        ),
        body: Consumer<CustomerProvider>(
          builder: (context, value, child) {
            return Container(
              child: StreamBuilder<List<PaymentModel>>(
                stream: PaymentController().fetchPayments(
                    value.getCustomer!.cus_nic,
                    value.getAsignHomeModel!.home.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<PaymentModel> items = snapshot.data!;
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                          height: 1,
                        );
                      },
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final PaymentModel item = items[index];
                        return ListTile(
                          leading: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromARGB(255, 177, 245, 186)),
                            child: const Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                CupertinoIcons.checkmark_alt_circle_fill,
                                color: Color.fromARGB(255, 39, 131, 59),
                              ),
                            ),
                          ),
                          title: Row(
                            children: [
                              const Text(
                                "Payment date :",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                item.pd_collection_date,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              const Text("Amount : "),
                              Container(
                                // height: 10,
                                // width: 10,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Text(
                                    "Rs",
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                item.pd_amount,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: PaymentDetailsScreen(
                                          selectedIndex: item.id.toString()),
                                      inheritTheme: true,
                                      ctx: context),
                                );
                              },
                              icon: Icon(CupertinoIcons.chevron_forward)),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner
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
        ));
  }

  Padding CustomShimmerTile() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
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
          )
        ],
      ),
    );
  }
}
