import 'dart:io';
import 'package:horana_heights/model/objects.dart';
import 'package:horana_heights/model/progress_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationController {
  Stream<List<NotificationModel>> fetchItems(
      String cus_nic, String home_id) async* {
    var url = "https://satasmeappdev.shop/api/get_notifications";
    int maxRetries = 3;
    int currentRetry = 0;

    while (currentRetry < maxRetries) {
      try {
        final response =
            await http.post(Uri.parse(url), body: {"cus_nic": cus_nic});

        if (response.statusCode == 200) {
          final body = json.decode(response.body);

          final List<dynamic> data = body["data"];
          final List<NotificationModel> items =
              data.map((item) => NotificationModel.fromJson(item)).toList();
          yield items;
          return; // Exit the function after successful response
        } else if (response.statusCode == 429) {
          // Retry after waiting for a specified duration
          await Future.delayed(
              Duration(seconds: 5)); // Wait for 5 seconds before retrying
        } else {
          throw Exception('Failed to fetch items: ${response.statusCode}');
        }
      } on SocketException {
        // Handle socket exception, e.g., display an error message to the user
      }

      currentRetry++;
    }
  }

  Future<ProgressModel> fetchItem(String id) async {
    var url = "https://satasmeappdev.shop/api/get_progress_by_id";

    final response = await http.post(Uri.parse(url),
        body: {"cus_nic": "892073428V", "pr_id": id.toString()});

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      Map<String, dynamic> _token = body["data"];
      return ProgressModel.fromJson(_token);
    } else {
      throw Exception('Failed to load item');
    }
  }
}
