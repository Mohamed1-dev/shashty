import 'package:flutter/material.dart';

class ShowTextFormFieldWidget extends StatelessWidget {
  double fontSize;

  double labelFontSize;

  var labelText;
  TextEditingController _controller = TextEditingController();
  ShowTextFormFieldWidget(
    this.fontSize,
    this.labelFontSize,
    this.labelText,
    this._controller,
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          cursorColor: Colors.white,
          accentColor: Colors.white,
          disabledColor: Colors.white,
          hintColor: Colors.white),
      child: TextFormField(
        style: TextStyle(fontSize: fontSize, color: Colors.white),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        enabled: false,
        controller: _controller,
        decoration: InputDecoration(
            labelStyle:
                new TextStyle(color: Colors.white, fontSize: labelFontSize),
            labelText: labelText,
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 4.0),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
              width: 4.0,
            ))),
      ),
    );
  }
}
