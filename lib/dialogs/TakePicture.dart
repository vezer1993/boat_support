import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:boat_support/services/api_manager.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({
    Key? key,
    required this.camera,
    required this.report,
    required this.images,

  }) : super(key: key);

  final CameraDescription camera;
  final String report;
  List<String> images;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    print("HERE IMAGES");
    for(int i = 0; i < widget.images.length; i++){
      print(widget.images[i]);
    }

    // To display the current output from the Camera
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            widget.images.add(image.path);

            // If the picture was taken, display it on a new screen.
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context){
                  return MorePhotosDialog(images: widget.images, report: widget.report);
                }
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final List<String> images;
  final String report;


  const DisplayPictureScreen({Key? key, required this.images, required this.report})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF202124),

        child: SizedBox(
          width: MediaQuery.of(context).size.width /1.3,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[


              SizedBox(height: MediaQuery.of(context).size.height / 30,),

              const AutoSizeText(
                  "Report",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),


              SizedBox(height: MediaQuery.of(context).size.height / 10,),

              const FractionallySizedBox(
                widthFactor: 0.6,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        ("Issue Report:"),
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontSize: 27,
                        ),
                      ),
                    ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 50,),

        ConstrainedBox(
              
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 4,
                minHeight: MediaQuery.of(context).size.height / 6,
              ),
              child: Container(
                padding: new EdgeInsets.all(10),
                decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,// red as border color
                      ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: FractionallySizedBox(
                    widthFactor: 0.6,
                    child: AutoSizeText(
                      report.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    )

                ),
              ),
        ),

              SizedBox(height: MediaQuery.of(context).size.height / 30,),

              const FractionallySizedBox(
                widthFactor: 0.6,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    ("Photos:"),
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 27,
                    ),
                  ),
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height / 50,),

             FractionallySizedBox(
              widthFactor: 0.6,
                  child: SizedBox(
                    height:  MediaQuery.of(context).size.height /6,
                      child:  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext ctx, int index) {
                          return

                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              child: Image.file(File(images[index])),
                            );
                        },
                        itemCount: images.length,
                      ),
                  ),
            ),

              SizedBox(height: MediaQuery.of(context).size.height / 10,),

               ElevatedButton(
                onPressed: () {
                  api_manager().SendIssuereport(images, report);

                  Navigator.of(context).pop(context);
                  Navigator.of(context).pop(context);
                  Navigator.of(context).pop(context);
                  Navigator.of(context).pop(context);
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    ("Send"),
                  ),
                ),
              ),

            ],
          ),
        ),

      )
      //Image.file(File(imagePath)),
    );
  }
}

class MorePhotosDialog extends StatelessWidget {

  final List<String> images;
  final String report;


  const MorePhotosDialog({Key? key, required this.images, required this.report})
      : super(key: key);

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

  contentBox(context) {
    return Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 7,

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

                const AutoSizeText(
                  "Add another picture?",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height / 25,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                      "Yes",
                      style: TextStyle(
                        fontSize: 20
                      ),
                  ),
                ),),

                    ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DisplayPictureScreen(
                              // Pass the automatically generated path to
                              // the DisplayPictureScreen widget.
                              images: images,
                              report: report,
                            ),
                          ),
                        );
                      },
                      child: const Align(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "No",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),)
                  ],
                ),
              ],
            ),
          ),
          ]
    );
  }

}