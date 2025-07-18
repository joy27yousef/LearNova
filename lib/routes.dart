import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/screens/MycoursesPage/MyCoursesPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/courseLearning.dart';
import 'package:learn_nova/views/screens/MycoursesPage/ratinPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/videoPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/EditProfile.dart';
import 'package:learn_nova/views/screens/home/benefitsPage.dart';
import 'package:learn_nova/views/screens/home/coursePage.dart';
import 'package:learn_nova/views/screens/home/mainCategory.dart';
import 'package:learn_nova/core/middleware/AppMiddleware.dart';
import 'package:learn_nova/views/screens/Auth/checkEmail.dart';
import 'package:learn_nova/views/screens/Auth/forgotPassword.dart';
import 'package:learn_nova/views/screens/Auth/login.dart';
import 'package:learn_nova/views/screens/Auth/resetpassword.dart';
import 'package:learn_nova/views/screens/Auth/Signup.dart';
import 'package:learn_nova/views/screens/home/AllCategoryPage.dart';
import 'package:learn_nova/views/screens/main_page.dart';
import 'package:learn_nova/views/screens/home/notificationPage.dart';
import 'package:learn_nova/views/screens/onboarding.dart';
import 'package:learn_nova/views/screens/home/searchPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/favoritesPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/helpCenterPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/settingPage.dart';
import 'package:learn_nova/views/screens/test.dart';
import 'testPage.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => Onboarding(), middlewares: [Mymiddleware()]),
  // GetPage(name: '/', page: () => Testpage()),
  // GetPage(name: '/', page: () => MainPage()),
  // GetPage(name: '/', page: () => MainPage()),
  //Auth
  GetPage(name: AppRoutes.login, page: () => Login()),
  GetPage(name: AppRoutes.signup, page: () => Signup()),
  GetPage(name: AppRoutes.checkEmail, page: () => Checkemail()),
  GetPage(name: AppRoutes.forgotPassword, page: () => Forgotpassword()),
  GetPage(name: AppRoutes.resetpassword, page: () => Resetpassword()),
  //Main Page
  GetPage(name: AppRoutes.mainPage, page: () => MainPage()),
  //Home Page
  GetPage(name: AppRoutes.searhPage, page: () => SearchPage()),
  GetPage(name: AppRoutes.categoryPage, page: () => AllCategoryPage()),
  GetPage(name: AppRoutes.mainCategory, page: () => MainCategory()),
  GetPage(name: AppRoutes.benefits, page: () => BenefitsPage()),
  GetPage(name: AppRoutes.notificationPage, page: () => NotificationPage()),

  //profile page
  GetPage(name: AppRoutes.editProfile, page: () => EditProfile()),
  GetPage(name: AppRoutes.settingsPage, page: () => SettingPage()),
  GetPage(name: AppRoutes.helpCenterPage, page: () => HelpCenterPage()),
  GetPage(name: AppRoutes.favoritesPage, page: () => FavoritesPage()),

  //courses
  GetPage(name: AppRoutes.coursePage, page: () => CoursePage()),
  GetPage(name: AppRoutes.learningCourse, page: () => CourseLearning()),
  GetPage(name: AppRoutes.mycoursespage, page: () => Mycoursespage()),
  GetPage(name: AppRoutes.videoPage, page: () => VideoPage()),
  GetPage(name: AppRoutes.ratingPage, page: () => RatingPage()),
];
