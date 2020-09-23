// import 'package:flutter/material.dart';
// import '../../../controllers/billDistribution/streetsController.dart';
// import '../../../models/customer.dart';
// import '../../../screens/bill/streets/street_customer.dart';
// import '../../../utilities/alert_dialog.dart';
// import '../../../widgets/dclist/cus.dart';

// import '../bd_details.dart';
// import '../constans.dart';

// class StreetCustomerList extends StatefulWidget {
//   final String streetCode;
//   final String streetName;
//   StreetCustomerList(this.streetCode, this.streetName);

//   @override
//   _StreetCustomerList createState() => _StreetCustomerList(streetCode);
// }

// class _StreetCustomerList extends State<StreetCustomerList> {
//   final StreetsController streetCustomerList = StreetsController();
//   List<Customer> _currentList = List<Customer>();
//   List<Customer> currentList;
//   Widget pageContent;
//   bool isLoading = true;
//   String streetCode;
//   String actionCount;
//   _StreetCustomerList(this.streetCode);

//   //filter a particular customer from the list of customers using account number
//   _filterCustomer(String accountNo) {
//     List<Customer> filteredList;
//     // _buildLoadingModal();
//     showAlertDialog(
//         context: context, isLoading: true, loadingMsg: "Fetching customer");
//     Future.delayed(Duration(seconds: 2), () {
//       filteredList = _currentList.where((item) {
//         return item.address == accountNo;
//       }).toList();

//       //NOTE
//       //display a modal if no customer was found with account no
//       //message: No customer found

//       setState(() {
//         _currentList = filteredList;
//       });
//       Navigator.of(context).pop();
//     });
//   }

//   /*  _buildLoadingModal(){
  
//       showDialog(context: context, builder: (BuildContext context){
//           return AlertDialog(
//             title: Text(
//               "Fetching customer...",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.0,
//               ),
//             ),
//             content: Image(
//               image: AssetImage("assets/images/loader.gif"),
//               height: 40,
//               width: 40,
//               fit: BoxFit.contain,
//             ),
//           );
//       });
//     }

//     */

//   //builds the search text field
//   Widget _buildSearchTextField() {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: TextField(
//               keyboardType: TextInputType.number,
//               maxLength: 12,
//               decoration: InputDecoration(
//                 hintText: "Filter records",
//                 fillColor: Colors.white,
//                 filled: true,
//                 prefixIcon: IconButton(
//                   icon: Icon(
//                     Icons.search,
//                     size: 24.0,
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               onChanged: (value) {
//                 if (value.toString().trim().length == 12) {
//                   _filterCustomer(value);
//                 }
//                 if (value.toString().trim().length == 0) {
//                   setState(() {
//                     _currentList = currentList;
//                   });
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void initState() {
//     Constants.streetCode = streetCode;
//     Constants.streetName = widget.streetName;
//     print("xxxx-streetid: " + streetCode.toString());
//     actionCount = "0";
//     //fetch disconnection List
//     fetchCustomersList();
//     super.initState();
//   }

//   fetchCustomersList() async {
//     //call API endpoint for fetching disconnection list
//     //The controller method for calling the API endpoint is found @ "lib/controller/disconnection_controller.dart"

//     Map<String, dynamic> res =
//         await streetCustomerList.getCustomersByStreets(streetCode);

//     print(res.toString());
//     _currentList = res["data"];

//     setState(() {
//       isLoading = false;
//       actionCount = res["count"];
//       pageContent = _buildPageContent(res["status"]);
//     });
//   }

//   /*
//     * This methods dynamically returns the screen content based on
//      the state of the API call
//     */
//   Widget _buildPageContent(String status) {
//     Widget pageContent;

//     if (status != "SUCCESS") {
//       pageContent = Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//             child: Text(
//           "Ooop...\nwe couldn't not fetch customers for the selected street." +
//               "Please try again",
//           textAlign: TextAlign.center,
//         )),
//       );
//     } else {
//       //Still awaiting API response: display a circular progress bar
//       if (isLoading) {
//         pageContent = Center(child: CircularProgressIndicator());
//       }
//       //API Response returned with no customer: display message
//       else if (!isLoading && _currentList.length == 0) {
//         pageContent = Center(
//             child: Text(
//           "No Customer found!\n Tap the search button to search",
//           textAlign: TextAlign.center,
//         ));
//       }
//       //API response with customer(atleast 1): display customer list
//       else {
//         pageContent = _buildMainContent();
//       }
//     }

//     //return page content;
//     return pageContent;
//   }

//   //The method builds the main page when atleast one customer is found
//   Widget _buildMainContent() {
//     return RefreshIndicator(
//       onRefresh: () {
//         //setState(() => _currentList = dcCustomerList);
//         return Navigator.pushNamed(context, "/disconnection_list");
//       },
//       child: Container(
//          decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/bgg.png'),
//               fit: BoxFit.cover,
//               colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
//             )
//           ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: <Widget>[
//               _buildSearchTextField(),
//               SizedBox(height: 10.0),
//               Expanded(
//                 child: ListView.builder(
//                     physics: BouncingScrollPhysics(),
//                     itemCount: _currentList.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       Customer customer = _currentList[index];

//                       return new InkWell(
//                           onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       BillDetailsScreen(customer))),
//                           child: Container(
//                               margin: EdgeInsets.only(top: 2.0, bottom: 5.0),
//                               padding: EdgeInsets.all(12.0),
//                               decoration: BoxDecoration(
//                                   //customer.delivered != null && customer.delivered.toString() == "1" ? 
//                                   color : customer.delivered != null && customer.delivered.toString() == "1" ? Colors.blue[100]: Colors.white,
//                                   borderRadius: BorderRadius.circular(10.0),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         blurRadius: 6.0,
//                                         offset: Offset(0, 2),
//                                         color: Colors.black12)
//                                   ]),
//                               child: CustomerRowItem(customer: customer)));
//                     }),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  
//   Future<bool> _onBackPressed() async {
//       Navigator.pushNamed(context, '/bd_street_list');
//       return true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new WillPopScope(
//         onWillPop: _onBackPressed,
//         child: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () =>  Navigator.pushNamed(context, '/bd_street_list')
//           ),
//           title: Text(
//             "${widget.streetName} Customers ($actionCount)",
//             style: TextStyle(
//               fontSize: 15.0
//             ),),
//           actions: <Widget>[
//             Padding(
//                 padding: const EdgeInsets.only(right: 5.0, top: 5.0),
//                 child: FlatButton(
//                   textColor: Colors.white,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => BDCustomerSearch()),
//                     );
//                   },
//                   child: Text("Search"),
//                   shape:
//                       CircleBorder(side: BorderSide(color: Colors.transparent)),
//                 ))
//           ],
//         ),
//         body:
//             isLoading ? Center(child: CircularProgressIndicator()) : pageContent,
//       ),
//     );
//   }
// }
