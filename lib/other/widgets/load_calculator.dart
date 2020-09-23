
import 'package:flutter/material.dart';
import '../data/appliances_wattage.dart';

class LoadCalculator extends StatefulWidget {

  final Function setListOfAppliances;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double overallTotalWattage;
  final String accountNo;

  LoadCalculator({this.setListOfAppliances, this.scaffoldKey, this.overallTotalWattage, this.accountNo});


  @override
  _LoadCalculatorState createState() => _LoadCalculatorState();
}

class _LoadCalculatorState extends State<LoadCalculator> {

      String selectedAppliance;
      String applianceQty;
      List<TableRow> tableRows = List<TableRow>();
      List<Map<String, dynamic>> listOfAppliances = List<Map<String,dynamic>>();
      static final TextEditingController _applianceQtyEC = TextEditingController();


      List<DropdownMenuItem> dropdownItemsAppliances = [
          DropdownMenuItem(
            child: Text("Select Appliance"),
            value: "",
          ),     
         /* DropdownMenuItem(
            child: Text("Pressing Iron"),
            value: "Pressing Iron|20|1",
          ),
          DropdownMenuItem(
            child: Text("Television"),
            value: "Television|30|2",
          ),
            DropdownMenuItem(
            child: Text("Laptop"),
            value: "Laptop|25|3",
          ),
          */
      ];

      Widget buildTableHeaderText(String title){

          return Text(
            title,
            textAlign: TextAlign.center, 
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            )
          );
      }

    

      List<TableRow> t = [
         TableRow( children: [
              Text("Appliances", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              Text("Wattage", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              Text("Qty", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              Text("Total Wattage", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            ])
      ];

    
      @override
      void initState(){
        tableRows = t;
        ap.forEach((element) {
          dropdownItemsAppliances.add(
            DropdownMenuItem(
              child: Text(
                element.applianceName,
                overflow: TextOverflow.visible,
              ),
              value: "${element.applianceName}|${element.watt}|${element.id}",
            ),  
          );
        });
        selectedAppliance = dropdownItemsAppliances[0].value;
        super.initState();
      }

      void _showSnackBar({bool isSuccessSnack, String msg, int duration}){

            //create snackbar
            var snackBar =  SnackBar(
                duration: Duration(seconds: 5),
                backgroundColor: isSuccessSnack ? Colors.green : Colors.red,
                content: Text(msg,
                style: TextStyle(
                  color: Colors.white
                ),),
            );

            //show snackbar
            widget.scaffoldKey.currentState.showSnackBar(snackBar);
      }
      
    
    Widget _buildDropDownCalculateLoadOption(){
          Widget dropdownButton;
          dropdownButton = Expanded(
              flex: 60,
              child: Container(
              width: MediaQuery.of(context).size.width / 2,
              margin: EdgeInsets.all(2.0),
              padding: EdgeInsets.all(8.0),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 6.0, offset: Offset(0,2), color: Colors.black12)
                ],
                borderRadius: BorderRadius.circular(5.0)
              ),
              child: DropdownButton(
                isExpanded: true,
                items: dropdownItemsAppliances,
                onChanged: (dynamic value){
                  print("dropdown value: $value");
                  setState(() {
                    selectedAppliance = value;
                  });
                },
                value: selectedAppliance,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
              ),
                ),
          );

          return dropdownButton;
      }

    Widget _buildApplianceQtyTextField(){
        return Expanded(
            flex: 20,
            child: Container(
            width: 40.0,
            height: 40.0,
            child: TextFormField(
              controller: _applianceQtyEC,
              keyboardType: TextInputType.number,             
              decoration: InputDecoration(
                hintText: "Qty",
                //prefixIcon: Icon(Icons.mail),
                fillColor: Colors.white,
                filled: true
              ),
              validator: (String value){
                return null;
              },
              onSaved: (newValue) => applianceQty = newValue,
              onChanged: (String value) => applianceQty = value,
            ),
            
            //child: Text("flsfklsfksl"),
          ),
        );
    }

      //build date selection button
    Widget _buildAddButton(){
        return Expanded(
            flex: 10,
            child: Container(
            color: Colors.white,
            height: 40.0,
            child: IconButton(
              onPressed: _addNewTableRow,
              icon: Icon(Icons.add),
              iconSize: 24.0,
              color: Colors.blue,
            ),
          ),
        );
    }
    
    Widget _buildRemoveButton(){
        return Expanded(
            flex: 10,
            child: Container(
            height: 40.0,
            color: Colors.white,
            child: IconButton(
              onPressed: _removeLastTableRow,
              icon: Icon(Icons.clear),
              iconSize: 24.0,
              color: Colors.red,
            ),
          ),
        );
    }

    Widget _buildTable(){
      return Container(
        margin: EdgeInsets.all(4.0),
        child: Table(
          border: TableBorder.all(color: Colors.white),
          children: tableRows
        ),
      );
    }
//1718222785
     _addNewTableRow(){

        if(selectedAppliance == null || selectedAppliance.toString().trim().length == 0){
            _showSnackBar(isSuccessSnack: false, msg: "Please select an appliance");
            return;
        }
        if(applianceQty == null || applianceQty.toString().trim().length == 0){
            _showSnackBar(isSuccessSnack: false, msg: "Please select appliance quantity");
            return;
        }

        List<String> f = selectedAppliance.split("|");
        String applianceName = f[0];
        String applianceWatt = f[1].toString().trim();
        String applianceId = f[2].toString().trim();
        String qty = applianceQty.trim();
        double totalWattage = double.parse(qty) * double.parse(applianceWatt);

        print(applianceId.toString());

        Map<String, dynamic> v;
       
        v = {
          "ApplianceId": applianceId,
          "AccountNo": widget.accountNo,
          "ApplianceName": applianceName,
          "Wattage": applianceWatt,
          "Qty": applianceQty,
          "TotalWattage": totalWattage
        };

        selectedAppliance = null;
        applianceQty = null;
        applianceWatt = null;
        applianceName = null;
        qty = null;
        totalWattage = null;

        listOfAppliances.add(v);

        
        if(t.length > 1){
            t.removeRange(1, t.length);
        }
       
        double overallTotalWattage = 0;
        listOfAppliances.forEach((el) {

            overallTotalWattage += el["TotalWattage"];

            TableRow a = TableRow( children: [
              Text(el["ApplianceName"].toString(), style: TextStyle(color: Colors.white)),
              Text(el["Wattage"].toString(), style: TextStyle(color: Colors.white)),
              Text(el["Qty"].toString(), style: TextStyle(color: Colors.white)),
              Text(el["TotalWattage"].toString(), style: TextStyle(color: Colors.white)),
            ]);

            t.add(a);
        });

          t.add(
            
            TableRow( children: [
              Text("Total", style: TextStyle(color: Colors.white),),
              Text("-", style: TextStyle(color: Colors.white)),
              Text("-", style: TextStyle(color: Colors.white)),
              Text(overallTotalWattage.toString(), style: TextStyle(color: Colors.white)),
            ])
        );
        _applianceQtyEC.text = "";
        applianceQty = "";
        setState(() {
          tableRows = t;
          widget.setListOfAppliances(listOfAppliances, overallTotalWattage);
        });
    }

    _removeLastTableRow(){
      
        if(listOfAppliances.length < 1){
          _showSnackBar(isSuccessSnack: false, msg: "No items to remove");
          return;
        }

        listOfAppliances.removeAt(listOfAppliances.length - 1);

        if(t.length > 1){
            t.removeRange(1, t.length);
        }
        
        double overallTotalWattage = 0;
        listOfAppliances.forEach((el) {

            overallTotalWattage += el["TotalWattage"];

            TableRow a = TableRow( children: [
              Text(el["ApplianceName"].toString(), style: TextStyle(color: Colors.white)),
              Text(el["Wattage"].toString(), style: TextStyle(color: Colors.white)),
              Text(el["Qty"].toString(), style: TextStyle(color: Colors.white)),
              Text(el["TotalWattage"].toString(), style: TextStyle(color: Colors.white)),
            ]);

            t.add(a);
        });

        t.add(
            
            TableRow( children: [
              Text("Total", style: TextStyle(color: Colors.white),),
              Text("-", style: TextStyle(color: Colors.white)),
              Text("-", style: TextStyle(color: Colors.white)),
              Text(overallTotalWattage.toString(), style: TextStyle(color: Colors.white)),
            ])
        );

        setState(() {
          tableRows = t;
          widget.setListOfAppliances(listOfAppliances, overallTotalWattage);
        });
      
        
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
           color: Colors.blue,
        ),
        padding: EdgeInsets.all(4.0),
        child: Column(children: <Widget>[
          Text(
            "LOAD CALCULATOR",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[         
              _buildDropDownCalculateLoadOption(),
               SizedBox(width: 5.0,),
              _buildApplianceQtyTextField(),
              SizedBox(width: 5.0,),
              _buildAddButton(),
              SizedBox(width: 5.0,),
              _buildRemoveButton()
            ],
          ),
          listOfAppliances.length > 0 ? _buildTable() : Container()
          
        ],),
      );
    }
}