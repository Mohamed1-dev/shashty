import 'package:flutter/material.dart';
import 'package:shashty_app/controllers/UserController.dart';

class TextFormFieldWidget extends StatelessWidget {
  double fontSize;

  double labelFontSize;
  var fontColor;
  var labelColor;
  var labelText;
  bool isPassword;
  TextEditingController _controller = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  bool isConfirmPassword;
  var keyboardType;
  UserController _userController;
  bool isGo;
  var focusField;
  var nextFocuseField;
  var regFormKey;
  var contextView;
  var validator;
  var icon;
  String valueText;
  int numberOfText;
  bool isEnabled;
  TextFormFieldWidget(
      this.fontSize,
      this.labelFontSize,
      this.fontColor,
      this.labelColor,
      this.labelText,
      this._controller,
      this._PasswordController,
      this.isConfirmPassword,
      this.keyboardType,
      this._userController,
      this.isGo,
      this.focusField,
      this.nextFocuseField,
      this.regFormKey,
      this.isPassword,
      this.contextView,
      this.validator,
      this.valueText,
      this.icon,
      this.numberOfText,
      {this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: new ThemeData(
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          cursorColor: Colors.white,
          accentColor: Colors.white,
          disabledColor: Colors.grey,
          hintColor: Colors.white),
      child: TextFormField(
        style: TextStyle(fontSize: fontSize, color: fontColor),
        obscureText: isPassword,
        maxLines: 1,
        enabled: isEnabled,
        onSaved: (val) {
          switch (numberOfText) {
            case 1:
              _userController.registerUserModel.name = val;
              break;
            case 2:
              _userController.registerUserModel.email = val;
              break;
            case 3:
              _userController.registerUserModel.phone = val;
              break;
            case 4:
              _userController.registerUserModel.password = val;
              break;

            case 5:
              _userController.resetPasswordValue = val;
              break;
            case 6:
              _userController.loginUserModel.email = val;
              break;
            case 7:
              _userController.loginUserModel.password = val;
              break;

            case 9:
              _userController.editProfileModel.name = val;
              break;

            case 10:
              _userController.editProfileModel.phone = val;
              break;
          }
        },
        controller: _controller,
        keyboardType: keyboardType,
        onFieldSubmitted: (value) {
          if (numberOfText == 5) {
            _userController.resetPassword(context, regFormKey);
          } else if (numberOfText == 10) {
            _userController.editProfile(context, regFormKey);
          } else if (isGo && numberOfText == 7) {
            _userController.signInWithEmailAndPassword(
                this.contextView, regFormKey);
          } else if (isGo && numberOfText != 7) {
            _userController.regNewUser(this.contextView, regFormKey);
          } else {
            FocusScope.of(this.contextView).requestFocus(nextFocuseField);
          }
        },
        focusNode: focusField,
        validator: isConfirmPassword
            ? (val) => _userController.registerUserModel
                .validateConfirmPassword(val, _PasswordController.text)
            : validator,
        textInputAction: isGo ? TextInputAction.go : TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            labelStyle:
                new TextStyle(color: labelColor, fontSize: labelFontSize),
            labelText: labelText,
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.0),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ))),
      ),
    );
  }
}
