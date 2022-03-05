import 'dart:io';

import 'package:boat_support/dialogs/boat_pick.dart';
import 'package:flutter/material.dart';

import 'package:boat_support/constants/strings.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class api_manager {

  Future getBoats(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String? prefs_boat = prefs.getString(
        Strings.selected_boat_preferences_key);

    if (prefs_boat != null) {
      Map valueMap = jsonDecode(prefs_boat);
      return valueMap;
    } else {
      returnBoatDialog(context);
    }
  }

  void returnBoatDialog(BuildContext context) async {
    List<dynamic> boatList = [];
    var client = http.Client();

    var url = Uri.https(Strings.main_page, Strings.yachts_url);
    var response = await client.get(url, headers: Strings.headers);
    if (response.statusCode == 200) {
      var jsonvar = response.body;
      boatList = json.decode(jsonvar);
    }

    showDialog(context: context,
        builder: (BuildContext context) {
          return BoatPick(
            BoatList: boatList,
          );
        }
    );
  }

  void selectBoat(Map<String, dynamic> boat) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        Strings.selected_boat_preferences_key, json.encode(boat));
  }

  void SendIssuereport(List<String> images, String report) async {
    String username = Strings.email_username;
    String password = Strings.email_password;

    final prefs = await SharedPreferences.getInstance();
    final String? prefs_boat = prefs.getString(
        Strings.selected_boat_preferences_key);
    String boatname = "";
    if (prefs_boat != null) {
      Map valueMap = jsonDecode(prefs_boat);
      boatname = valueMap["name"];
    }

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Boat Track')
      ..recipients.add('karlo.santini@gmail.com')
      ..subject = 'Boat ' + boatname + ' Issue Report : ${DateTime.now()}'
      ..text = report.toString();

    for (int i = 0; i < images.length; i++) {
      message.attachments.add(FileAttachment(File(images[i].toString())));
    }

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}