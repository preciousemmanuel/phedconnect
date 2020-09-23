// import 'package:flutter/material.dart';
// import '../../../controllers/billDistribution/streetsController.dart';
// import '../../../models/billDistribution/streets_model.dart';
// import '../../../screens/bill/streets/street_add.dart';
// import '../../../screens/bill/streets/street_customer_list.dart';
// import '../../../utilities/alert_dialog.dart';
// class BDStreetList extends StatefulWidget {

//   @override
//   _BDStreetListState createState() => _BDStreetListState();
// }



// class _BDStreetListState extends State<BDStreetList> {


//     AsyncSnapshot streetSnapshot;
//     StreetsController listStreetsController = StreetsController();
//     List<StreetsModel> _currentStreetsByDTRList;
//     List<StreetsModel> streetsByDTRList;
//     bool isLoading = true;
//     StreetsModel streetsModelIndex;
//     Widget pageContent;


//     @override
//     void initState() {
      
//       fetchStreetsByDTRList();
//       super.initState();

//     }


//     fetchStreetsByDTRList() async{

//         //call API endpoint for fetching disconnection list
//         //The controller method for calling the API endpoint is found @ "lib/controller/disconnection_controller.dart"
       
//         Map<String, dynamic> res = await listStreetsController.getStreetsByDtrid();

//         if(res["status"] == "SUCCESS"){
//           _currentStreetsByDTRList = res["data"];
//         }
//         //Set loading state to false when the API endpoint returns a response
//         setState(() {
//           isLoading = false;
//           pageContent = _buildPageContent(res["status"]);
            
//         });

//         //call function to build screen content
       
//     }
 

//     //filter a particular customer from the list of customers using account number
//     _filterStreets(String streetName){

//         List<StreetsModel> filteredStreetList;
//        // _buildLoadingModal();
//         showAlertDialog(context: context, isLoading: true, loadingMsg: "Fetching customer");
//         Future.delayed(Duration(seconds: 2), (){
//             filteredStreetList =  _currentStreetsByDTRList.where((item){
//               return item.streetName == streetName || item.nearestbusstop==streetName;
//             }).toList();

//             //NOTE
//             //display a modal if no street was found with account no
//             //message: No street found

//             setState(() {
//               _currentStreetsByDTRList = filteredStreetList;
//             });
//             Navigator.of(context).pop();
//         });
//     }
//      //builds the search text field
   
   
//     Widget _buildSearchTexBoxtField(){
//     return  Container(
//       child: Row(
//         children: <Widget>[
//           Expanded(
//                 child: TextField(
//                 keyboardType: TextInputType.number,
//                 maxLength: 12,
//                 decoration: InputDecoration(
//                   hintText: "Filter records",
//                   fillColor: Colors.white,
//                   filled: true,
//                   prefixIcon: IconButton(
//                     icon: Icon(Icons.search, size: 24.0,),
//                     onPressed: (){},
//                   ),
//                 ),
//                 onChanged: (value){
//                   if(value.toString().trim().length == 12){
//                       _filterStreets(value);
//                   }
//                   if(value.toString().trim().length == 0){
//                     setState(() {
//                     _currentStreetsByDTRList = streetsByDTRList;
//                     });
//                   }
//                 },
//               ),
//           ),
//         ],
//       ),
//     );
// }
  
//     Widget _buildStreetRowItem(StreetsModel streetsModelIndex){

//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Icon(
//                   Icons.location_on,
//                   color: Colors.green,
//                   size: 18.0,
//                 ),
//                 SizedBox(width: 8.0,),
//                 Expanded(
//                     child: Text(streetsModelIndex.streetName,
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.blue
//                     ),
//                     overflow: TextOverflow.visible, 

//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 3.0),
//             Row(
//               children: <Widget>[
//                 Icon(
//                   Icons.flag,
//                   color: Colors.green,
//                   size: 18.0,
//                 ),
//                 SizedBox(width: 8.0,),
//                 Expanded(
//                     child: Text("Com : "+streetsModelIndex.community,
//                     style: TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.blue
//                     ),
//                     overflow: TextOverflow.visible, 
                  
//                   ),
//                 ),
//               ],
//             ),
//             /*Image(
//                 image: AssetImage("assets/images/headerLogo.jpg"),
//                 width: 40.0,
//                 height: 40.0,
//                 fit: BoxFit.contain,
//             )*/
            
//           ]
          
//         );
//     }
//   /*
//     * This methods dynamically returns the screen content based on
//      the state of the API call
//     */
//    Widget _buildPageContent(String status){

//         Widget pageContent;


//         if(status != "SUCCESS"){
//             pageContent =  Center(
//               child: Text(
//                 "Ooop...we couldn't not fetch the streets for the selected DTR."+
//                 "Please try again"
//               )
//             );
//         }
//         else{
            
//             //Still awaiting API response: display a circular progress bar
//             if(isLoading){
            
//                 pageContent =  Center(child: CircularProgressIndicator());
//             }
//             //API Response returned with no customer: display message
//             else if(!isLoading && _currentStreetsByDTRList.length ==0){
              
//               pageContent = Center(child: Text("No street found!\n"));
//             }
//             //API response with customer(atleast 1): display customer list
//             else{
//               pageContent = _buildMainContent();
//             }

//             //return page content;
//             //return pageContent;
//         }

//         return pageContent;
      
//     }
//       //The method builds the main page when atleast one customer is found
//     Widget _buildMainContent(){
//     return RefreshIndicator(
      
//           onRefresh: (){
//             //setState(() => _currentList = dcCustomerList);
//             return Navigator.pushNamed(context, "/streetscustomer_list");
//           },
//           child: Container(
//              decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/bgg.png'),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
//               )
//             ),
//             child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: <Widget>[
//                 _buildSearchTexBoxtField(),
//                 SizedBox(height: 10.0),
//                 Expanded(
//                     child: ListView.builder(
//                       physics: BouncingScrollPhysics(),
//                       itemCount: _currentStreetsByDTRList.length,
//                       itemBuilder: (BuildContext context, int index){
//                         StreetsModel streetsModelIndex = _currentStreetsByDTRList[index];
//                         print(streetsModelIndex.streetName);
//                         print(streetsModelIndex.streetcode);
//                         return Dismissible(
//                               key: Key(streetsModelIndex.streetcode.toString()),
//                               background: Container(color: Colors.red),
//                               onDismissed: (DismissDirection direction){
//                                   if(direction == DismissDirection.endToStart){                              
//                                     setState( (){
//                                         _currentStreetsByDTRList.removeAt(index);
                                  
//                                     }); 
//                                   }
//                               },
//                               child: InkWell(
//                               onTap: () => Navigator.push(
//                                 context, 
//                                 MaterialPageRoute(builder: (context)=> StreetCustomerList(
//                                   streetsModelIndex.streetcode,
//                                   streetsModelIndex.streetName
//                                 ))
//                               ),
//                               child: Container(                    
//                                   margin: EdgeInsets.only(top: 2.0, bottom: 5.0),
//                                   padding: EdgeInsets.all(12.0),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                       borderRadius: BorderRadius.circular(10.0),
//                                       boxShadow: [
//                                         BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//                                       ]
//                                   ),
//                                   child: _buildStreetRowItem(streetsModelIndex)
//                             )
//                           ),
//                         );
//                       }
//                     ),
//                 )
//               ],
//             ),
//         ),
//           ),
//       );
// }


//   Future<bool> _onBackPressed() async {
//       Navigator.pushNamed(context, '/bd_home');
//       return true;
//   }

//    @override
//       Widget build(BuildContext context) {
//           return WillPopScope(
//               onWillPop: _onBackPressed,
//               child: Scaffold(
//               appBar: AppBar(
//                 leading: IconButton(
//                   onPressed: () => Navigator.pushNamed(context, '/bd_home'),
//                   icon: Icon(Icons.arrow_back),
//                 ),
//                 title: Text("My Streets"),
//                 actions: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(right: 16.0, top: 20.0),
                    
//                   ),
//                   FlatButton(
//                   textColor: Colors.white,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => BDStreetAdd()),
//                         );
//                   },
//                   child: Text("Add Street"),
//                   shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
//                 ),
//                 ],
//               ),
//               body: isLoading ? Center(child: CircularProgressIndicator()) : pageContent
//             ),
//           );
//         }
// }