import 'package:flutter/material.dart';

class RCDCIncidence{
 
    String incidenceId;
    String incidenceName;
    

    RCDCIncidence(
      {
        @required this.incidenceId,
        @required this.incidenceName,
      }
    );

    
    factory RCDCIncidence.createRCDCIncidence(Map<String, dynamic> json){
        return RCDCIncidence(
           incidenceId: json["ReasonForDisconnectionId"],
           incidenceName: json["ReasonName"],
        );
    }




}

