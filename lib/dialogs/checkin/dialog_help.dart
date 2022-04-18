import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/models/check_in_segment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogHelp extends StatefulWidget {

  CheckInSegment segment;

  DialogHelp(this.segment, {Key? key}) : super(key: key);


  @override
  DialogHelpState createState() => DialogHelpState();
}

class DialogHelpState extends State<DialogHelp> {

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


              child: Center(
                child: Image.asset("assets/images/EngineStart.jpg")
            ),
            ),
          ]
      ),
    );
  }
}