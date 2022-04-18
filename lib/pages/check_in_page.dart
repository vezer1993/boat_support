import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/dialogs/admin_verification.dart';
import 'package:boat_support/dialogs/report_issue.dart';
import 'package:boat_support/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'check_in_procedure.dart';
    
    class check_in_page extends StatefulWidget {
      const check_in_page({Key? key}) : super(key: key);
    
      @override
      _check_in_pageState createState() => _check_in_pageState();
    }
    
    class _check_in_pageState extends State<check_in_page> {

      @override
      void initState(){
        super.initState();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body:Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter:
                ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                image: const AssetImage("assets/images/background_image_2.jpg"),
              ),
            ),
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.

            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 19, 0, 0),
                      child: FutureBuilder (
                          future:  api_manager().getBoats(context),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.data == null){
                              return Text("...");
                            }
                            else{
                              Map boatData = snapshot.data;
                              return Card(
                                color: Colors.transparent,
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height / 7,
                                    width: MediaQuery.of(context).size.width -10,


                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          AutoSizeText(
                                            boatData["name"].toString(),

                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 40,

                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 55.0,
                                            backgroundImage:
                                            NetworkImage(boatData["images"][0]["url"]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                            child: Column(
                                              children: <Widget>[
                                                AutoSizeText(
                                                  boatData["model"].toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  boatData["year"].toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17
                                                  ),
                                                ),
                                                AutoSizeText(
                                                  boatData["company"].toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              );
                            }

                          },
                        ),
                      ),
                    ],


                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: const <Widget>[

                          SizedBox(height: 50,),

                          AutoSizeText(
                            'Check-in \n Here',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,

                            ),
                          ),

                          SizedBox(height: 50,),

                          AutoSizeText(
                            'Help: \n    Marko Matic \n    099 219 392',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 29,

                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,30,0,20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 10,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CheckIn()),
                                  );
                                },
                                child: const Align(
                                  alignment: Alignment.centerLeft,
                                    child: AutoSizeText("Check in"),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height / 5,),

                          const Align(
                            alignment: Alignment.center,
                              child: AutoSizeText(
                                "Help & Settings",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 30,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height / 10,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context){
                                      return const ReportIssue();
                                    }
                                );
                              },
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText(
                                  ("Report Issue"),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height / 60,),

                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            height: MediaQuery.of(context).size.height / 10,
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context){
                                      return AdminVerification();
                                    }
                                );
                              },
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: AutoSizeText("Settings"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
    