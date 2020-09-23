import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {

    final Function _completeAction;
    final bool isLoading;
    final String btnTitle;

    SubmitButton(this._completeAction, this.isLoading, this.btnTitle);

    @override
    Widget build(BuildContext context) {
      return isLoading ? 
          Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(), 
            height: 45, 
            width: 45,
            ) : InkWell(
            onTap:  () => _completeAction(),
            child: Container(
            alignment: Alignment.center,
            height: 45.0,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(30.0),
              color: Colors.blue
            ),
            child: Text(
                btnTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),
            ),
          ),
        );
    }
}