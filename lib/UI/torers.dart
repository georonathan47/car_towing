
import 'package:cartowing/UI/torermap.dart';
import 'package:cartowing/model/user_model.dart';
import 'package:cartowing/resources/firestore_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart'as UrlLauncher;

import '../pin.dart';

class Tower extends StatefulWidget {
  @override
  _TowerState createState() => _TowerState();
}

class _TowerState extends State<Tower> {
//  void customlaunch(command)async {
//    if (await canLaunch(command)) {
//      await launch(command);
//    }else{
//      print("could not launch ");
//    }
//  }
  bool index = true;
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  GoogleMapController controller;
  List<UserModel> tores;
  LatLng currentLocation;
  List<Marker> markers = [];
  String selectedValue = 'All'  ;
  List town = ['All', 'Eldoret', 'Kisumu', 'Nairobi', 'Nakuru', 'Kericho', 'Mombasa'];
  void onMapCreated(GoogleMapController controller) async {
    this.controller = controller;
    var locationData = await Location().getLocation();
    currentLocation = LatLng(locationData.latitude, locationData.longitude);

    tores.forEach((d) {
      markers.add(Marker(
        markerId: MarkerId("${d.name} location"),
        position: LatLng(d.latitude, d.longitude),
        infoWindow: InfoWindow(title: '${d.name}'),
      ));
    });

    setState(() {
      markers.add(
        Marker(
            markerId: MarkerId("Mylocation"),
            position: currentLocation,
            draggable: true,
            onTap: () {
              print("tapped");
            },

            consumeTapEvents: true,
            infoWindow: InfoWindow(title: "Your location")),
      );
    });
    controller.animateCamera(CameraUpdate.newLatLngZoom(currentLocation, 15));
  }

  getMap() {
    return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition:
          CameraPosition(target: LatLng(4.0435, 39.6682), zoom: 5),
      markers: Set<Marker>.of(markers ),
      onMapCreated: (controller) => onMapCreated(controller),
    );
  }

  getList() {
    if (tores == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else
      return Column(
        children: <Widget>[
          ListTile(
              leading: selectedValue != null
                  ? Text(
                      selectedValue,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Filter',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              trailing: PopupMenuButton(
                icon: Icon(
                  Icons.list,
                  color: Colors.white,
                ),
                onSelected: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                  getUser();
                },
                itemBuilder: (BuildContext context) => town
                    .map((b) => PopupMenuItem(
                          child: Text(b),
                          value: b,
                        ))
                    .toList(),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: ListView.builder(
                itemCount: tores.length,
                itemBuilder: (context, i) {
                  var tower = tores[i];
                  if (tores.length == 0) {
                    return Center(
                      child: Text(
                        'Oops No towers in your  location',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else
                    return GestureDetector(
                      onTap: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) => TorerMap(
                                height: 300,
                                toreLocation: LatLng(
                                  tower.latitude,
                                  tower.longitude,
                                )));
                      },
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(16.0, 30.0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[

                                  Text(
                                    '${tower.name}',
                                    style: TextStyle(
                                        color: Colors.black,fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child:  new IconButton(icon: new Icon(Icons.phone), onPressed:() {
                                      UrlLauncher.launch("tel:"+ tower.contact);
                                    }),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Contact: ',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Text(
                                    ' ${tower.contact}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: Text(
                                      ' ${tower.town}',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 17,fontWeight: FontWeight.bold),
                                    ),
                                  ),
//                                  SizedBox(width: 40,),
//                                  Container(
//                                    margin: EdgeInsets.only(right: 16),
//                                   child:  new IconButton(icon: new Icon(Icons.phone), onPressed:() {
//                                     UrlLauncher.launch("tel:"+ donor.contact);
//                                   }),
//                                  ),
                                  SizedBox(width: 40,),
                                  Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child:  new IconButton(icon: new Icon(Icons.message), onPressed:() {
                                      String message="Hello ${tower.name}, I have just contacted you requesting for towing services here is my location pin ";
                                      UrlLauncher.launch("sms:"+ tower.contact);
                                    }),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      height: 2.0,
                                      width: 18.0,
                                      color: Color(0xff00d6ff)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        height: 154.0,
                        margin: EdgeInsets.only(top: 12.0),
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
                      ),
                    );
                },
              ),
            ),
          ),
        ],
      );
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() {
    FirestoreProvider().getUsers(town: selectedValue).then((document) {
      setState(() {
        tores = document;
      });
    });
  }

  showSnackbar(message) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(message ?? "Something went wrong, try again later."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldkey,
        appBar: AppBar(backgroundColor: Colors.yellow,
          title: Text('Available Towers',style: TextStyle(color: Colors.black),),
          actions: <Widget>[
            IconButton(
              icon: Icon(index ? Icons.map : Icons.list,color: Colors.black,),
              onPressed: () {
                setState(() {
                  index = !index;
                });
              },
            ),

            IconButton(
              icon: Icon(Icons.location_on ,color: Colors.black,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Pin()));
              },
            ),
          ],
        ),
        body: index ? getList() : getMap());
  }
}


