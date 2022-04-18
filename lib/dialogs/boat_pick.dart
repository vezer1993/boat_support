import 'dart:ui';
import 'package:boat_support/pages/check_in_page.dart';
import 'package:boat_support/services/api_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class BoatPick extends StatefulWidget {
  final List BoatList;

  const BoatPick({Key? key, required this.BoatList}) : super(key: key);

  @override
  _BoatPickState createState() => _BoatPickState();

}

class _BoatPickState extends State<BoatPick> {
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
  contentBox(context){
    return Stack(
      children: <Widget>[
        Container(
          width: 500,
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
            padding: const EdgeInsets.fromLTRB(0,10,0,10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0,20,0,0),
                    child: Text("Please select the boat for this device",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                  ),
                  SizedBox(height: 10,),

                  ListView.builder(
                    itemCount: widget.BoatList.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color(0xFF202124),
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          child: ListTile(
                          onTap: () {
                            api_manager().selectBoat(widget.BoatList[index]);
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                const MyApp()), (Route<dynamic> route) => false);
                      },
                      title: Text(widget.BoatList[index]["name"].toString()),
                      subtitle: Text(widget.BoatList[index]["model"].toString()),
                      leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                      widget.BoatList[index]["images"][0]["url"].toString())),
                      ),
                      );
                    },
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