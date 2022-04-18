import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogTemplate extends StatefulWidget {

@override
DialogTemplateState createState() => DialogTemplateState();
}

class DialogTemplateState extends State<DialogTemplate> {

  bool checkedValue = false;

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
                    "Welcome",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height / 25,),

                  //description
                  const AutoSizeText(
                    "Here you can do this and that",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontStyle: FontStyle.italic
                    ),
                  ),


                  SizedBox(height: MediaQuery.of(context).size.height / 25,),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        child: Transform.scale(
                          scale: 1.5,
                          child: CheckboxListTile(
                            contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width/ 7, bottom: 10),
                            checkColor: Colors.white,
                            title: const AutoSizeText(
                                "title text",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            )
                            ,
                            value: checkedValue,
                            onChanged: (newValue) {
                              setState(() {
                                checkedValue = newValue!;
                              });
                            },
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                      ),
                    ],
                  ),

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
                              "No",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ),),

                        ElevatedButton(
                          onPressed: (){
                            if(checkedValue == false){
                              showAlertDialog(context);
                            }
                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: AutoSizeText(
                              "Yes",
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
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xFF202124),
      title: Text("Alert",
      style: TextStyle(
          color: Colors.white,
        fontSize: 25
      ),),
      content: Text("Please accept the terms",
        style: TextStyle(
            color: Colors.white
        ),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}