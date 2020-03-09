class LoginUserModel {
  String email, password;

  LoginUserModel({this.email, this.password});
  String validateEmail(String val) {
    if (val.isEmpty)
      return "ادخل البريد الالكتروني";
    else {
      final _emailRegExpString = r'[a-zA-Z0-9\+\.\_\%\-\+]{1,256}\@[a-zA-Z0-9]'
          r'[a-zA-Z0-9\-]{0,64}(\.[a-zA-Z0-9][a-zA-Z0-9\-]{0,25})+';
      if (!RegExp(_emailRegExpString, caseSensitive: false).hasMatch(val)) {
        return "ادخل البريد الالكتروني صحيح";
      } else
        return null;
    }
  }

  String validatePassword(String val) {
    if (val.trim().isEmpty)
      return "ادخل كلمة السر";
    else if (val.length < 6) {
      return "كلمة السر يجب ان لا تقل علي 6 حروف";
    } else
      return null;
  }
}
