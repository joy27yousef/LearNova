import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:learn_nova/core/constant/AppRoutes.dart';
import 'package:learn_nova/views/screens/Auth/onboardingAuth.dart';
import 'package:learn_nova/views/screens/MycoursesPage/MyCoursesPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/courseLearning.dart';
import 'package:learn_nova/views/screens/MycoursesPage/editNotePage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/editRatingPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/paymentPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/quizPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/ratinPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/resultsPage.dart';
import 'package:learn_nova/views/screens/MycoursesPage/videoPage.dart';
import 'package:learn_nova/views/screens/home/AllFreeCourses.dart';
import 'package:learn_nova/views/screens/home/AllReviewinCourse.dart';
import 'package:learn_nova/views/screens/home/allTrendingCourse.dart';
import 'package:learn_nova/views/screens/profile%20Page/EditProfilePage.dart';
import 'package:learn_nova/views/screens/home/benefitsPage.dart';
import 'package:learn_nova/views/screens/home/coursePage.dart';
import 'package:learn_nova/views/screens/home/mainCategory.dart';
import 'package:learn_nova/core/middleware/AppMiddleware.dart';
import 'package:learn_nova/views/screens/Auth/checkEmailPage.dart';
import 'package:learn_nova/views/screens/Auth/forgotPasswordPage.dart';
import 'package:learn_nova/views/screens/Auth/loginPage.dart';
import 'package:learn_nova/views/screens/Auth/resetpasswordPage.dart';
import 'package:learn_nova/views/screens/Auth/signupPage.dart';
import 'package:learn_nova/views/screens/home/AllCategoryPage.dart';
import 'package:learn_nova/views/screens/main_page.dart';
import 'package:learn_nova/views/screens/notificationPage.dart';
import 'package:learn_nova/views/screens/onboarding.dart';
import 'package:learn_nova/views/screens/home/searchPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/aboutLearNova.dart';
import 'package:learn_nova/views/screens/profile%20Page/favoritesPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/helpCenterPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/inventFriendsPage.dart';
import 'package:learn_nova/views/screens/profile%20Page/settingPage.dart';
import 'package:learn_nova/views/screens/test.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/addReview.dart';
import 'package:learn_nova/views/widgets/mycourses/rating/viewRating.dart';
import 'testPage.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/', page: () => Onboarding(), middlewares: [Mymiddleware()]),
  // GetPage(name: '/', page: () => Onboarding()),
  // GetPage(name: '/', page: () => MainPage()),
  // GetPage(name: '/', page: () => MainPage()),
  //Auth
  GetPage(name: AppRoutes.onboardingAuth, page: () => OnboardingAuth()),
  GetPage(name: AppRoutes.login, page: () => Login()),
  GetPage(name: AppRoutes.signup, page: () => Signup()),
  GetPage(name: AppRoutes.checkEmail, page: () => Checkemail()),
  // GetPage(name: AppRoutes.forgotPassword, page: () => Forgotpassword()),
  GetPage(name: AppRoutes.resetpassword, page: () => Resetpassword()),
  //Main Page
  GetPage(name: AppRoutes.mainPage, page: () => MainPage()),
  //Home Page
  GetPage(name: AppRoutes.searhPage, page: () => SearchPage()),
  GetPage(name: AppRoutes.categoryPage, page: () => AllCategoryPage()),
  GetPage(name: AppRoutes.mainCategory, page: () => MainCategory()),
  GetPage(name: AppRoutes.benefits, page: () => BenefitsPage()),
  GetPage(name: AppRoutes.notificationPage, page: () => NotificationsPage()),
  GetPage(name: AppRoutes.allTrendingCourse, page: () => AllTrendingCourse()),
  GetPage(name: AppRoutes.allFreeCourses, page: () => AllFreeCourses()),

  //profile page
  GetPage(name: AppRoutes.editProfilePage, page: () => EditProfilePage()),
  GetPage(name: AppRoutes.settingsPage, page: () => SettingPage()),
  GetPage(name: AppRoutes.helpCenterPage, page: () => HelpCenterPage()),
  GetPage(name: AppRoutes.favoritesPage, page: () => FavoritesPage()),
  GetPage(name: AppRoutes.aboutLearnova, page: () => AboutLearnova()),
  GetPage(name: AppRoutes.inviteFriendsPage, page: () => InviteFriendsPage()),

  //courses
  GetPage(name: AppRoutes.coursePage, page: () => CoursePage()),
  GetPage(name: AppRoutes.learningCourse, page: () => CourseLearning()),
  GetPage(name: AppRoutes.mycoursespage, page: () => Mycoursespage()),
  GetPage(name: AppRoutes.videoPage, page: () => VideoPage()),
  GetPage(name: AppRoutes.addRatingPage, page: () => AddRatingPage()),
  GetPage(name: AppRoutes.ratingPage, page: () => RatingPage()),
  GetPage(name: AppRoutes.viewRatingPage, page: () => ViewRatingPage()),
  GetPage(name: AppRoutes.editRatingPage, page: () => EditRatingPage()),
  GetPage(name: AppRoutes.quizPage, page: () => QuizPage()),
  GetPage(name: AppRoutes.resultsPage, page: () => ResultsPage()),
  GetPage(name: AppRoutes.editnotepage, page: () => EditNotePage()),
  GetPage(name: AppRoutes.paymentPage, page: () => PaymentPage()),
  GetPage(name: AppRoutes.allReviewinCourse, page: () => AllReviewinCourse()),
];
