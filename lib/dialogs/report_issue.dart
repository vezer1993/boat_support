import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/dialogs/TakePicture.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../services/api_manager.dart';

class ReportIssue extends StatefulWidget {

  const ReportIssue({Key? key}) : super(key: key);

  @override
  _ReportIssueState createState() => _ReportIssueState();

}

class _ReportIssueState extends State<ReportIssue> {

  final reportIssueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    reportIssueController.dispose();
    super.dispose();
  }

  contentBox(context){
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.5,
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFF202124),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black,offset: Offset(0,5),
                    blurRadius: 10
                ),
              ]
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10,10,10,10),

            child: Column(
                children: <Widget>[
                    const AutoSizeText(
                      "Reporting Issue",
                      style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    ),

                  SizedBox(height: MediaQuery.of(context).size.height / 35,),

                  const AutoSizeText(
                    "Hi, Please take a moment and explain what the issue is:",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height / 30,),

                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: TextFormField(
                      controller: reportIssueController,
                      decoration: InputDecoration(
                        labelText: 'Enter Information Here',
                        contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                        prefixText: ' ',
                        helperText: 'Feel free to provide images below',
                        helperStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        hintStyle: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                        labelStyle: const TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 1),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                      maxLines: 10,
                      minLines: 5,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height / 30,),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[

                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height / 13,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                ("Cancel"),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height / 13,
                          child: ElevatedButton(
                            onPressed: () async{
                              WidgetsFlutterBinding.ensureInitialized();
                              // Obtain a list of the available cameras on the device.
                              final cameras = await availableCameras();

                              // Get a specific camera from the list of available cameras.
                              final firstCamera = cameras.first;

                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context){
                                    List<String> images = [];
                                    return TakePictureScreen(camera: firstCamera, report: reportIssueController.text, images:images,);
                                  }
                              );
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                ("Take Photo"),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.height / 13,
                          child: ElevatedButton(
                            onPressed: () async {
                              List<String> images = [];
                              api_manager().SendIssuereport(images, reportIssueController.text);
                              Navigator.of(context).pop(context);
                            },
                            child: const Align(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                ("Send"),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                  ],
            ),

          ),
        ),
    ),
      ],
    );
  }
}