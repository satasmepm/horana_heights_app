import 'package:horana_heights/model/progress_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgressController {
  Stream<List<ProgressModel>> fetchItems(
      String cus_nic, String home_id) async* {
    var url = "https://satasmeappdev.shop/api/get_progress_by_home_id";

    final response = await http
        .post(Uri.parse(url), body: {"cus_nic": cus_nic, "home_id": home_id});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      final List<dynamic> data = body["data"];
      final List<ProgressModel> items =
          data.map((item) => ProgressModel.fromJson(item)).toList();
      yield items;
    } else {
      throw Exception('Failed to fetch items');
    }
  }

  Future<ProgressModel> fetchItem(String nic, String id) async {
    var url = "https://satasmeappdev.shop/api/get_progress_by_id";

    final response = await http
        .post(Uri.parse(url), body: {"cus_nic": nic, "pr_id": id.toString()});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);

      Map<String, dynamic> _token = body["data"];

      // ProgressModel.fromJson(_token);
      return ProgressModel.fromJson(_token);
    } else {
      throw Exception('Failed to load item');
    }
  }
}
