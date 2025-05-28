import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/core/middleware/AppMiddleware.dart';
import 'package:learn_nova/test.dart';
import 'package:learn_nova/views/screens/Auth/checkEmail.dart';
import 'package:learn_nova/views/screens/Auth/forgotPassword.dart';
import 'package:learn_nova/views/screens/Auth/login.dart';
import 'package:learn_nova/views/screens/Auth/resetpassword.dart';
import 'package:learn_nova/views/screens/Auth/Signup.dart';
import 'package:learn_nova/views/screens/homepage.dart';
import 'package:learn_nova/views/screens/onboarding.dart';
import 'package:learn_nova/views/testView.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => Onboarding(), middlewares: [Mymiddleware()]),
  // GetPage(name: '/', page: () => Testview()),
  GetPage(name: AppRoutes.login, page: () => Login()),
  GetPage(name: AppRoutes.signup, page: () => Signup()),
  GetPage(name: AppRoutes.checkEmail, page: () => Checkemail()),
  GetPage(name: AppRoutes.forgotPassword, page: () => Forgotpassword()),
  GetPage(name: AppRoutes.Resetpassword, page: () => Resetpassword()),
  GetPage(name: AppRoutes.homePage, page: () => HomePage()),
];
