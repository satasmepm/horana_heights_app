import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PasswordResetController {
  Future<String> sendEmail(BuildContext context, String email) async {
    var url = "https://satasmeappdev.shop/api/sendEmail";
    var body = null;
    String result = "fail";
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_email": email,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);

        print("^^^^^^^^^^^^ : " + body["data"].toString());
        if (body["code"] == 200) {
          result = body["data"];
        } else if (body["code"] == 500) {
          result = body["data"];
        }
      } else {}
    } on SocketException {}
    return result;
  }

  Future<String> checkCode(
      BuildContext context, String code, String email) async {
    var url = "https://satasmeappdev.shop/api/checkCode";
    var body = null;
    String result = "fail";
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_code": code,
        "cus_email": email,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);
        if (body["code"] == 200) {
          result = body["data"];
        } else {}
      } else {}
    } on SocketException {}
    return result;
  }

  Future<String> checkNewPasswords(
      BuildContext context, String password, String email) async {
    var url = "https://satasmeappdev.shop/api/check_confirm_password";
    var body = null;
    String result = "fail";
    try {
      final response = await http.post(Uri.parse(url), body: {
        "cus_password": password,
        "cus_email": email,
      }).timeout(Duration(seconds: 10));

      if (response.statusCode == 200) {
        body = json.decode(response.body);
        if (body["code"] == 200) {
          result = body["data"];
        } else {}
      } else {}
    } on SocketException {}
    return result;
  }
}
