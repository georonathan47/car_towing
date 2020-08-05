import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'UI/map.dart';
import 'model/user_model.dart';


class Pin extends StatefulWidget {
  @override
  _PinState createState() => _PinState();
}

class _PinState extends State<Pin> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  String locationName = 'Tap to Pin Your Location';
  UserModel user = UserModel(

      longitude: 0,
      latitude: 0,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Pin Picker',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,),
        ),
//        actions: <Widget>[
//          isLoggedIn
//              ? SizedBox()
//              : IconButton(
//              icon: Icon(MdiIcons.logout),
//              onPressed: () async {
//                await FirebaseAuthProvider().logout();
//                showSnackbar('You are logged out');
//
//                getUser();
//              })
//        ],
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(

          alignment: Alignment.topLeft,
          width: double.infinity,
          decoration: BoxDecoration(
              border:
              Border(bottom: BorderSide(color: Colors.grey, width: 1))),
          height: 350,
          child: Column(
            children: <Widget>[
              Center(
                child: FlatButton(
                  child: Text(locationName,
                      style: TextStyle(
                        color: Colors.white,
                      )),


                  onPressed: () async {
                    var loc = await Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Maps()));
                    if (loc != null) {
                      setState(() {
                        locationName = "${loc.latitude},${loc.longitude}";
                      });
                      user.latitude = loc.latitude;
                      user.longitude = loc.longitude;
                    }
                  },

                ),
              ),
              SizedBox(height: 30,),

              Builder(builder: (context) {
                return InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: locationName));
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Location copied successfully")));
                    },
                    child: Text("COPY YOUR LOCATION",
                        style: TextStyle(color: Colors.red)));
              }),
            ],
          ),

        ),
      ),

    );
  }
}
