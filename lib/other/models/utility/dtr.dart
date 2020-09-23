import 'package:flutter/material.dart';

class DTR{

  String dtrName;
  String dtrId;
  String feederName;
  String feederId;

  DTR({@required this.feederName, @required this.feederId, @required this.dtrName, @required this.dtrId});

  factory DTR.createDTR(Map<String,dynamic> json){
    return DTR(
      feederName: json["FeederName"],
      feederId: json["FeederId"].toString(),
      dtrName: json["DTRName"],
      dtrId: json["DTR_Id"].toString()
    );
  }
}