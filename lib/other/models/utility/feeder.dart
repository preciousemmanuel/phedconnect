import 'package:flutter/material.dart';

class Feeder{

  String feederName;
  String feederId;

  Feeder({@required this.feederName, @required this.feederId});

  factory Feeder.createFeeder(Map<String,dynamic> json){
    return Feeder(
      feederName: json["BSCName"],
      feederId: json["BSCId"]
    );
  }

  factory Feeder.createFeeder11(Map<String,dynamic> json){
      return Feeder(
      feederName: json["feeder_name"],
      feederId: json["feeder11kv_id"]
    );
  }
}