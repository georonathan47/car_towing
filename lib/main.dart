import 'dart:async';
import 'UI/home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Towing  services',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.red.shade900),
        primarySwatch: Colors.yellow,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Home()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.yellow.withOpacity(0.9),
      body: new Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300,),
            Image.asset("assets/towing.png",height: 300,width: 300,),
            SizedBox(height: 5,),
            Row(
              children: <Widget>[
                SizedBox(width: 80,),
                Text("Sokoa ",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.red,fontSize: 25.0),),
                Text("Towing ",
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.green,fontSize: 25.0),),
                Text("Services ",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0),),

              ],
            )
          ],
        ),
//        child: CircleAvatar(
//          // minRadius: 7.0,
//          maxRadius: 50,
////          child: Icon(
////            MdiIcons.car,
////            size: 60.0,
////            color: Colors.white,
////          ),
//        ),
      ),
    );
  }
}
