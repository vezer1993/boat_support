import 'package:boat_support/pages/check_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    //set landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF000000),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: const Color(0xFF202124),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 30),
                  textStyle: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ))),
      ),
      home: const check_in_page(),

    );
  }
}

Future<http.Response> fetchAlbum() {
  print("hello");
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[

                    Padding(
                    padding: EdgeInsets.fromLTRB(0,200,0,0),
                    ),

                  Text(
                    'Check-in \n Here',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,

                    ),
                  ),
                    ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    'Check-in \n Here',

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
