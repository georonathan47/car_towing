
import 'package:cartowing/UI/profile.dart';
import 'package:cartowing/resources/firebase_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'login.dart';
import 'torers.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false;
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  getUser() async {
    var user = await FirebaseAuthProvider().getCurrentUser();
    if (user == null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  showErrorDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text('You must Login to continue !',
                  style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    }),
              ],
              title: Text(
                'Oops',
                style: TextStyle(fontWeight: FontWeight.bold),
              ));
        });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  showSnackbar(message) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.purple,
      content: Text(message ?? "Something went wrong, try again later."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          'Towing services',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow),
        ),
        actions: <Widget>[
          isLoggedIn
              ? SizedBox()
              : IconButton(
                  icon: Icon(MdiIcons.logout,color: Colors.black,),
                  onPressed: () async {
                    await FirebaseAuthProvider().logout();
                    showSnackbar('You are logged out');

                    getUser();
                  })
        ],
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            // This is our main page
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.yellow, Colors.teal]),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),

                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tower()));
                    },
                    child: Center(
                      child: Container(
                        decoration: new BoxDecoration(
                            border: new Border.all(
                                color: Colors.black, width: 5.0)),
                        padding: new EdgeInsets.all(20.0),
                        child: Text('find Towing Services',
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ),
                ),
              ),
              Divider(height: 3,color: Colors.black,thickness: 5,),
              Expanded(
                child: Container(
    decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.teal, Colors.yellow]),
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: <BoxShadow>[
    BoxShadow(
    color: Colors.black12,
    blurRadius: 15.0,
    offset: Offset(0.0, 10.0),
    ),
    ],
    ),
                  child: InkWell(
                    onTap: () async {
                      var user = await FirebaseAuthProvider().getCurrentUser();
                      print(user);
                      if (user == null) {
                        showErrorDialog();
                      } else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      }
                    },
                    child: Center(
                      child: Container(
                        decoration: new BoxDecoration(
                            border: new Border.all(
                                color: Colors.black, width: 5.0)),
                        padding: new EdgeInsets.all(20.0),
                        child: Text('Post Towing Services',
                            style: new TextStyle(
                                color: Colors.black,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.teal,
    );
  }
}
