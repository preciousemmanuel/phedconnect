import '../../data/active_dtr.dart';
import '../../models/utility/dtr.dart';
import 'package:flutter/material.dart';

class OnboardingDTRScreen extends StatefulWidget {

  final List<DTR> dtrList;
  final String feeder;
  

  OnboardingDTRScreen(this.dtrList, this.feeder);

  @override
  _OnboardingDTRScreenState createState() => _OnboardingDTRScreenState();
}

class _OnboardingDTRScreenState extends State<OnboardingDTRScreen> {

      List<DTR> currentDTRDisplay = List<DTR>();

      List<DTR> filter(query){
        return widget.dtrList.where((element){
          return element.dtrName.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }



  @override
  void initState() {
    currentDTRDisplay = widget.dtrList;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.feeder} DTRs (${widget.dtrList.length} found)",
             style: TextStyle(fontSize: 13.0),
          ),
          /*actions: <Widget>[
            Text("${widget.dtrList.length} found")
          ],
          */
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16.0,),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Search DTR",
                    fillColor: Colors.grey[200],
                    filled: true,
                    suffixIcon: Icon(Icons.search)
                  ),
                  onChanged: (value){

                    if(value.trim().length == 0){
                        setState(() {
                          currentDTRDisplay.clear();
                          currentDTRDisplay = widget.dtrList;
                        });
                    }
                    else{
                        var ls = filter(value);
                        setState(() {
                          currentDTRDisplay = ls;
                        });
                    }
                   

                  }
                ),
                SizedBox(height: 16.0,),
                Text("Showing ${currentDTRDisplay.length} of ${widget.dtrList.length} DTRs",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white
                ),),
                SizedBox(height: 8.0,),
                Expanded(
                    child: ListView.builder(
                    itemCount: currentDTRDisplay.length,
                    itemBuilder: (BuildContext context, int index){
                      //return Text("Index "+ index.toString());
                      DTR dtr = currentDTRDisplay[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text("${dtr.dtrName.trim()}", style: TextStyle(color: Colors.white),),
                            subtitle: Text("${dtr.dtrId}", style: TextStyle(color: Colors.white70),),
                            onTap: (){
                              onBoardingActiveDTR = dtr.dtrName.trim()+ " | "+dtr.dtrId;
                              Navigator.pop(context, onBoardingActiveDTR);
                            },
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                          ),
                          Divider(height: 8.0, thickness: 1.0, color: Colors.white,)
                        ],
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}