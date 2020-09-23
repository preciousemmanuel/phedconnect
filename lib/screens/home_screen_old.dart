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
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          margin: EdgeInsets.symmetric(vertical: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Row(
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
                                Icon(
                                  Icons.payment,
                                  color: Theme.of(context).primaryColor,
                                  size: 45,
                                ),
                                Text(
                                  "Bill Payment",
                                  style: TextStyle(
                                      fontFamily: "QuickSand",
                                      fontSize: 11.3,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ])),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
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
                              Icon(
                                Icons.chat,
                                color: Theme.of(context).primaryColor,
                                size: 45,
                              ),
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
                )
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
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
                              Icon(
                                Icons.info,
                                color: Theme.of(context).primaryColor,
                                size: 45,
                              ),
                              Text(
                                "Info Center",
                                style: TextStyle(
                                    fontFamily: "QuickSand",
                                    fontSize: 11.3,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ])),
                  ),
                ),
                SizedBox(width: 10.0),
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
                              Icon(
                                Icons.feedback,
                                color: Theme.of(context).primaryColor,
                                size: 45,
                              ),
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
                )
              ],
            )
          ]),
        )
      ]),
    );
  }
}
