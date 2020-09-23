
import '../../widgets/customer_info_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewCustomerDetailsScreen extends StatefulWidget {

  final Map<String, dynamic> customer;  
  final String flag;
  NewCustomerDetailsScreen(this.customer, {this.flag});

  @override
  _NewCustomerDetailsScreenState createState() => _NewCustomerDetailsScreenState();
}

class _NewCustomerDetailsScreenState extends State<NewCustomerDetailsScreen> {


      final numberFormat = new NumberFormat("#,##0.00", "en_US");
   
      @override
      void initState() {
          super.initState();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("New Customer Details")
            ),
            body: Container(
              decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bgg.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
                    )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                child: ListView(
                  children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
                        ]
                    ),
                    child: Column(
                      children: <Widget>[
                          CustomerInfoText("DATE CAPTURED : ", widget.customer["DateCaptured"] != null ? widget.customer["DateCaptured"]: "NA"),
                          CustomerInfoText("TICKET NO: ", widget.customer["TicketNo"] != null ? widget.customer["TicketNo"] : "NA"),
                          CustomerInfoText("SURNAME: ", widget.customer["Surname"] != null ? widget.customer["Surname"] : "NA"),
                          CustomerInfoText("OTHERNAMES: ", widget.customer["OtherNames"] != null ? widget.customer["OtherNames"] : "NA"),
                          CustomerInfoText("HOUSE NO: ",  widget.customer["HouseNo"] != null ?  widget.customer["HouseNo"] : "NA"),
                          CustomerInfoText("STREET NAME: ", widget.customer["StreetName"] != null ? widget.customer["StreetName"]: "NA"),
                          CustomerInfoText("COMMUNITY NAME: ", widget.customer["CommunityName"] != null ? widget.customer["CommunityName"]: "NA"),
                          CustomerInfoText("LAND MARK: ", widget.customer["LandMark"] != null ? widget.customer["LandMark"]: "NA"),
                          CustomerInfoText("STATE CODE: ", widget.customer["State"] != null ? widget.customer["State"]: "NA"),
                          CustomerInfoText("LGA: ", widget.customer["LGA"] != null ? widget.customer["LGA"]: "NA"),
                          CustomerInfoText("PHONE NUMBER: ", widget.customer["PhoneNumber1"] != null ? widget.customer["PhoneNumber1"]: "NA"),
                          CustomerInfoText("EMAIL: ", widget.customer["CustomerEmail"] != null ? widget.customer["CustomerEmail"]: "NA"),
                          CustomerInfoText("OFFICIAL EMAIL: ", widget.customer["OfficeEmail"] != null ? widget.customer["OfficeEmail"]: "NA"),
                          CustomerInfoText("TYPE OF PREMISES: ", widget.customer["UseOfPremises"] != null ? widget.customer["UseOfPremises"]: "NA"),
                          CustomerInfoText("USE OF PREMISES: ", widget.customer["TypeOfPremises"] != null ? widget.customer["TypeOfPremises"]: "NA"),
                          CustomerInfoText("OCCUPATION: ", widget.customer["Occupation"] != null ? widget.customer["Occupation"]: "NA"),
                          CustomerInfoText("MDA: ", widget.customer["MDA"] != null ? widget.customer["MDA]"]: "NA"),
                          CustomerInfoText("MEANS OF IDENTIFICATION: ", widget.customer["MeansOfIndentification"] != null ? widget.customer["MeansOfIndentification"]: "NA"),
                          CustomerInfoText("CUSTOMER LOAD: ", widget.customer["CustomerLoad"] != null ? widget.customer["CustomerLoad"]: "NA"),
                          CustomerInfoText("NEARBY ACCOUNT NO: ", widget.customer["NearbyAccountNo"] != null ? widget.customer["NearbyAccountNo"]: "NA"),
                          CustomerInfoText("TYPE OF METER REQUIRED: ", widget.customer["TypeOfMeterRequired"] != null ? widget.customer["TypeOfMeterRequired"]: "NA"),
                          CustomerInfoText("FEEDER NAME: ", widget.customer["FeederName"] != null ? widget.customer["FeederName"]: "NA"),
                          CustomerInfoText("FEEDER ID: ", widget.customer["FeederId"] != null ? widget.customer["FeederId"]: "NA"),
                          CustomerInfoText("ZONE: ", widget.customer["Zone"] != null ? widget.customer["Zone"]: "NA"),
                          CustomerInfoText("DTR NAME: ", widget.customer["DTRName"] != null ? widget.customer["DTRName"]: "NA"),
                          CustomerInfoText("DTR CODE: ", widget.customer["DTRCode"] != null ? widget.customer["DTRCode"]: "NA"),
                          CustomerInfoText("BOOk CODE: ", widget.customer["BookCode"] != null ? widget.customer["BookCode"]: "NA"),
                          
                      ],
                    ),
                  ),
                ],
                  ),
              ),
            ),
        );
      }
} 

 
