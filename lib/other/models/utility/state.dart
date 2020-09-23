import 'package:flutter/material.dart';

class RCDCState{

  String name;
  String code;

  RCDCState({@required this.name, @required this.code});

  factory RCDCState.createState(Map<String,dynamic> json){
    return RCDCState(
      name: json["STATE_NAME"],
      code: json["STATE_CODE"]
    );
  }
}