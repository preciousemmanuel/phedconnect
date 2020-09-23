/*
* This class represents a model for the staff
*/

import 'package:flutter/cupertino.dart';

class Staff{

  
    String id;
    String name;
    String staffId;
    String gangId;
    String gangName;
    String email;
    String phoneNo;
    String address;
    String feederId;
    String gangLeader;
    String gangLeaderPhone;
    String gangLeaderEmail;
    String zone;
    String feeder;
    List modules;
    String date;
    String year;
    String month;
    String accountNo;
    String incidence;
    String disconnId;
    String comments;
    String averageBillReading;
    String accountType;
    String userId;
    String reasonForDisconnectionId;
    String feederName;
    String loadProfile;
    String dateOfLastPaymnt;
    String phase;

    Staff(
      {
        @required this.id,
        @required this.name,
        @required this.staffId,
        @required this.gangId,
        @required this.gangName,
        @required this.email,
        @required this.phoneNo,
        @required this.address,
        @required this.gangLeader,
        @required this.gangLeaderPhone,
        @required this.gangLeaderEmail,
        @required this.zone,
        @required this.feeder,
        @required this.modules,
        @required this.feederId,
        this.date,
        this.year,
        this.month,
        this.accountNo,
        this.incidence,
        this.disconnId,
        this.comments,
        this.averageBillReading,
        this.accountType,
        this.userId,
        this.reasonForDisconnectionId,
        this.feederName,
        this.loadProfile,
        this.dateOfLastPaymnt,
        this.phase

      }
    );


    factory Staff.createStaff(Map<String, dynamic> json){
      print(json["FeederId"]);
      return Staff(
        id: json["Id"],
        name: json['StaffName'],
        staffId: json['StaffId'],
        gangId: json["GangID"],
        gangName: json["GangName"],
        email: json["Email"],
        phoneNo: json["PhoneNo"],
        address: json["Address"],
        gangLeader: json["GangLeader"],
        gangLeaderPhone: json["GangLeaderPhone"],
        gangLeaderEmail: json["GangLeaderEmail"],
        zone: json["Zone"],
        feeder: json["Feeder"],
        modules: json["Modules"],
        feederId: json["FeederId"],
        feederName: json["FeederName"],

      ); 
    }


}