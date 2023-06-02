import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/payment_model.dart';

class PaymentController {
  Stream<List<PaymentModel>> fetchPayments(
      String cus_nic, String home_id) async* {
    var url = "https://satasmeappdev.shop/api/get_payments_by_home_id";

    final response = await http
        .post(Uri.parse(url), body: {"cus_nic": cus_nic, "home_id": home_id});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      final List<dynamic> data = body["data"];
      final List<PaymentModel> items =
          data.map((item) => PaymentModel.fromJson(item)).toList();
      yield items;
    } else {
      throw Exception('Failed to fetch items');
    }
  }

  Future<PaymentModel> fetchPaymentItem(String nic, String id) async {
    var url = "https://satasmeappdev.shop/api/get_payments_by_id";

    final response = await http
        .post(Uri.parse(url), body: {"cus_nic": nic, "pay_id": id.toString()});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      Map<String, dynamic> _token = body["data"];
      return PaymentModel.fromJson(_token);
    } else {
      throw Exception('Failed to load item');
    }
  }

  Stream<List<dynamic>> fetchInstallemetByHome(
      String nic, String home_id) async* {
    var url = "https://satasmeappdev.shop/api/installemt_by_home_id";

    final response = await http
        .post(Uri.parse(url), body: {"cus_nic": nic, "home_id": home_id});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      List<dynamic> _token = body["data"];

      yield _token;
    } else {
      throw Exception('Failed to load item');
    }
  }
}
