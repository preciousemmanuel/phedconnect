import 'package:flutter/material.dart';

class LGA{

  String lgaName;
  String lgaCode;

  LGA({@required this.lgaName, @required this.lgaCode});

  factory LGA.createState(Map<String,dynamic> json){
    return LGA(
      lgaName: json["LGA_NAME"],
      lgaCode: json["LGA_CODE"]
    );
  }
}