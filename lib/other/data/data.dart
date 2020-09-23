


import 'package:flutter/material.dart';
import '../models/customer.dart';

List<Customer>  dcCustomerList = [];
List<Customer> bulkDisconnectList = List();

List<DropdownMenuItem> dropdownItemsCalculateLoadOption = [
    DropdownMenuItem(
      child: Text("LOAD PROFILE"),
      value: "",
    ),     
    DropdownMenuItem(
      child: Text("Get load from bill"),
      value: "1",
    ),
    DropdownMenuItem(
      child: Text("Get load from Clamp meter"),
      value: "2",
    ),
      DropdownMenuItem(
      child: Text("Load Calculator"),
      value: "3",
    ),
];

List<DropdownMenuItem> dropdownItemsPhase = [
    DropdownMenuItem(
      child: Text("SELECT PHASE"),
      value: "",
    ),     
    DropdownMenuItem(
      child: Text("SINGLE PHASE"),
      value: "1",
    ),
    DropdownMenuItem(
      child: Text("THREE PHASE"),
      value: "3",
    ),
];

List<DropdownMenuItem> dropdownItemsTariff = [
    DropdownMenuItem(
      child: Text("SELECT TARIFF"),
      value: "",
    ),     
];





