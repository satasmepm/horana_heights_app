import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horana_heights/provider/customer_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import '../../controller/progress_controller.dart';
import '../../model/progress_model.dart';
import '../../utils/util_functions.dart';

class ProgressDetailsScreen extends StatefulWidget {
  final String selectedIndex;
  const ProgressDetailsScreen({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<ProgressDetailsScreen> createState() => _ProgressDetailsScreenState();
}

class _ProgressDetailsScreenState extends State<ProgressDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          elevation: 0,
          title: const Text(
            "Progress Details Screen",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          leading: Container(
            margin: const EdgeInsets.all(10),
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
            return StreamBuilder<ProgressModel>(
              stream: Stream.periodic(const Duration(seconds: 0)).asyncMap(
                  (_) => ProgressController().fetchItem(
                      value.getCustomer!.cus_nic, widget.selectedIndex)),
              builder: (BuildContext context,
                  AsyncSnapshot<ProgressModel> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                ProgressModel item = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://satasmeappdev.shop/uploads/progress/" +
                          item.pr_image,
                      width: size.width,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;

                        return SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: size.width,
                            height: 250,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, right: 15, left: 15, bottom: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item.pr_date,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item.pr_remark,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
