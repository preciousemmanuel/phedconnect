

import 'package:flutter/material.dart';

class SettlementDuration{

  String settlementName;
  String settlementId;

  SettlementDuration({
    @required this.settlementName,
    @required this.settlementId
  });

  factory SettlementDuration.createSettlementDuration(Map<String, dynamic> json){
    return SettlementDuration(
      settlementName: json["Settlement_Duration_Name"],
      settlementId: json["Settlement_Duration_Id"]
    );
  }

}