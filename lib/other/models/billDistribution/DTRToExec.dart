import 'package:flutter/material.dart';

class DTRToExecutive {
  String listId;
  String feederId;
  String feederName;
  String dtrId;
  String dtrName;
  String staffId;

  DTRToExecutive(
      {@required this.listId,
      @required this.feederId,
      @required this.feederName,
      @required this.dtrId,
      @required this.dtrName,
      @required this.staffId});

  factory DTRToExecutive.createDTRToExecutive(Map<String, dynamic> json) {
    return DTRToExecutive(
        listId: json["listid"],
        feederId: json["feederid"],
        feederName: json["feederName"],
        dtrId: json["dtrid"],
        dtrName: json["dtrname"],
        staffId: json["staffid"]);
  }
}
