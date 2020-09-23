import 'package:customer_app/screens/check_account.dart';
import 'package:customer_app/widgets/clip_path.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  Color myHexColor = Color(0xff5e6da0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myHexColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "PHED CONNECT",
          style: TextStyle(
              fontFamily: "QuickSand", color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              size: 30.0,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: null,
            color: Colors.white,
          )
        ],
      ),
      body: ListView(children: [
        ClipPath(
          clipper: CurveClipper(),
                  child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 260.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/box.gif"),
                  fit: BoxFit.cover,
                )),
              ),
              Positioned(
                  bottom: 20.0,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 300.0,
                    height: 100.0,
                  ))
            ],
          ),
        ),
        Expanded(
                  child: Container(
                    height: 300.0,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: GridView.count(crossAxisCount: 2,
            children: [
              GestureDetector(
                 onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CheckAccountScreen()));
                  },
                              child: Container(
                    height: 150.0,
                    width: 155.0,
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/receipt.png",width:70.0,height:70.0),
                                SizedBox(height: 7.0,),
                                Text(
                                  "Bill Payment",
                                  style: TextStyle(
                                      fontFamily: "QuickSand",
                                      fontSize: 11.3,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                )
                              ])),
                    ),
                  ),
              ),
                Container(
                  height: 150.0,
                  width: 155.0,
                  child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/complain.png",width:70.0,height:70.0),
                              SizedBox(height: 7.0,),
                              Text(
                                "Complain",
                                style: TextStyle(
                                    fontFamily: "QuickSand",
                                    fontSize: 11.3,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              )
                            ])),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                     Navigator.pushNamed(context, '/mis');
                  },
                                  child: Container(
                    height: 150.0,
                    width: 155.0,
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/information.png",width:70.0,height:70.0),
                                SizedBox(height: 7.0,),
                                Text(
                                  "Info Center",
                                  style: TextStyle(
                                      fontFamily: "QuickSand",
                                      fontSize: 11.3,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                )
                              ])),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/feedback');
                  },
                                  child: Container(
                    height: 150.0,
                    width: 155.0,
                    child: Card(
                      child: Padding(
                          padding: EdgeInsets.all(25.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Image.asset("assets/images/satisfaction.png",width:70.0,height:70.0),
                                  SizedBox(height: 7.0,),
                                Text(
                                  "Feed Back",
                                  style: TextStyle(
                                      fontFamily: "QuickSand",
                                      fontSize: 11.3,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                )
                              ])),
                    ),
                  ),
                )
            ],
            ),
          ),
        )
      ]),
    );
  }
}
