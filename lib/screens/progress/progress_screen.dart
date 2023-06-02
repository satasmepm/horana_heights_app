import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:horana_heights/screens/progress/progress_details_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../controller/progress_controller.dart';
import '../../model/progress_model.dart';
import '../../utils/util_functions.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text(
          "Progress",
          style: TextStyle(fontSize: 14, color: Colors.white),
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
            child: StreamBuilder<List<ProgressModel>>(
              stream: ProgressController().fetchItems(
                  value.getCustomer!.cus_nic,
                  value.getAsignHomeModel!.home.id.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<ProgressModel> items = snapshot.data!;
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.grey,
                        height: 1,
                      );
                    },
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final ProgressModel item = items[index];
                      return ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color.fromARGB(255, 245, 235, 177)),
                          child: const Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              CupertinoIcons.checkmark_alt_circle_fill,
                              color: Color.fromARGB(255, 226, 186, 67),
                            ),
                          ),
                        ),
                        title: Text(item.pr_date),
                        subtitle: Text(item.pr_remark),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: ProgressDetailsScreen(
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
                    baseColor: const Color.fromARGB(255, 182, 182, 182),
                    highlightColor: const Color.fromARGB(255, 219, 219, 219),
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
