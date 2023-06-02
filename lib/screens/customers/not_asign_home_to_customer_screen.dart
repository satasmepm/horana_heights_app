import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../utils/util_functions.dart';

class NotAssignHomeToCustomerScreen extends StatelessWidget {
  const NotAssignHomeToCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 8),
        child: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0,
          title: Text("Assign home"),
          leading: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purple,
            ),
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
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: SizedBox(
              height: 100,
              child: Center(
                child: Lottie.asset(
                  "assets/134878-warning-status.json",
                  width: 100,
                ),
              ),
            ),
          ),
          const Text('No Assigned Home'),
          const Text('There is no assigned home for the selected customer.'),
        ],
      ),
    );
  }
}
