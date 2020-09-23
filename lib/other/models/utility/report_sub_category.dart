import 'package:flutter/material.dart';

class ReportSubCategory{

  String reportSubCatId;
  String reportSubCatName;

  ReportSubCategory({@required this.reportSubCatId, @required this.reportSubCatName});

  factory ReportSubCategory.createReportSubCategory(Map<String,dynamic> json){
    return ReportSubCategory(
      reportSubCatId: json["ReportSubCategoryId"],
      reportSubCatName: json["ReportSubCategoryName"]
    );
  }
}