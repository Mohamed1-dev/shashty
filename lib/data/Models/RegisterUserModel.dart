class RegisterUserModel {
  String name, password, phone, email,favouriteType;
  List<int> favouritesIds;

  RegisterUserModel({this.name, this.password, this.phone, this.email,this.favouriteType,this.favouritesIds});

  String validateUserName(String val) {
    if (val.trim().isEmpty) {
      return "ادخل اسم المستخدم";
    } else
      return null;
  }

  String validatePhone(String val) {
    if (val.trim().isEmpty) {
      return "ادخل رقم الهاتف";
    }

    Pattern pattern = r'(^[0-9]*$)';

    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(val.trim())) {
      // So, the email is valid
      return null;
    } else
      return "ادخل رقم الهاتف صحيح";
  }

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

  String validateConfirmPassword(String val, String val2) {
    if (val.trim().isEmpty)
      return "ادخل كلمة السر";
    else if (val.length < 6) {
      return "كلمة السر يجب ان لا تقل علي 6 حروف";
    } else if (val != val2) {
      return "كلمة السر ير متاطبق";
    } else
      return null;
  }
}
