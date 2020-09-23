import 'package:flutter/material.dart';

class RemarksTextFormField extends StatefulWidget {
  final Function _setRemarks;
  RemarksTextFormField(this._setRemarks);

  @override
  _RemarksTextFormFieldState createState() => _RemarksTextFormFieldState();
}

class _RemarksTextFormFieldState extends State<RemarksTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(1.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 6.0, color: Colors.black26, offset: Offset(0, 2)),
          ],
          borderRadius: BorderRadius.circular(5.0)),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: 2,
        onSaved: (newValue) {
          widget._setRemarks(newValue);
        },
        onChanged: (value) => widget._setRemarks(value),
        decoration: InputDecoration(
            hintText: "Remarks(If any)",
            //prefixIcon: Icon(Icons.edit),
            fillColor: Colors.white,
            filled: true),
        /*validator: (String value) {
          if (value.length < 1) {
            return "please add a remark";
          }
          return null;
        },
        */
      ),
    );
  }
}
