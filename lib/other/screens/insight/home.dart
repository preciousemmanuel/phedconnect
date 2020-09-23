// import '../../controllers/utility/dtr_controller.dart';
// import '../../controllers/utility/feeder_controller.dart';
// import '../../controllers/utility/state_controller.dart';
// import '../../controllers/utility/zone_controller.dart';
// import '../../data/dropdown_btn_list.dart';
// import '../../models/utility/dtr.dart';
// import '../../models/utility/feeder.dart';
// import '../../models/utility/zone.dart';
// import '../../utilities/alert_dialog.dart';
// import 'package:flutter/material.dart';
// import '../../widgets/charts_flutter.dart';
// import 'package:pie_chart/pie_chart.dart';

// class InsightHomeScreen extends StatefulWidget {
//   @override
//   _InsightHomeScreenState createState() => _InsightHomeScreenState();
// }

// class _InsightHomeScreenState extends State<InsightHomeScreen> {

//   GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

//   ZoneController zc = ZoneController();
//   StateController sc = StateController();
//   FeederController fc = FeederController();
//   DTRController dtrc = DTRController();


//   Map<String, double> dataMap = Map();
//   String _selectedZone;
//   String _selected33Feeder;
//   String _selected11Feeder;
//   String _selectedDTR;
//   String selectedDTR;

 
//   List<Color> colorList = [
//     Colors.blue,
//     Colors.green,
//     Colors.cyan,
//     Colors.yellow,
//     Colors.purple,
//     Colors.red
//   ];

//   List<Zone> zoneList = [];
//   List<Feeder> feederList = [];
//   List<DTR> dtrList = [];

//   List<DropdownMenuItem> dropdownItemsCumulativePerformance = [
//       DropdownMenuItem(
//         child: Text(
//           "ALL ZONES",
//         ), 
//         value: "ALL ZONES"
//       ),
//        DropdownMenuItem(
//         child: Text(
//           "ALPHA",
//         ), 
//         value: "ALPHA"
//       ),
//        DropdownMenuItem(
//         child: Text(
//           "AKS",
//         ), 
//         value: "AKS"
//       ),
//       DropdownMenuItem(
//         child: Text(
//           "BETA",
//         ), 
//         value: "BETA"
//       ),
//        DropdownMenuItem(
//         child: Text(
//           "BYS",
//         ), 
//         value: "BYS"
//       ),
//        DropdownMenuItem(
//         child: Text(
//           "CRS",
//         ), 
//         value: "CRS"
//       ),
//        DropdownMenuItem(
//         child: Text(
//           "GAMMA",
//         ), 
//         value: "GAMMA"
//       ), 
//   ];

//     @override
//     void initState() {
//       super.initState();

//       _selectedZone = dropdownItemsZones[0].value;
//       _selected33Feeder = dropdownItemsFeeders[0].value;
//       _selected11Feeder = dropdownItemsFeeders11[0].value;
//       _selectedDTR = dropdownItemsDTR[0].value;
//       initStateVariables();


//       dataMap.putIfAbsent("A", () => 2377);
//       dataMap.putIfAbsent("B", () => 22711);
//       dataMap.putIfAbsent("C", () => 146880);
//       dataMap.putIfAbsent("D", () => 44880);
//       dataMap.putIfAbsent("E", () => 705);
//       dataMap.putIfAbsent("F", () => 263322);
//     }

//     initStateVariables() async{
//       Map<String, dynamic> resZones = await zc.getZones();
     
//       if(resZones["status"] == "SUCCESS"){ 

//             zoneList.clear();
//             if(dropdownItemsZones.length > 1){
//                dropdownItemsZones.removeRange(1, dropdownItemsZones.length); 
//             }
//             zoneList = resZones["data"];
//             zoneList.forEach((element) {
//               dropdownItemsZones.add(
//                   DropdownMenuItem(
//                     child: Text(element.ibcName, overflow: TextOverflow.visible,),
//                     value: element.ibcId.toString(),
//                   ),
//               );
//             }); 
//       }

//             //fetch the report categories
//     }

//     getFeedersByZone(String zone) async{

//         _selected33Feeder = dropdownItemsFeeders[0].value;
//         if(dropdownItemsFeeders.length > 1){
//           dropdownItemsFeeders.removeRange(1, dropdownItemsFeeders.length);
//         }
//         setState(() {
//           _selectedZone = zone;
//           print(_selectedZone);
//         });
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving feeders");
//         Map<String, dynamic> res = await fc.getFeederByZone(zone);
         
//         if(res["status"] == "SUCCESS"){  
//           feederList.clear();
//           feederList = res["data"];
//           feederList.forEach((element) {
//             dropdownItemsFeeders.add(
//                 DropdownMenuItem(
//                   child: Text(
//                     element.feederName,
//                     overflow: TextOverflow.visible,
//                   ),
//                   value: element.feederId,
//                 ),
//             );
//          }); 

//         }
//         else{
//           _showSnackBar(isSuccessSnack: false, msg: "No Feeder found for the selected Zone");
//         }
//         Navigator.pop(context);
     
//     }

//     getFeeders11ByFeeder33(String feederId) async{

//         _selected11Feeder = dropdownItemsFeeders11[0].value;
//         if(dropdownItemsFeeders11.length > 1){
//           dropdownItemsFeeders11.removeRange(1, dropdownItemsFeeders11.length);
//         }
//         setState(() {
//           _selected33Feeder = feederId;
//           print(_selected33Feeder);
//         });
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving 11KV feeders");
//         Map<String, dynamic> res = await fc.getFeeder11ByFeeder33(feederId);
         
//         if(res["status"] == "SUCCESS"){  
//           feederList.clear();
//           feederList = res["data"];
//           feederList.forEach((element) {
//             print("yy:"+ element.feederName);
//             print("xx:"+ element.feederId);
//             dropdownItemsFeeders11.add(
//                 DropdownMenuItem(
//                   child: Text(
//                     element.feederName,
//                     overflow: TextOverflow.visible,
//                   ),
//                   value: element.feederId,
//                 ),
//             );
//          }); 

//         }
//         else{
//           _showSnackBar(isSuccessSnack: false, msg: "No 11KV Feeder found for the selected Zone");
//         }
//         Navigator.pop(context);
     
//     }

//     getDTRByFeeder(String feederId) async{

//         feederId == null ? print("Na") : print("11kv feeder id:"+ feederId);
//         if(dropdownItemsDTR.length > 1){
//             dropdownItemsDTR.removeRange(1, dropdownItemsDTR.length);
//         }
//         setState(() {
//             _selected11Feeder = feederId;
//         });
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "retrieving DTRS");
//         Map<String, dynamic> res = await dtrc.getDTRByFeeder(feederId);

//         if(res["status"] == "SUCCESS"){  
//           dtrList.clear();
//           dtrList = res["data"];
//           dtrList.forEach((element) {
//             dropdownItemsDTR .add(
//                 DropdownMenuItem(
//                   child: Text(element.dtrName, overflow: TextOverflow.ellipsis,),
//                   value: element.dtrId,
//                 ),
//             );
//          }); 
        

//         }
//          else{
//           _showSnackBar(isSuccessSnack: false, msg: "No DTR found for the selected Feeder");
//         }
        
//         Navigator.pop(context);
      
//     }

//      //Function: snackbar for creating and displaying widget
//     void _showSnackBar({bool isSuccessSnack, String msg}){
//         //create snackbar
//         var snackBar =  SnackBar(
//             backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
//             content: Text(msg,
//             style: TextStyle(
//               color: Colors.white
//             ),),
//         );

//         //show snackbar
//         scaffoldKey.currentState.showSnackBar(snackBar);
//     }

//     //builds the dropdown for Zones
//     Widget _buildDropDownButtonZones(){

//         Widget dropdownButton;
//         dropdownButton = Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(8.0),
//           height: 60.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//             ],
//             borderRadius: BorderRadius.circular(5.0)
//           ),
//           child: DropdownButton(
//             //the list "dropdownItemsZones" is from "lib/data/dropdown_btn_list.dart"
//             items: dropdownItemsZones,
//             onChanged: (dynamic value){
//               /*setState(() {
//                 _selectedZone = value;
//                 print(_selectedZone);
//               });
//               */
//               getFeedersByZone(value);
//             },
//             value: _selectedZone,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600
//             ),
//           ),
//         );

//         return dropdownButton;
//     }

//     //builds the dropdown for Feeders
//     Widget _buildDropDownButton33Feeders(){
//         Widget dropdownButton;
//         dropdownButton = Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(8.0),
//           height: 60.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//             ],
//             borderRadius: BorderRadius.circular(5.0)
//           ),
//           child: DropdownButton(
//             //the list "dropdownItemsFeeders" is from "lib/data/dropdown_btn_list.dart"
//             items: dropdownItemsFeeders,
//             onChanged: (dynamic value){
//               //getDTRByFeeder(value);
//               print("33feeder:"+ value);
//               getFeeders11ByFeeder33(value);
//             },
//             value: _selected33Feeder,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600
//             ),
//           ),
//         );

//         return dropdownButton;
//     }

//     //builds the dropdown for Feeders (11KV)
//     Widget _buildDropDownButton11Feeders(){
//         Widget dropdownButton;
//         dropdownButton = Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(8.0),
//           height: 60.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//             ],
//             borderRadius: BorderRadius.circular(5.0)
//           ),
//           child: DropdownButton(
//             isExpanded: true,
//             //the list "dropdownItemsFeeders" is from "lib/data/dropdown_btn_list.dart"
//             items: dropdownItemsFeeders11,
//             onChanged: (dynamic value){
//               print(value.toString());
//               getDTRByFeeder(value);
//             },
//             value: _selected11Feeder,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600
//             ),
//           ),
//         );

//         return dropdownButton;
//     }

//     Widget _buildDropDownButtonDTR(){
//         Widget dropdownButton;
//         dropdownButton = Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(8.0),
//           height: 60.0,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//             ],
//             borderRadius: BorderRadius.circular(5.0)
//           ),
//           child: DropdownButton(
//             isExpanded: true,
//             //the list "dropdownItemsDTR" is from "lib/data/dropdown_btn_list.dart"
//             items: dropdownItemsDTR,
//             onChanged: (dynamic value){
//               setState(() {
//                 _selectedDTR = value;
//               });
//             },
//             value: _selectedDTR,
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600
//             ),
//           ),
//         );

//         return dropdownButton;
//     }

//     Widget buildPieChartPaymentClassificationSummary(){
//       return Padding(
//         padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//               borderRadius: BorderRadius.circular(10.0),
//               boxShadow: [
//                 BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//               ]
//           ),
//           child: PieChart(
//             dataMap: dataMap,
//             animationDuration: Duration(milliseconds: 800),
//             chartLegendSpacing: 15.0,
//             chartRadius: MediaQuery.of(context).size.width / 1.1,
//             showChartValuesInPercentage: true,
//             showChartValues: false,
//             showChartValuesOutside: false,
//             chartValueBackgroundColor: Colors.grey[200],
//             colorList: colorList,
//             showLegends: true,
//             legendPosition: LegendPosition.right,
//             decimalPlaces: 1,
//             showChartValueLabel: true,
//             initialAngle: 0,
//             chartValueStyle: defaultChartValueStyle.copyWith(
//               color: Colors.blueGrey[900].withOpacity(0.9),
//             ),
//             chartType: ChartType.disc
//       ),
//         ),
//       );
//     }

//     Widget buildCollectionChart(){
//         return Container(
//           margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//           padding: EdgeInsets.all(12.0),
//           height: 200.0,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//               borderRadius: BorderRadius.circular(10.0),
//               boxShadow: [
//                 BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//               ]
//           ),
//           child: Text("Collection bar chart goes here!!!"),
//         );
//     }
    
//     Widget buildBilling(){
//         return Expanded(
//             flex: 5,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 4.0, left: 12.0),
//               child: Container(
//               padding: EdgeInsets.all(12.0),
//               width: double.infinity,
//               height: 180.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: [
//                     BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//                   ]
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "BILLING",
//                     style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0,),
//                   Text(
//                     "Energy Recieved KWH:",
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                   Text(
//                     "166,520,480",
//                     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0,),
//                   Text(
//                     "Energy Billed KWH:",
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                   Text(
//                     "128,664,079",
//                     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0,),
//                   Text(
//                     "Amount Billed N:",
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                   Text(
//                     "4,503,242,778",
//                     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                   ),
                  
//                 ],
//               ),
//           ),
//             ),
//         );
//     }

//     Widget buildCollection(){
//         return Expanded(
//             flex: 5,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 12.0, left: 4.0),
//               child: Container(
//               padding: EdgeInsets.all(12.0),
//               width: double.infinity,
//               height: 180.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: [
//                     BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//                   ]
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "COLLECTION",
//                     style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0,),
//                   Text(
//                     "Target N",
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                   Text(
//                     "3.2 Billion",
//                     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0,),
//                   Text(
//                     "Amt Collect Today",
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                   Text(
//                     "95 Million",
//                     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8.0,),
//                   Text(
//                     "Total Collection as @ Date N",
//                     style: TextStyle(fontSize: 12.0),
//                   ),
//                   Text(
//                     "2.1 Billion",
//                     style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//                   ),
                  
//                 ],
//               ),
//           ),
//             ),
//         );
//     }

//     Widget buildRevenueProtection(){
//           return Container(
//             margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//             padding: EdgeInsets.all(12.0),
//             height: 200.0,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.white,
//                 borderRadius: BorderRadius.circular(10.0),
//                 boxShadow: [
//                   BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//                 ]
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   "REVENUE PROTECTION",
//                   style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 12.0,),
//                 buildRowRevenueProtection("Total Disconnection:", "5,000"),
//                 SizedBox(height: 8.0,),
//                 buildRowRevenueProtection("Expected Revenue N:", "35,000,000"),
//                 SizedBox(height: 8.0,),
//                 buildRowRevenueProtection("Total Reconnection:", "3,000"),
//                 SizedBox(height: 8.0,),
//                 buildRowRevenueProtection("Revenue Recovered N:", "30,000,000"),
//                 SizedBox(height: 8.0,),
//                 buildRowRevenueProtection("Revenue Protection KPI:", "85% / Very Good"),
                
//               ],
//             ),
//           );

//       }

//     /*Widget buildDropDownButtonCumulativePerformance(){
//       return Padding(
//                 padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12),
//                 child: Column(  
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text("Cumulative Peformance Report",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white
//                       )
//                     ),
//                     SizedBox(height: 8.0,),
//                     Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.all(2.0),
//                     padding: EdgeInsets.all(8.0),
//                     height: 60.0,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       boxShadow: [
//                         BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//                       ],
//                       borderRadius: BorderRadius.circular(5.0)
//                     ),
//                     child: DropdownButton(
//                       items: dropdownItemsCumulativePerformance,
//                       onChanged: (dynamic value){
//                         print("cumulative performance report: $value");
//                         setState(() {
//                           selectedZone = value;
//                         });
//                       },
//                       value: selectedZone,
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600
//                       ),
//                     ),
//               ),
//                   ],
//                 ),
//       );
//     }
//     */

//     Widget buildDataTableCollectionEfficiency(){
//     return SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//           padding: EdgeInsets.all(12.0),
          
//           decoration: BoxDecoration(
//             color: Colors.white,
//               borderRadius: BorderRadius.circular(10.0),
//               boxShadow: [
//                 BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//               ]
//           ),
//           child: Column(
//               children: <Widget>[
//                 Text("Collection Efficiency @ 28th June 2020",
//                   style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blue),
//                 ),
//                 Container(
//                   width: double.infinity,
//                   child: DataTable(
//                   columns: [
//                     DataColumn(label: Text("Category")),
//                     DataColumn(label: Text("Billed")),
//                     DataColumn(label: Text("Collection")),
//                     DataColumn(label: Text("Coll.Eff%")),
//                     DataColumn(label: Text("Response"))
//                   ],
//                   rows: [
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("MD")),
//                         DataCell(Text("1,123")),
//                         DataCell(Text("873.1")),
//                         DataCell(Text("82.3%")),
//                         DataCell(Text("2,490"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("PPM")),
//                         DataCell(Text("453")),
//                         DataCell(Text("442.1")),
//                         DataCell(Text("")),
//                         DataCell(Text("150,963"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("Non MD Postpaid")),
//                         DataCell(Text("2,755")),
//                         DataCell(Text("754.5")),
//                         DataCell(Text("27%")),
//                         DataCell(Text("143,014")),
                        
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("Bank Uncaptured payment")),
//                         DataCell(Text("")),
//                         DataCell(Text("51.2")),
//                         DataCell(Text("")),
//                         DataCell(Text(""))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("TOTAL")),
//                         DataCell(Text("4,311")),
//                         DataCell(Text("2,120.8")),
//                         DataCell(Text("49%")),
//                         DataCell(Text("296,407"))
//                       ]
//                     ),
//                   ],
//                     ),
//                 ),
//               ],
//             ),
          
//           ),
//     );
//     }

//     Widget buildDataTableImprovemntImpactAnalysis(){
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//         padding: EdgeInsets.all(12.0),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//             ]
//         ),
//         child: Column(
//             children: <Widget>[
//               Text("Improvement Impact Analysis Comapare to Last Month as @ 28th June 2020",
//                 style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blue),
//               ),
//               Container(
//                 width: double.infinity,
//                 child: DataTable(
//                   columns: [
//                     DataColumn(label: Text("Category")),
//                     DataColumn(label: Text("Response")),
//                     DataColumn(label: Text("Collection"))
//                   ],
//                   rows: [
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("MD")),
//                         DataCell(Text("40.87%")),
//                         DataCell(Text("25.7%"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("PPM")),
//                         DataCell(Text("-9.12%")),
//                         DataCell(Text("-10.25%"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("Non MD Postpaid")),
//                         DataCell(Text("18.8%")),
//                         DataCell(Text("28.7%"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("Bank Uncaptured payment")),
//                         DataCell(Text("")),
//                         DataCell(Text(""))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("TOTAL")),
//                         DataCell(Text("306.9")),
//                         DataCell(Text("8,234"))
//                       ]
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
        
//         );
//     }

//     Widget buildDataTableVarFromLastMonth(){
//     return Container(
//         margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//         padding: EdgeInsets.all(12.0),
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//             borderRadius: BorderRadius.circular(10.0),
//             boxShadow: [
//               BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//             ]
//         ),
//         child: Column(
//             children: <Widget>[
//               Text("Var from last month @ 28th June 2020",
//                 style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blue),
//               ),
//               Container(
//                 width: double.infinity,
//                 child: DataTable(
//                   columns: [
//                     DataColumn(label: Text("Category")),
//                     DataColumn(label: Text("Desc")),
//                     DataColumn(label: Text("Response"))
//                   ],
//                   rows: [
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("MD")),
//                         DataCell(Text("189.0")),
//                         DataCell(Text("705"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("PPM")),
//                         DataCell(Text("-50.5")),
//                         DataCell(Text("-15,147"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("Non MD Postpaid")),
//                         DataCell(Text("168.4")),
//                         DataCell(Text("22,676"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("Bank uncaptured payment")),
//                         DataCell(Text("")),
//                         DataCell(Text(""))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("TOTAL")),
//                         DataCell(Text("306.9")),
//                         DataCell(Text("8,234"))
//                       ]
//                     ),

//                   ],
//                 ),
//               ),
//             ],
//           ),
        
//         );
//     }

//     Widget buildTableClassificationSummary(){
//         return Container(
//           margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
//           padding: EdgeInsets.all(12.0),
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.white,
//               borderRadius: BorderRadius.circular(10.0),
//               boxShadow: [
//                 BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//               ]
//           ),
//           child: Column(
//             children: <Widget>[
//               Text("Payment Classification Summary as @ 28th June 2020",
//                 style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.blue),
//               ),
//               Container(
//                 width: double.infinity,
//                 child: DataTable(
//                   columns: [
//                     DataColumn(label: Text("Category")),
//                     DataColumn(label: Text("Description")),
//                     DataColumn(label: Text("Population"))
//                   ],
//                   rows: [
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("A")),
//                         DataCell(Text("Prompt payment with no arrears")),
//                         DataCell(Text("2,377"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("B")),
//                         DataCell(Text("Prompt payment still owing arrears")),
//                         DataCell(Text("22,711"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("C")),
//                         DataCell(Text("Paid last 3 months ago still owing arrears")),
//                         DataCell(Text("14,6987"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("D")),
//                         DataCell(Text("Paid last over three months ago still owing")),
//                         DataCell(Text("44,880"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: true,
//                       cells: [
//                         DataCell(Text("E")),
//                         DataCell(Text("Paid last six months ago still owing arrears")),
//                         DataCell(Text("705"))
//                       ]
//                     ),
//                     DataRow(
//                       selected: false,
//                       cells: [
//                         DataCell(Text("F")),
//                         DataCell(Text("Paid last over six months ago and owing arrears")),
//                         DataCell(Text("263,322"))
//                       ]
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
        
//         );
//     }

//     Widget buildRowRevenueProtection(String key, String value){
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text(key, style: TextStyle(fontSize: 12.0)),
//             Text(value,
//               style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//             )
//           ],
//         );
//     }

//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//           key: scaffoldKey,
//           appBar: AppBar(
//               title: Text("Smart Insights"),
//           ),
//           body: Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/bgg.png'),
//                   fit: BoxFit.cover,
//                   colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
//                 )
//             ),
//             child: ListView(
//               children: <Widget>[
//                 //buildCollectionChart(),
//                 //buildDropDownButtonCumulativePerformance(),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 12.0),
//                   child: Row(children: <Widget>[
//                       Expanded(flex: 5, child: _buildDropDownButtonZones()),
//                       SizedBox(width: 5,),
//                       Expanded(flex: 5, child: _buildDropDownButton33Feeders()),
//                   ],),
//                 ),             
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Row(children: <Widget>[
//                       Expanded(flex: 5, child: _buildDropDownButton11Feeders()),
//                       SizedBox(width: 5,),
//                       Expanded(flex: 5, child: _buildDropDownButtonDTR(),),
//                   ],),
                  
//                 ),
//                 HorizontalPatternForwardHatchBarChart(),
//                 Row(
//                    children: <Widget>[
//                       buildBilling(),
//                       buildCollection()
//                    ],
//                 ),
//                 //BarChartSample2(),
//                 //HorizontalPatternForwardHatchBarChart(),
//                 buildRevenueProtection(),
//                 buildDataTableCollectionEfficiency(),
//                 buildDataTableImprovemntImpactAnalysis(),
//                 buildDataTableVarFromLastMonth(),
//                 buildTableClassificationSummary(),
//                 buildPieChartPaymentClassificationSummary(),
               
//               ],
//             ),
//           ),
//       );
//   }
// }