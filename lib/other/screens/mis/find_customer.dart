import '../../data/active_dtr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/rpd/rpd_controller.dart';
import '../../data/data.dart';
import '../../models/customer.dart';
import '../../screens/mis/customer_details.dart';
import '../../utilities/alert_dialog.dart';
import '../../widgets/dclist/customer_row_item.dart';

class MISFindCustomer extends StatefulWidget {

  @override
  _MISFindCustomerState createState() => _MISFindCustomerState();
}


class _MISFindCustomerState extends State<MISFindCustomer> {

  final RPDController model = RPDController();
  List<Customer> _currentList = List<Customer>();
  String sortingAccountMeterNo;
  final numberFormat = new NumberFormat("#,##0.00", "en_US");
  bool isLoading = true;
  Widget pageContent;
  String accountNo;
  String appBarTitle;

   //builds the search text field
    Widget _buildSearchTextField(){
        return  Container(
          child: Row(
            children: <Widget>[
              Expanded(                    
                    child: TextField(
                    decoration: InputDecoration(
                      labelText: "Account/Meter Number",
                      hintText: "Enter Here",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search, size: 24.0,),
                        onPressed: fetchCustomer
                          //print("fdsdsd");
                      ),
                    ),
                    onChanged: (value){
                      accountNo = value;
                      if(value.toString().trim().length == 0){
                        setState(() {
                            _currentList = dcCustomerList;
                        });
                      }      
                    },
                  ),
              ),
            ],
          ),
        );
    }

    
    @override
    void initState() {
      pageContent = _buildMainContent();
      super.initState();
    }


    fetchCustomer() async{

        showAlertDialog(
          context: context, 
          isLoading: true, 
          loadingMsg: "fetching customer"
        );

        //call API endpoint for fetching disconnection list"861147302801"
        //The controller method for calling the API endpoint is found @ "lib/controller/disconnection_controller.dart" 
        Map<String, dynamic> res  = await model.findCustomer(accountNo);
         //await model.fetchCustomerDisconnectionList();

        print(res["message"]);
        Navigator.pop(context);
        setState(() {
            isLoading = false;
        });

        //Set loading state to false when the API endpoint returns a response
        if(res != null && res["status"] == "SUCCESS"){
            _currentList = res["data"];
            _buildPageContent(error: false);
            showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  title: Text(
                    "1 Customer found",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  content: Icon(
                    Icons.done,
                    color: Colors.green,
                    size: 60.0,
                  ), 
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OKay"),
                      onPressed: (){
                        Navigator.pop(context);
                       // Navigator.pushReplacement(
                       //   context, 
                       //   MaterialPageRoute(builder: (context) => ReconnectionListScreen(verifyAccountNo:accountNo))
                       // );
                        
                      }
                    )
                  ],
                );
            });
        }
        if(res != null && res["status"] == "FAILED"){
            showAlertDialog(
              context: context, 
              isLoading: false, 
              isSuccess: false,
              completedMsg: res["message"]
            );
        }
        else{
            _buildPageContent(error: true);
        }
       
    }


    Future<bool> _onBackPressed() async {
        Navigator.pushReplacementNamed(context, '/modules');
        return true;
    }

    
    /*
    * This methods dynamically returns the screen content based on the state of the API call
    */
    void _buildPageContent({bool error}){

      
        //Still awaiting API response: display a circular progress bar
        if(!error){
            if(isLoading){
             pageContent =  Center(child: CircularProgressIndicator());
            }
            //API Response returned with no customer: display message
            else if(!isLoading && _currentList.length ==0){
              pageContent = Center(
                child: Text("AccountNo $accountNo did not pass the test for reconnection and has not been added to the reconnection")
              );
            }
            //API response with customer(atleast 1): display customer list
            else{
              pageContent = _buildMainContent();
            }
        }
        else{
           // showAlertDialog(isLoading: false, isSuccess: false, completedMsg: "Ooop..temporarily unable to fetch data. Refresh and try again");
            pageContent = Center(
              child: Text("Oops...temporarily unable to fetch customers.\nPlease try again"));
        }
      

        //return page content;
        //return pageContent;

    }


    
    //The method builds the main page when atleast one customer is found
    Widget _buildMainContent(){
         return Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _currentList.length,
              itemBuilder: (BuildContext context, int index){
                Customer customer = _currentList[index];
                return InkWell(
                onTap: () => Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context)=> MisCustomerDetailsScreen(customer, flag: "rpd"))
                ),
                child: Container(                    
                    margin: EdgeInsets.only(top: 2.0, bottom: 5.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
                        ]
                    ),
                    child: CustomerRowItem(customer: customer)
                    )
                  );
              }
            ),
        );
    }

    
    @override
    Widget build(BuildContext context) {

        if(activeMISDisconnect == "DTR_DISCONNECT"){
          appBarTitle = "DTR Disconnect Customer";
        }
        if(activeMISDisconnect == "TARRIF_CHANGE"){
          appBarTitle = "Tariff Change";
        }
        if(activeMISDisconnect == "MIS"){
          appBarTitle = "MIS Find Customer";
        }
        if(activeMISDisconnect == "ACCOUNT_SEPERATION"){
          appBarTitle = "Account Seperation";
        }
        print(activeMISDisconnect);
       
        return new WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 24.0,
                onPressed: () => Navigator.pushReplacementNamed(context, '/modules'),
              ),
              title: Text(
                appBarTitle,
                style: TextStyle(
                  fontSize: 14.0
                ),
              ),
              actions: [
                activeMISDisconnect == "ACCOUNT_SEPERATION" ? IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () => Navigator.pushNamed(
                    context, 
                    '/pending_account_seperation'
                  ),
                ): Container()
              ]
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
              padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    _buildSearchTextField(),
                    SizedBox(height: 16.0),
                    _currentList.length > 0 ? _buildMainContent() : Container()
                  ],
                ),
              ),
            )
          ),
        );
      }

}