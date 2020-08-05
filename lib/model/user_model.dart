import 'package:meta/meta.dart';

import 'const.dart';

class UserModel {
   String id;
   String name;
   String contact;
   String town;
   double longitude;
   double latitude;
   String email;


  UserModel( {this.id, @required this.name, this.contact, this.town,this.longitude,this.latitude,this.email});
  
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[Id] = id;
    map[Name] = name;
    map[Contact] = contact;
    map[Town] = town;
    map[Longitude] =longitude;
    map[Latitude] =latitude;
    map[Email] = email;
    return map;
  }
  static UserModel fromMap(var user) {
    return UserModel(name: user[Name],contact: user[Contact],town: user[Town],longitude: user[Longitude],latitude: user[Latitude],email: user[Email]);
  }
}
