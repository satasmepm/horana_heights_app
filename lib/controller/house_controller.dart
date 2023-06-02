import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:horana_heights/model/objects.dart';

class HouseController {
  static Future<List<Map<String, dynamic>>> getAllFloors(
      String nic, String tower_id) async {
    final response = await http.post(
      Uri.parse('https://satasmeappdev.shop/api/get_all_floors'),
      body: {
        "cus_nic": nic,
        "tower_id": tower_id,
      },
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body["data"];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }

  static Future<List<Map<String, dynamic>>> getAllHomes(
      String nic, String floor_id) async {
    final response = await http.post(
      Uri.parse('https://satasmeappdev.shop/api/get_all_homes'),
      body: {
        "cus_nic": nic,
        "floor_id": floor_id,
      },
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body["data"];
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }

  Stream<AsignHomeModel> asigHomeBySelectedHome(
      BuildContext context, String nic, String id) async* {
    AsignHomeModel asignhomeModel = AsignHomeModel(
      id: 0,
      ah_reserve_date: "",
      ah_agreement: "",
      ah_reserve_recipt: "",
      ah_remark: "",
      types: PaymentStatusModel(id: 0, ps_type: ""),
      ah_down_payment: "",
      status: "0",
      tower: TowerModel(
          id: 0,
          tower_name: "",
          tower_location: "",
          tower_image: "null",
          status: "0",
          created_at: "",
          updated_at: ""),
      floor: FloorModel(
        id: 0,
        tower_id: "",
        floor_number: "",
        status: "0",
        created_at: "",
        updated_at: "",
      ),
      home: HomeModel(
        id: 0,
        tower_id: "",
        floor_id: "",
        home_number: "",
        status: "0",
        created_at: "",
        updated_at: "",
      ),
      customer: CustomerModel(
        id: 0,
        cus_name: "",
        cus_nic: "",
        cus_address: "",
        cus_phone: "",
        cus_email: "",
        cus_password: "",
        cus_image: "null",
        cus_auth_token: "",
        cus_token: "null",
        role_id: '0',
        status: "0",
        created_at: "null",
        updated_at: "null",
      ),
      created_at: "",
      updated_at: "",
    );

    var url =
        "https://satasmeappdev.shop/api/get_customer_asign_home_by_home_id";
    var body = null;
    int maxRetries = 3;
    int currentRetry = 0;

    while (currentRetry < maxRetries) {
      try {
        final response = await http.post(Uri.parse(url), body: {
          "cus_nic": nic,
          "home_id": id,
        }).timeout(Duration(seconds: 10));

        if (response.statusCode == 200) {
          body = json.decode(response.body);

          if (body["data"] != null) {
            final data = body["data"];
            final item = AsignHomeModel.fromJson(data);
            yield item;
            return; // Exit the function after successful response
          }
        } else if (response.statusCode == 429) {
          // Retry after waiting for a specified duration
          await Future.delayed(
              Duration(seconds: 5)); // Wait for 5 seconds before retrying
        } else {
          throw Exception('Failed to fetch item: ${response.statusCode}');
        }
      } on SocketException {
        // Handle socket exception, e.g., display an error message to the user
      }

      currentRetry++;
    }
  }

  Future<String> isAvailableHome(
      BuildContext context, String nic, String home_id) async {
    var url = "https://satasmeappdev.shop/api/is_available_home";
    var body = null;
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_nic": nic,
        "home_id": home_id,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);
        return body["data"].toString();
      } else {}
    } on SocketException {}
    return "false";
  }

  Stream<List<TowerModel>> getAllTowers(String cus_nic) async* {
    var url = "https://satasmeappdev.shop/api/get_all_towers";
    int maxRetries = 3;
    int currentRetry = 0;

    while (currentRetry < maxRetries) {
      try {
        final response =
            await http.post(Uri.parse(url), body: {"cus_nic": cus_nic});

        if (response.statusCode == 200) {
          final body = json.decode(response.body);

          final List<dynamic> data = body["data"];
          final List<TowerModel> items =
              data.map((item) => TowerModel.fromJson(item)).toList();
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

  Future<String> isAvailableCustomer(
      BuildContext context, String nic, String cus_id) async {
    var url = "https://satasmeappdev.shop/api/is_available_customer";
    var body = null;
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_nic": nic,
        "cus_id": cus_id,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);
        return body["data"].toString();
      } else {}
    } on SocketException {}
    return "false";
  }
}
