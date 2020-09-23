import 'package:flutter/material.dart';

class ReportCategory{

  String reportCatId;
  String reportCatName;

  ReportCategory({@required this.reportCatId, @required this.reportCatName});

  factory ReportCategory.createReportCategory(Map<String,dynamic> json){
    return ReportCategory(
      reportCatId: json["ReportCategoryId"],
      reportCatName: json["ReportCategoryName"]
    );
  }
}