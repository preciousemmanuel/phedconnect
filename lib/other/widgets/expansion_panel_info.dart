import 'package:flutter/material.dart';
import '../utilities/styles.dart';

class ExpansionPanelInfo extends StatefulWidget {

  final List<Widget> expansionList;
  final String expansionTitle;


  ExpansionPanelInfo({@required this.expansionList, @required this.expansionTitle});


  @override
  _ExpansionPanelInfoState createState() => _ExpansionPanelInfoState();
}

class _ExpansionPanelInfoState extends State<ExpansionPanelInfo> {

  bool expandedState = false;

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0)
        ),
      child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded){
              setState(() => expandedState = !isExpanded);
          } ,
          animationDuration:  Duration(milliseconds: 500),
          children: <ExpansionPanel>[
                  ExpansionPanel(
                    headerBuilder: (BuildContext context, bool i){
                      return Container(
                        margin: EdgeInsets.only(left: 12.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.expansionTitle,
                          style: expansionPanelHeading
                        ),
                      );
                    },
                    body: Column(
                      children:  widget.expansionList
                    ),
                    isExpanded: expandedState
                ),
              ]
      ),
    );
  }
}