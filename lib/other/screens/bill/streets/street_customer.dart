// import 'package:flutter/material.dart';
// import '../../../controllers/billDistribution/billcustomer_controller.dart';
// import '../../../models/customer.dart';
// import '../../../screens/bill/customer/billNewCustomer.dart';
// import '../../../widgets/dclist/cus.dart';

// import '../bd_details.dart';

// class BDCustomerSearch extends StatefulWidget {


//   @override
//   _BDCustomerSearchState createState() => _BDCustomerSearchState();
// }

// class _BDCustomerSearchState extends State<BDCustomerSearch> {

  
//   String accountno;
//     bool isLoading = false; 
//     String statusMsg = "Enter account number to search";
//   //List<Customer> _currentList;
//    List<Customer> returnedCustomer = List<Customer>();
//    //Streets
//    BillCustomerController billCustomerController = new BillCustomerController();


//     Widget _buildSearchTextField(){
//         return  Container(
//           margin: EdgeInsets.all(4.0),
//           child: Row(
//             children: <Widget>[
//               Expanded(
//                     child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search customer",
//                       fillColor: Colors.white,
//                       filled: true,
//                       prefixIcon: IconButton(
//                         icon: Icon(Icons.search, size: 24.0,),
//                         onPressed: (){},
//                       ),
//                     ),
//                     onChanged: (value){
//                         accountno = value;
//                     },
//                   ),
//               ),
//             ],
//           ),
//       );
//     }
//       //search button widget
//   Widget _buildSubmitButton(){
//       return GestureDetector(
//         onTap: (){
//             getSearchedCustomer();
//           },
//           child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 60.0),
//           alignment: Alignment.center,
//           height: 45.0,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30.0),
//             color: Colors.green
//           ),
//           child: Text(
//             "Search",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18.0,
//                 fontWeight: FontWeight.w600
//               ),
//           ),
//         ),
//       );
//   }
//       Widget _buildCustomerList(){
//           return  Expanded(
//           child: ListView.builder(
//             physics: BouncingScrollPhysics(),
//             itemCount: returnedCustomer.length,
//             itemBuilder: (BuildContext context, int index){
//               Customer customer =  returnedCustomer[index];
//               return InkWell(
//               onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => BillDetailsScreen(customer))),
//               child: Container(
//                   margin: EdgeInsets.only(top: 2.0, bottom: 5.0),
//                   padding: EdgeInsets.all(12.0),
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10.0),
//                       boxShadow: [
//                         BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
//                       ]
//                   ),
//                   //child: CustomerRowItem(customer: customer)
//                   child: CustomerRowItem(customer: customer)
//                   )
//                 );
//             }
//           )
//         );
//       }

//       //search customer account
//       getSearchedCustomer() async{
// //08032693563 chiamaka
// //print ("streeids"+Constants.streetCode);
//           //check if account no is empty
//           if(accountno == null || accountno.toString().trim().length < 1){
//               return;
//           }
//           setState(() => isLoading = true);
//         //call API endpoint for fetching disconnection list
//         //The controller method for calling the API endpoint is found @ "lib/controller/disconnection_controller.dart"
//          List<Customer> tem;
//           tem = await billCustomerController.getCustomerByAccountno(accountno);
//        // _currentStreetsByDTRList = streetsByDTRList;
//         //print(returnedCustomer[0].accountNo);
//         if(tem.length < 1){
//           setState((){
//             statusMsg = "No record found!";
//             isLoading = false;
//           } );
//           return;
//         }

//         //Set loading state to false when the API endpoint returns a response
//         setState(() { 
//             returnedCustomer = tem;
//             isLoading = false;
//         });

//         //call function to build screen content
//        // _buildCustomerList();
//     }


//     Future<bool> _onBackPressed() async {
//       Navigator.pushNamed(context, '/bd_home');
//       return true;
//     }


//     @override
//     Widget build(BuildContext context) {
//         return WillPopScope(
//             onWillPop: _onBackPressed,
//             child: Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () => Navigator.pushReplacementNamed(context, '/bd_home'),
//               ),
//               title: Text("Street Customers"),
//               actions: <Widget>[
//                 Padding(
//                 padding: const EdgeInsets.only(right: 5.0, top: 5.0),
//                 child: FlatButton(
//                   textColor: Colors.white,
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => BillNewCustomer(c)));
//                   },
//                   child: Text("New Customer"),
//                   shape:
//                       CircleBorder(side: BorderSide(color: Colors.transparent)),
//                 ))
//               ],
//             ),
//             body: Container(
//                decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/bgg.png'),
//                   fit: BoxFit.cover,
//                   colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
//                 )
//               ),
//               child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: <Widget>[
//                       //_buildFilterCard(),
//                       //SizedBox(height: 10.0),
//                       _buildSearchTextField(),
//                       SizedBox(height: 2.0),
//                       !isLoading ? _buildSubmitButton() : 
//                       Container(
//                         height: 30,
//                         width: 30,
//                         child: CircularProgressIndicator(                    
//                           valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
//                         ),
//                       ),
//                         SizedBox(height: 10.0),
//                         returnedCustomer.length < 1 ? Container(
//                           child: Text(
//                             statusMsg,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ) : _buildCustomerList()
//                     ],
//                   ),
//                 ),
//             ),
//           ),
//         );
//       }




// }