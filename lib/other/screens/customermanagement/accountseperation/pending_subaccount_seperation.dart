import '../../../controllers/knowledgebase/knowledge_base_controller.dart';
import 'package:flutter/material.dart';
import '../../../screens/knowledgebase/details.dart';

class PendingAccountSeperationScreen extends StatefulWidget {
  @override
  _PendingAccountSeperationScreenState createState() => _PendingAccountSeperationScreenState();
}

class _PendingAccountSeperationScreenState extends State<PendingAccountSeperationScreen> {

  
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    KnoledgeBase kbC = KnoledgeBase();
    bool isLoading = true;
    List<Widget> pageContent;


    void initState(){
      super.initState();
      fetchKess();
    }

    fetchKess() async{

        print("fetching kess list...");

        Map<String,dynamic> res;
        List kessList;

        res = await kbC.fetchKess();
        print(res.toString());
        
        if(res != null && res["status"] == "SUCCESS"){
            
            kessList = res["data"];
            print("xxxxxxxxxxxx: " + kessList.toString());
            pageContent = buildKessList(kessList);
            
        }
        else{
          pageContent = [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "We are sorry.\nPHED SmartWorkForce encountered an error whille fetching KESS items.Please refresh or try again later.\nThank You",
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


    buildKessList(List kessItems){

        List<Widget> items = List();
        Widget widget;


        kessItems.forEach((item) {
      
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
                        Text("Parent Account No: 08063498356",
                        style: TextStyle(color: Colors.blue
                        ),),
                        Text("Account to be created: 4"),
                        Text("Pending Approval: 3")
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


    Future<bool> _onBackPressed() async {
        Navigator.pushReplacementNamed(context, '/modules');
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
              "Pending Account Seperation",
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("What do you want to know?",
                    style:TextStyle(color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ),
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