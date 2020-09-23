import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/activities/rcdc_activities_controller.dart';
import '../../models/customer.dart';
import '../../utilities/alert_dialog.dart';
import '../../widgets/activities/rcdc_row_item.dart';
import '../../data/active_dtr.dart';

class RCDCActivitiesScreen extends StatefulWidget {
    
  @override
  _RCDCActivitiesScreenState createState() => _RCDCActivitiesScreenState();
}


class _RCDCActivitiesScreenState extends State<RCDCActivitiesScreen> {

    final RCDCActivitiesController model = RCDCActivitiesController();
    List<Customer> _currentList = List<Customer>();
    List<Customer> _dcCustomerList = List<Customer>();
    String sortingAccountMeterNo;
    final numberFormat = new NumberFormat("#,##0.00", "en_US");
    bool isLoading = true;
    Widget pageContent;
     
    //filter a particular customer from the list of customers using account number
    _filterCustomer(){

        print(sortingAccountMeterNo);
        if(sortingAccountMeterNo.toString().trim().length == 0 || sortingAccountMeterNo == null){
            showAlertDialog(
              context: context, 
              isLoading: false, 
              isSuccess: false, 
              completedMsg: "Please enter an account/meter no"
            );

            return;
        }    

        List<Customer> filteredList = List<Customer>();
       // _buildLoadingModal();
       // showAlertDialog(context: context, isLoading: true, loadingMsg: "Fetching customer");
       
           

            filteredList = _dcCustomerList.where((item){

              return item.accountNo.toLowerCase().contains(sortingAccountMeterNo.toLowerCase()) || 
              item.accountName.toLowerCase().contains(sortingAccountMeterNo.toLowerCase());
            }).toList();


            if(filteredList.length < 1){
              Navigator.pop(context); //remove the first alert dialog
              showAlertDialog(
                context: context, 
                isLoading: false, 
                isSuccess: false, 
                completedMsg: "No record found"
              );

              return;
            }

            setState(() {
              _currentList = filteredList;
            });
            _buildPageContent(error:false);
            //Navigator.of(context).pop();
      
    }

   
    //builds the search text field
    Widget _buildSearchTextField(){
    return  Container(
      child: Row(
        children: <Widget>[
          Expanded(                    
                child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Filter records",
                  hintText: "Account/Meter Number",
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, size: 24.0,),
                    onPressed: _filterCustomer
                      //print("fdsdsd");
                  ),
                ),
                onChanged: (value){
                  sortingAccountMeterNo = value;
                  if(value.toString().trim().length == 0){
                    setState(() {
                        _currentList = _dcCustomerList;
                    });
                    _buildPageContent(error:false);
                  }
                  else{
                    _filterCustomer();
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

      //fetch disconnection List
      fetchCustomerDCList();
      super.initState();
    }


    fetchCustomerDCList() async{


        //call API endpoint for fetching disconnection list
        //The controller method for calling the API endpoint is found @ "lib/controller/disconnection_controller.dart" 
        Map<String, dynamic> res  = await model.myActivityDisconnection();
         //await model.fetchCustomerDisconnectionList();

        setState(() {
            isLoading = false;
        });

        //Set loading state to false when the API endpoint returns a response
        if(res != null && res["status"] == "SUCCESS"){
            _dcCustomerList = res["data"];
            _currentList = _dcCustomerList;
            _buildPageContent(error: false);
        }
        else{
            _buildPageContent(error: true);
        }
       
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
            else if(!isLoading && _currentList.length == 0){
              pageContent = Center(child: Text("No activities found!"));
            }
            //API response with customer(atleast 1): display customer list
            else{
              pageContent = _buildMainContent();
            }
        }
        else{
           // showAlertDialog(isLoading: false, isSuccess: false, completedMsg: "Ooop..temporarily unable to fetch data. Refresh and try again");
            pageContent = Center(child: Text("Oops...temporarily unable to fetch customers.\nPlease try again"));
        }
      

        //return page content;
        //return pageContent;

    }

    //The method builds the main page when atleast one customer is found
    Widget _buildMainContent(){
    return RefreshIndicator(
      
          onRefresh: (){
            //setState(() => _currentList = dcCustomerList);
            return Navigator.pushNamed(context, "/activity_rcdc");
          },
          child: Container(
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
                Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: _currentList.length,
                      itemBuilder: (BuildContext context, int index){
                        Customer customer = _currentList[index];
                        return InkWell(
                        /*onTap: () => Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context)=> DisconnectionDetailsScreen(customer, flag: "dc"))
                        ),
                        */
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
                            child: RCDCActivitiesRowItem(customer: customer)
                            )
                          );
                      }
                    ),
                )
              ],
            ),
        ),
          ),
      );
}

 
    Future<bool> _onBackPressed() async {
        Navigator.pushReplacementNamed(context, '/activity_home');
        return true;
    }


      @override
      Widget build(BuildContext context) {
          return new WillPopScope(
              onWillPop: _onBackPressed,
              child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 24.0,
                  onPressed: () => Navigator.pushReplacementNamed(context, '/activity_home'),
                ),
                title: Text("My $rcdcActivityFlag Activities(${_dcCustomerList.length.toString()})", style: TextStyle(fontSize: 14),),
              ),
              body: isLoading ? Center(child: CircularProgressIndicator()) : pageContent
            ),
          );
        }
      }