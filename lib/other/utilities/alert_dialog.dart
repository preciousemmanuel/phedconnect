import 'package:flutter/material.dart';

void showAlertDialog(
    {BuildContext context,
    String navigateTo,
    bool isLoading,
    bool isSuccess,
    String loadingMsg = '',
    String completedMsg = ''}) {
  Widget infoGraphic;

  if (isLoading) {
    infoGraphic = Image(
      image: AssetImage("assets/images/loader.gif"),
      height: 40,
      width: 40,
      fit: BoxFit.contain,
    );
  } else if (!isLoading && isSuccess) {
    infoGraphic = Icon(
      Icons.done,
      color: Colors.green,
      size: 60.0,
    );
  } else if (!isLoading && !isSuccess) {
    infoGraphic = Icon(
      Icons.clear,
      color: Colors.red,
      size: 60.0,
    );
  }

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            isLoading ? loadingMsg : completedMsg,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          /*content: isLoading ? Image(
          image: AssetImage("assets/images/loader.gif"),
          height: 40,
          width: 40,
          fit: BoxFit.contain,
        ) : Icon(
          Icons.done,
          color: Colors.green,
          size: 60.0,
        ),*/
          content: infoGraphic,
          actions: <Widget>[
            FlatButton(
                child: isLoading ? Container() : Text("OKay"),
                onPressed: () {
                  if (navigateTo != null) {
                    Navigator.pushReplacementNamed(context, navigateTo);
                  } else {
                    Navigator.pop(context);
                  }
                })
          ],
        );
      });
}
