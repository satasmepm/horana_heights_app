import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletons/skeletons.dart';
import '../../controller/payment_controller.dart';
import '../../model/payment_model.dart';
import '../../utils/util_functions.dart';

class SelectedCustomerPaymentDetailsScreen extends StatefulWidget {
  final String selectedIndex;
  final String cus_nic;
  const SelectedCustomerPaymentDetailsScreen(
      {Key? key, required this.selectedIndex, required this.cus_nic})
      : super(key: key);

  @override
  State<SelectedCustomerPaymentDetailsScreen> createState() =>
      _SelectedCustomerPaymentDetailsScreenState();
}

class _SelectedCustomerPaymentDetailsScreenState
    extends State<SelectedCustomerPaymentDetailsScreen> {
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
          "Payments Details Screen",
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
      body: StreamBuilder<PaymentModel>(
        stream: Stream.periodic(Duration(seconds: 0)).asyncMap((_) =>
            PaymentController()
                .fetchPaymentItem(widget.cus_nic, widget.selectedIndex)),
        builder: (BuildContext context, AsyncSnapshot<PaymentModel> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          PaymentModel item = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://satasmeappdev.shop/uploads/payments/" + item.pd_recipt,
                width: size.width,
                fit: BoxFit.fitWidth,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: size.width,
                      height: 250,
                      // height: double.infinity,
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
                      "Payment Date",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      item.pd_collection_date,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Payment amount",
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      item.pd_amount,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
