import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/screens/benefitsPage.dart';
import 'package:learn_nova/views/screens/coursePage.dart';
import 'package:learn_nova/views/screens/mainCategory.dart';
import 'package:learn_nova/core/middleware/AppMiddleware.dart';
import 'package:learn_nova/test.dart';
import 'package:learn_nova/views/screens/Auth/checkEmail.dart';
import 'package:learn_nova/views/screens/Auth/forgotPassword.dart';
import 'package:learn_nova/views/screens/Auth/login.dart';
import 'package:learn_nova/views/screens/Auth/resetpassword.dart';
import 'package:learn_nova/views/screens/Auth/Signup.dart';
import 'package:learn_nova/views/screens/AllCategoryPage.dart';
import 'package:learn_nova/views/screens/main_page.dart';
import 'package:learn_nova/views/screens/onboarding.dart';
import 'package:learn_nova/views/screens/searchPage.dart';
// import 'package:learn_nova/views/screens/settingsPage.dart';
import 'package:learn_nova/views/testView.dart';

List<GetPage<dynamic>>? routes = [
  // GetPage(name: '/', page: () => Onboarding(), middlewares: [Mymiddleware()]),
  // GetPage(name: '/', page: () => Testview()),
  GetPage(name: AppRoutes.login, page: () => Login()),
  GetPage(name: AppRoutes.signup, page: () => Signup()),
  GetPage(name: AppRoutes.checkEmail, page: () => Checkemail()),
  GetPage(name: AppRoutes.forgotPassword, page: () => Forgotpassword()),
  GetPage(name: AppRoutes.resetpassword, page: () => Resetpassword()),
  // GetPage(name: AppRoutes.homePage, page: () => HomePage()),
  GetPage(name: '/', page: () => MainPage()),
  // GetPage(name: AppRoutes.settingsPage, page: () => SettingsPage()),
  GetPage(name: AppRoutes.searhPage, page: () => SearchPage()),
  GetPage(name: AppRoutes.categoryPage, page: () => AllCategoryPage()),
  GetPage(name: AppRoutes.mainCategory, page: () => MainCategory()),
  GetPage(name: AppRoutes.benefits, page: () => BenefitsPage()),
  GetPage(name: AppRoutes.coursePage, page: () => CoursePage()),
];
