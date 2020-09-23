import '../../../controllers/account_seperation_controller.dart';
import '../../../controllers/knowledgebase/knowledge_base_controller.dart';
import 'package:flutter/material.dart';
import '../../../screens/knowledgebase/details.dart';

class PendingAccountSeperationScreen extends StatefulWidget {
  @override
  _PendingAccountSeperationScreenState createState() => _PendingAccountSeperationScreenState();
}

class _PendingAccountSeperationScreenState extends State<PendingAccountSeperationScreen> {

  
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    AccountSeperation acController = AccountSeperation();
    bool isLoading = true;
    List<Widget> pageContent = List<Widget>();
    List pendingList = List();


    void initState(){
      super.initState();
      fetchPendingParentApprovals();
    }


    fetchPendingParentApprovals() async{

        print("fetching kess list...");

        Map<String,dynamic> res;
        

        res = await acController.pendingApprovalParentAccount();
        print(res.toString());
        
        if(res != null && res["status"] == "SUCCESS"){
            
            pendingList = res["data"];
            print("pending list: " + pendingList.toString());
            pageContent = buildPendingList(pendingList);
            
        }
        else{
          pageContent = [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "We are sorry.\nPHED SmartWorkForce encountered an error whille fetching account waiting approvals.Please refresh or try again later.\nThank You",
                       style: TextStyle(
                         color: Colors.white, 
                         fontSize: 14, 
                         fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                ],
              ),
          ];
        }

        setState(() {  
          isLoading = false;
        });
        
    }

    buildPendingCard(String title, String value){
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),
            )
          ],
        );
    }

    buildPendingList(List pendingItems){

        List<Widget> items = List();
        Widget widget;


        pendingItems.forEach((item) {
      
          widget = Column(
              children: <Widget>[
              GestureDetector(
                  onTap: () => Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => KBDetailsScreen(item["title_key"], int.parse(item["count"])))
                  ),
                  child: Container(
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 4.0, offset: Offset(0, 2), color: Colors.black12)
                    ]
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 3.0),
                        buildPendingCard("Parent Account No:", item["primaryaccount"]),
                        SizedBox(height: 5.0),
                        buildPendingCard("Pending Approvals:", item["pending"]),
                        SizedBox(height: 5.0),
                        buildPendingCard("Request Date:", item["requestdate"]),
                        SizedBox(height: 5.0),
                      ],
                    )
                ),
              ),
              ],
          );

          items.add(widget);

        });

        return items;

    }


/*
    //Function: snackbar for creating and displaying widget
  void _showSnackBar({bool isSuccessSnack, String msg, int duration}){

        //create snackbar
        var snackBar =  SnackBar(
            duration: Duration(seconds: duration != null ? duration: 5),
            //backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
            backgroundColor: Theme.of(context).primaryColor,
            content: Text(msg,
            style: TextStyle(
              color: Colors.white
            ),),
        );

        //show snackbar
        _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  */
  


Future<bool> _onBackPressed() async {
    //Navigator.pushReplacementNamed(context, '/modules');
    Navigator.pop(context);
    return true;
}


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
          onWillPop: _onBackPressed,
          child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 24.0,
              onPressed: () => Navigator.pop(context, '/'),
            ),
            title: Text(
              "Pending Account Seperation (${pendingList.length.toString()})",
               style: TextStyle(fontSize: 14),
            )
          ),
          body: isLoading ? Center(child: CircularProgressIndicator()) : Container(
              decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bgg.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(1.0), BlendMode.dstATop)
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.0),
                /*Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("What do you want to know?",
                    style:TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
                */
                SizedBox(height: 5.0,),
                Expanded(
                  child: ListView(children: pageContent)
                )
               
              ]
              
            ),
          ),
      ),
    );
  }
}