import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  String _selectedZone;
  String _selectedFeeder;
  String _selectedStatus;
 
  List<DropdownMenuItem> dropdownItemsZone = [
      DropdownMenuItem(
        child: Text("Select Zone"),
        value: "",
      ),
      DropdownMenuItem(
        child: Text("Gamma"),
        value: "Gamma",
      ),
      DropdownMenuItem(
        child: Text("Alpha"),
        value: "Alpha",
      ),
      DropdownMenuItem(
        child: Text("Beta"),
        value: "Beta",
      ),
  ];

  List<DropdownMenuItem> dropdownItemsFeeder = [
      DropdownMenuItem(
        child: Text("Select Feeder"),
        value: "",
      ),     
      DropdownMenuItem(
        child: Text("Abouloma"),
        value: "Abouloma",
      ),
      DropdownMenuItem(
        child: Text("Trans-Amadi"),
        value: "Trans-Amadi",
      ),
       DropdownMenuItem(
        child: Text("Woji"),
        value: "Woji",
      ),
  ];

  List<DropdownMenuItem> dropdownItemsStatus = [
      DropdownMenuItem(
        child: Text("Select Status"),
        value: "",
      ),
      DropdownMenuItem(
        child: Text("Due for Disconnection"),
        value: "Due for Disconnection",
      ),
      DropdownMenuItem(
        child: Text("Due for Reconnection"),
        value: "Due for Reconnection",
      ),
      DropdownMenuItem(
        child: Text("Disconnection Done"),
        value: "Diconnection Done",
      ),
      DropdownMenuItem(
        child: Text("Reconnection Done"),
        value: "Reconnection Done",
      ),
      DropdownMenuItem(
        child: Text("Settlement Plan Agreement"),
        value: "Settlement Plan Agreement",
      ),
  ];

  
  
  @override
  void initState() {
    
    _selectedZone = dropdownItemsZone[0].value;
    _selectedFeeder = dropdownItemsFeeder[0].value;
    _selectedStatus = dropdownItemsStatus[0].value;
    _selectedZone = dropdownItemsZone[0].value;
    _selectedZone = dropdownItemsZone[0].value;
    super.initState();
  }


  Widget _buildDropDownButton(String selectedValue, List<DropdownMenuItem> dropdownMenuItems){

      Widget dropdownButton;
      dropdownButton = DropdownButton(
        items: dropdownMenuItems,
        onChanged: (dynamic value){
          setState(() {
            selectedValue = value;
            print(selectedValue);
          });
        },
        value: selectedValue,
        style: TextStyle(
          color: Colors.blue
        ),
      );

      return dropdownButton;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.all(8.0),
        height: MediaQuery.of(context).size.height / 2.5,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 6.0,
              offset: Offset(0,2),
              color: Colors.black26
            )
          ]
        ),
        child: Column(
          children: <Widget>[
            Text("Fetch Customers Status"),
            SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  _buildDropDownButton(_selectedZone, dropdownItemsZone),
                  _buildDropDownButton(_selectedFeeder, dropdownItemsFeeder),              
              ],
            ),
            SizedBox(height: 20.0),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  _buildDropDownButton(_selectedStatus, dropdownItemsStatus),
                  Text("Month"),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                  Text("Year"),
                  InkWell(
                    child: Container(
                      width: 100.0,
                      padding: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      color: Colors.green,
                      child: Text(
                        "Get Data",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: (){},
                  )
              ],
            ),
            
          ],
        ),
      )
    );
  }
}