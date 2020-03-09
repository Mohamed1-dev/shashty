class ApiRoutes {
  // static const String BaseUrl = "http://shashtyapi.sports-mate.net";
  static const String BaseUrl = "http://api.shashty.tv";
  static const String api = BaseUrl + "/api/";
  // static const String public = BaseUrl  + "/public/";
  static const String public =BaseUrl+"/"  ;
  static const String auth = api + "auth/";
  static const String register = auth + "register";
  static const String login = auth + "login";
  static const String logout = auth + "logout";
  static const String resetPassword = auth + "reset_password";
  static const String sendCodeResetPassword = auth + "sendCodeResetPassword";
  static const String forgetPassword = auth + "forgetPassword";
  static const String checkToken = auth + "me";
  static const String socialLogin = auth + "provider";
  static const String editProfile = auth + "edit_profile";
  static const String countries = api + "countries";
  static const String filter = api + "filter?";
  static const String filterCategories = filter + "category=";
  static const String page = "&page=";

  static const String categories = api + "categories";
  static const String persons = api + "persons";
  static const String teams = api + "teams";
  static const String rate = api + "rate";
  static const String home = api + "Home";
  static const String shows = api + "shows/";
  static const String programShow = "?category_id=3";
  static const String seriesShow = "?category_id=2";
  static const String movieShoe = "?category_id=1";
  static const String notification = api + "notification";
  static const String readNotification = api + "read-notification";
  static const String removeNotification = api + "destroy-notification";
  static const String topRating = api + "top-Rating";
  static const String topViews = api + "top-Views";
  static const String topFavourite = api + "top-Favourite";
  static const String showNow = api + "show-Now";
  static const String showSoon = api + "show-Soon";
  static const String suggested = api + "suggested";
  static const String favourite = api + "favourite";
  static const String channels = api + "channels";
  static const String reminder = api + "reminder";

  static const String showTime = api + "show-times/";

  static const String scheduleTeams = api + "get-schedule-teams/";
}