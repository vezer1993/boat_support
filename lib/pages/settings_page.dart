import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../dialogs/boat_pick.dart';
import '../services/api_manager.dart';

class settings_page extends StatefulWidget {
  const settings_page({Key? key}) : super(key: key);

  @override
  settings_page_pageState createState() => settings_page_pageState();
}

class settings_page_pageState extends State<settings_page> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
        child: Row(
          children: [
            SizedBox(
              width: width/2,
              height: height,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.black26
                ),
                child: FutureBuilder(
                  future:  api_manager().getBoats(context),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.data == null){
                      return Text("...");
                    }
                    else{
                      Map boatData = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height/10,),
                          AutoSizeText(
                              boatData["company"].toString(),
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          SizedBox(height: height/20,),
                          AutoSizeText(
                            boatData["name"].toString(),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(height: height/100,),
                          AutoSizeText(
                            boatData["model"].toString(),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(height: height/100,),
                          AutoSizeText(
                            boatData["homeBase"].toString(),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      );
                    }
                  }
                ),
              ),
            ),
            SizedBox(
              width: width/2,
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height/10,),
                  SizedBox(
                    width: width / 5,
                    child: ElevatedButton(
                      onPressed: () {
                        api_manager().returnBoatDialog(context);
                      },
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText("Change Boat"),
                      ),
                    ),
                  ),
              ]
              )
            )
          ],
        ),
      ),
    );
  }
}
    // Center is a layout widget. It takes a single child and positions it
    // in the middle of the parent.