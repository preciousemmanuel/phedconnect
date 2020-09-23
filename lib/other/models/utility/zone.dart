import 'package:flutter/material.dart';

class Zone{

  String ibcId;
  String ibcName;

  Zone({@required this.ibcId, @required this.ibcName});

  factory Zone.createZone(Map<String,dynamic> json){
    print("lfskfls: " +json["IBCName"]);
    return Zone(
      ibcId: json["IBCId"],
      ibcName: json["IBCName"]
    );
  }
}