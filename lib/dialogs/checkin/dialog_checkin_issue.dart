import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/models/check_in_segment.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class DialogCheckInIssue extends StatefulWidget {

  final Function(String problem, String image) notifyParent;

  const DialogCheckInIssue({Key? key, required this.notifyParent}) : super(key: key);


  @override
  DialogCheckInIssuestate createState() => DialogCheckInIssuestate();
}

class DialogCheckInIssuestate extends State<DialogCheckInIssue> {

  final reportIssueController = TextEditingController();
  String? image = "";
  bool hasImage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.3,

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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      const AutoSizeText(
                        "Reporting Issue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height / 35,),

                      const AutoSizeText(
                        "Please enter what the Issue is below",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      const SizedBox(height: 10,),

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

                      Visibility(
                        visible: !hasImage,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                final ImagePicker _picker = ImagePicker();
                                final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                                Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
                                String appDocumentsPath = appDocumentsDirectory.path;
                                photo?.saveTo('$appDocumentsPath/image.jpg');
                                image = '$appDocumentsPath/image.jpg';
                                if(image != ""){
                                  setState(() {
                                    hasImage = true;
                                  });
                                }
                              },
                              child: const Center(
                                child: AutoSizeText(
                                  ("Add Picture"),
                                ),
                              )
                            ),
                          ),
                        ),
                      ),

                      //Visibility(visible: hasImage,child: SizedBox(height: 50, width: 50, child: Image.asset(image.toString()),)),

                      const SizedBox(height: 20,),

                      SizedBox(
                        width: 500,
                        child: ElevatedButton(
                          onPressed: () {
                            widget.notifyParent(reportIssueController.text, image.toString());
                            Navigator.pop(context);
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              ("Report & Continue"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
          ]
      ),
    );
  }
}