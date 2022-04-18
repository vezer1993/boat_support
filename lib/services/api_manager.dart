import 'dart:io' as io;
import 'dart:typed_data';

import 'package:boat_support/dialogs/boat_pick.dart';
import 'package:boat_support/models/check_in_model.dart';
import 'package:flutter/material.dart';

import 'package:boat_support/constants/strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

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
    String problem = "hi";

    try {
      var client = http.Client();
      var url = Uri.https(Strings.main_page, Strings.yachts_url);
      var response = await client.get(url, headers: Strings.headers);
      if (response.statusCode == 200) {
        var jsonvar = response.body;
        boatList = json.decode(jsonvar);
      }
    } on Exception catch (err) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("My title"),
            content: Text(err.toString(),
              style: TextStyle(
                  color: Colors.black
              ),),
          );;
        },
      );
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
      message.attachments.add(FileAttachment(io.File(images[i].toString())));
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

  void CompleteCheckInReport(CheckInModel model, Uint8List? signature) async{

    //print
    print("step1");
    String excelPath = await CreateCheckInReport(model, signature);
    print("step2 + $excelPath");

    String username = Strings.email_username;
    String password = Strings.email_password;

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'karlo')
      ..recipients.add('karlo.santini@gmail.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    message.attachments.add(FileAttachment(io.File(excelPath)));

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. '+ e.message);
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  Future<String> CreateCheckInReport(CheckInModel model, Uint8List? signature) async{

    Workbook workbook = Workbook();
    Map boat = await getBoatInfo();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.name = "Check In";
    final String signatureImage = base64.encode(signature!);

    //title

    //title style
    Style titleStyle = workbook.styles.add('style');
    titleStyle.fontSize = 15;
    titleStyle.bold = true;
    titleStyle.vAlign = VAlignType.center;
    titleStyle.hAlign = HAlignType.center;

    //title cells
    Range titleRange = sheet.getRangeByName('A1:H3');
    titleRange.merge();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd.mm.yyyy').format(now);
    titleRange.setText(boat["name"].toString() + " CHECK IN - " + formattedDate);
    titleRange.cellStyle = titleStyle;


    //Correct
    Style correctStyle = workbook.styles.add('style1');
    correctStyle.fontSize = 13;
    correctStyle.bold = true;
    correctStyle.vAlign = VAlignType.center;
    correctStyle.hAlign = HAlignType.center;
    correctStyle.borders.bottom.lineStyle = LineStyle.thin;
    correctStyle.backColorRgb = const Color.fromARGB(255, 201, 218, 248);

    //Correct cells
    Range correctRange = sheet.getRangeByName('J1:K3');
    correctRange.merge();
    correctRange.setText("CORRECT");
    correctRange.cellStyle = correctStyle;

    //Incorrect
    Style incorrectStyle = workbook.styles.add('style2');
    incorrectStyle.fontSize = 13;
    incorrectStyle.bold = true;
    incorrectStyle.vAlign = VAlignType.center;
    incorrectStyle.hAlign = HAlignType.center;
    incorrectStyle.borders.bottom.lineStyle = LineStyle.thin;
    incorrectStyle.backColorRgb = const Color.fromARGB(255, 252, 229, 205);

    //Correct cells
    Range incorrectRange = sheet.getRangeByName('L1:M3');
    incorrectRange.merge();
    incorrectRange.setText("INCORRECT");
    incorrectRange.cellStyle = incorrectStyle;

    //check list
      //first row style
    Style firstRowStyle = workbook.styles.add('style3');
    firstRowStyle.fontSize = 13;
    firstRowStyle.bold = true;
    firstRowStyle.vAlign = VAlignType.center;
    firstRowStyle.hAlign = HAlignType.left;
    firstRowStyle.backColorRgb = const Color.fromARGB(255, 255, 242, 204);
    firstRowStyle.borders.all.lineStyle = LineStyle.thin;

      //second row style
    Style secondRowStyle = workbook.styles.add('style4');
    secondRowStyle.fontSize = 13;
    secondRowStyle.bold = true;
    secondRowStyle.vAlign = VAlignType.center;
    secondRowStyle.hAlign = HAlignType.left;
    secondRowStyle.borders.all.lineStyle = LineStyle.thin;

    int row = 5;

    int lastSheet = 0;

    int i = 1;
    for (i; i < model.checklist.length; i++,row++){
      Range rowRange = sheet.getRangeByName('A$row:I$row');
      rowRange.merge();
      if(row % 2 != 0){
        rowRange.cellStyle = firstRowStyle;
      }else{
        rowRange.cellStyle = secondRowStyle;
      }

      rowRange.text = model.checklist[i].name;

      Range correctCells = sheet.getRangeByName('J$row:K$row');
      correctCells.merge();
      correctCells.cellStyle = correctStyle;

      Range incorrectCells = sheet.getRangeByName('L$row:M$row');
      incorrectCells.merge();
      incorrectCells.cellStyle = incorrectStyle;

      if(model.checklist[i].acknowledgment){
        correctCells.text = "X";
      }else{
        lastSheet++;
        incorrectCells.text = "X - issue$lastSheet";
        Worksheet issueSheet = workbook.worksheets.addWithName("issue$lastSheet");
        
        Range issueRange = issueSheet.getRangeByName("A1:M6");
        issueRange.merge();
        issueRange.text = model.checklist[i].problem;

        Range issueRange2 = issueSheet.getRangeByName("A7:M7");
        issueRange2.merge();
        issueRange2.text = model.checklist[i].images[0];
      }
    }


    row = row + 2;
    sheet.pictures.addBase64(row, 4, signatureImage);




    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final io.File file = io.File(fileName);
    await file.writeAsBytes(bytes, flush: true);


    return fileName;
  }

  Future<Map> getBoatInfo() async{
    final prefs = await SharedPreferences.getInstance();
    final String? prefs_boat = prefs.getString(
        Strings.selected_boat_preferences_key);

    return jsonDecode(prefs_boat!);
  }

  Future<List<int>> _readImageData(String name) async {
    final ByteData data = await rootBundle.load('images/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}