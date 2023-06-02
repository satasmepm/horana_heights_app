import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:horana_heights/screens/progress/progress_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../controller/payment_controller.dart';
import '../../model/progress_model.dart';
import '../../utils/util_functions.dart';

class TestHomeScreen extends StatefulWidget {
  const TestHomeScreen({Key? key}) : super(key: key);

  @override
  State<TestHomeScreen> createState() => _TestHomeScreenState();
}

class _TestHomeScreenState extends State<TestHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text(
          "Progress",
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
            child: StreamBuilder<List<dynamic>>(
              stream: PaymentController()
                  .fetchInstallemetByHome(value.getCustomer!.cus_nic, "1"),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return SizedBox(
                      width: 200.0,
                      height: 100.0,
                      child: Shimmer.fromColors(
                        baseColor: Colors.red,
                        highlightColor: Colors.yellow,
                        child: const Text(
                          'Shimmer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );

                  default:
                    if (!snapshot.hasData) {
                      return Text("No data");
                    }
                    List<dynamic> payments = snapshot.data!;
                    return ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        // Build the UI for each payment item
                        var payment = payments[index];
                        return ListTile(
                          title: Text(payment[1]),
                          subtitle: Text(payment[4].toString()),
                          trailing: Text(payment[5]),
                        );
                      },
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
