import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/constants/strings.dart';
import 'package:boat_support/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AdminVerification extends StatefulWidget {

  @override
  AdminVerificationState createState() => AdminVerificationState();
}

class AdminVerificationState extends State<AdminVerification> {

  bool checkedValue = false;

  @override
  void initState() {
    super.initState();
  }

  StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  String currentText = "";
  TextEditingController textEditingController = new TextEditingController();

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
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 1.3,

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


              child: Column(
                children: <Widget>[

                  SizedBox(height: MediaQuery.of(context).size.height / 150,),

                  //page title
                  const AutoSizeText(
                    "Please enter admin password: ",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),



                  SizedBox(height: MediaQuery.of(context).size.height / 25,),

                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width / 10, MediaQuery.of(context).size.height / 20, MediaQuery.of(context).size.width / 10, MediaQuery.of(context).size.height / 20),
                    child: PinCodeTextField(
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 80,
                        fieldWidth: 60,
                        activeFillColor: Colors.white,
                        inactiveColor: Colors.green,
                        activeColor: Colors.green,
                        inactiveFillColor: Colors.grey,
                        selectedColor: Colors.white,
                        selectedFillColor: Colors.white,
                      ),
                      textStyle: const TextStyle(
                        color: Colors.black
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      onCompleted: (v) {
                        if(currentText == Strings.settings_password){
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const settings_page()),
                          );
                        }else{
                          errorController.add(ErrorAnimationType.shake);
                          textEditingController.text = "";
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                      appContext: context,
                    ),
                  ),

                  const Spacer(),

                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).size.height / 25),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "Back",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ),),

                        ElevatedButton(
                          onPressed: (){
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "Verify",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}