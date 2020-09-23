

import 'package:flutter/material.dart';

class CustomerIncidence{

    String incidenceId;
    String incidenceAmount;
    String percentPayment;
    int durationInDays;
    String incidenceName;

    CustomerIncidence(
        {
          @required this.incidenceId,
          @required this.incidenceAmount,
          @required this.percentPayment,
          @required this.durationInDays,
          @required this.incidenceName
        }
    );

    factory CustomerIncidence.createCustomerIncidence( Map<String, dynamic> json){
        return CustomerIncidence(
            incidenceId: json["IncidenceId"],
            incidenceAmount: json["IncidenceAmount"].toString(),
            percentPayment: json["Percentpayment"],
            durationInDays: json["DurationInDays"],
            incidenceName: json["IncidenceName"]

        );
    }



}