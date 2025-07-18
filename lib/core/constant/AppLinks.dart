class Applinks {
  static const String server =
      'https://e-learning-server-me-production.up.railway.app/api';
  //auth
  static const String signup = '$server/phone-register';
  static const String login = '$server/login';
  static const String logout = '$server/logout';
  static const String verify = '$server/verify-otp';
  static const String resetPassEmail = '$server/send-reset-otp';
  static const String resetPass = '$server/reset-password-with-otp';
  //homepage
  static const String categories = '$server/v1/categories';
  static const String externalCourses = '$server/v1/courses';
  //user
  static const String userInformation = '$server/user';
  static const String userCourseEnrollment = '$server/v1/users';
  static const String courseEnroll = '$externalCourses';
  //ratings
  static const String addRating = '$server/v1/courses';
  static const String deleteRating = '$server/v1/courses';
  //ProgressCourses
  static const String progress = '$server/v1/courses'; //send course Id & token
  static const String videoProgress =
      '$server/v1/videos'; //send video Id & token
  static const String uservidewProgress =
      '$server/v1/user/watched-videos'; //send token
  //favorites Courses
  static const String FavCour = '$server/v1/saved-courses'; //send token
}
