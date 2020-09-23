import 'package:flutter/material.dart';
import '../utilities/styles.dart';

List<DropdownMenuItem> dropdownItemsOffence = [
    DropdownMenuItem(
      child: Text(
        "Select reason for disconnection**",
        style: TextStyle(color: Colors.red),
      ),
      value: "",
    ),
    DropdownMenuItem(
      child: Text("Non Payment"),
      value: "Non Payment",
    ),
    DropdownMenuItem(
      child: Text("Illegal Connection"),
      value: "Illegal Connection",
    ),
    DropdownMenuItem(
      child: Text("Huge Arrears"),
      value: "Huge Arrears",
    ),
    DropdownMenuItem(
      child: Text("Meter Bypass"),
      value: "Huge Arrears",
    ),
    DropdownMenuItem(
      child: Text("Tamper"),
      value: "Tamper",
    ),
];





    List<DropdownMenuItem> dropdownItemsZones = [
      DropdownMenuItem(
        child: Text("select Zone**", style: normalRed),
        value: "",
      ),
    ];
    List<DropdownMenuItem> dropdownItemsReportCategory = [
        DropdownMenuItem(
          child: Text("Report Category**", style: normalRed,),
          value: "",
        ),  
    ];


   
List<DropdownMenuItem> dropdownItemsFeeders = [
      DropdownMenuItem(
      child: Text("Select Feeders**", style: normalRed,),
      value: "",
    )
];

List<DropdownMenuItem> dropdownItemsFeeders11 = [
      DropdownMenuItem(
      child: Text("Select 11KV Feeders**", style: normalRed,),
      value: "",
    )
];

List<DropdownMenuItem> dropdownItemsDTR = [
    DropdownMenuItem(
      child: Text("Select DTR**", style: normalRed,),
      value: "",
    ),
];


List<DropdownMenuItem> dropdownItemsStates = [
    DropdownMenuItem(
      child: Text("select State",),
      value: "",
    ),
];


List<DropdownMenuItem> dropdownItemsSubCategory = [
    DropdownMenuItem(
      child: Text("Sub Category**", style: normalRed,),
      value: "",
    ),
];







