class Applinks {
  static const String server =
      'https://e-learning-server-me-production.up.railway.app/api';
  //auth
  static const String signup = '$server/phone-register';
  static const String login = '$server/login';
  static const String logout = '$server/logout';
  static const String verify = '$server/verify-otp';
  //homepage
  static const String categories = '$server/v1/categories';
  static const String externalCourses = '$server/v1/courses';
  //user
  static const String userInformation = '$server/user';
}
