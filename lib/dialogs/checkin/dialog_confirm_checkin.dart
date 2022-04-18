import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/models/check_in_model.dart';
import 'package:boat_support/models/check_in_segment.dart';
import 'package:boat_support/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class DialogCompleteCheckIn extends StatefulWidget {
  CheckInModel model;

  DialogCompleteCheckIn(this.model, {Key? key}) : super(key: key);

  @override
  DialogCompleteCheckInState createState() => DialogCompleteCheckInState();
}

class DialogCompleteCheckInState extends State<DialogCompleteCheckIn> {
  bool checkedValue = false;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.blue.shade500,
    exportBackgroundColor: Colors.white,

  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery
        .of(context)
        .size
        .width / 1.5;

    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(children: <Widget>[
        Container(
          width: width,
          height: MediaQuery
              .of(context)
              .size
              .height / 1.3,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFF202124),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              const Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  "Thank you for completing the Check In procedure",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 50,),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "Please Make a Signature below and press the Complete Button:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Signature(
                controller: _controller,
                width: width - 30,
                height: 250,
                backgroundColor: Colors.white,
              ),

                const Spacer(),

                SizedBox(
                  width: width / 3,
                  child: ElevatedButton(
                    onPressed: () async {
                      if(_controller.isNotEmpty){
                        api_manager().CompleteCheckInReport(widget.model, await _controller.toPngBytes());
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }else{
                        showAlertDialog(context);
                      }
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        ("Finish"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(fontSize: 30),),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("No Signature", style: TextStyle(color: Colors.white),),
      content: Text("Please Sign before completing"),
      actions: [
        okButton,
      ],
      backgroundColor: const Color(0xFF202124),
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
