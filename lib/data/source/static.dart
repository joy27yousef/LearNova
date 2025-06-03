import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/data/model/TestimonialsTest.dart';
import 'package:learn_nova/data/model/benefitsModel.dart';
import 'package:learn_nova/data/model/categoryTEST.dart';
import 'package:learn_nova/data/model/homeScrolMesModel.dart';
import 'package:learn_nova/data/model/onboardingModel.dart';

List<Onboardingmodel> onboardingList = [
  Onboardingmodel(title: "2".tr, image: Appimages.onboadring1, body: "3".tr),
  Onboardingmodel(title: "4".tr, image: Appimages.onboadring2, body: "5".tr),
  Onboardingmodel(title: "6".tr, image: Appimages.onboadring3, body: "7".tr),
  Onboardingmodel(title: "8".tr, image: Appimages.onboadring4, body: "9".tr),
];

List<Homescrolmesmodel> homeScrol = [
  Homescrolmesmodel(
    content: 'Set your daily goal \nand make progress\n every day',
    image: Appimages.homeScrol1,
  ),
  Homescrolmesmodel(
    content: 'New ideas are \nwaiting for you dive \ninto a lesson!',
    image: Appimages.homeScrol2,
  ),
  Homescrolmesmodel(
    content: 'Your brain is \na muscle exercise \nit with knowledge',
    image: Appimages.homeScrol3,
  ),
  Homescrolmesmodel(
    content: 'Just 10 minutes a \n day can make \na big difference',
    image: Appimages.homeScrol4,
  ),
];

//\ Test for Category
List<Categorytest> categoryTest = [
  Categorytest(name: 'Computer\n Science', image: Appimages.datascience),
  Categorytest(name: 'Health', image: Appimages.health),
  Categorytest(name: 'Language', image: Appimages.languages),
  Categorytest(name: 'Physical\n Sience', image: Appimages.Physical),
  Categorytest(name: 'Business', image: Appimages.business),
  Categorytest(name: 'Art and Humanities', image: Appimages.activities),
  Categorytest(name: 'Math and Logic', image: Appimages.mathematics),
  Categorytest(name: 'Personal Development', image: Appimages.selfConfidence),
];

//Benefits
List<Benefitsmodel> Benefits = [
  Benefitsmodel(
      'Flexible Learning',
      "Learn at your own pace with 24/7 access to courses. Set your own schedule and learn when it's most convenient for you",
      Appimages.books),
  Benefitsmodel(
      'Expert Instructors',
      "Learn from industry professionals with years of practical experience. Our instructors are passionate about sharing their knowledge.",
      Appimages.teacher),
  Benefitsmodel(
      'Interactive Content',
      "Engage with hands-on projects, quizzes, and interactive assignments that reinforce your learning and keep you motivated.",
      Appimages.hand),
  Benefitsmodel(
      'Career Support',
      "Get guidance on career paths, resume building, and job opportunities. Connect with our network of industry partners.",
      Appimages.suitcase),
  Benefitsmodel(
      'Community Learning',
      "Join a vibrant community of learners. Collaborate on projects, share insights, and grow together through peer learning.",
      Appimages.social),
  Benefitsmodel(
      'Certified Courses',
      "Earn recognized certificates upon course completion. Add valuable credentials to your professional portfolio.",
      Appimages.mortarboard),
];

//Test for Testimonialstest
List<Testimonialstest> Testimonials = [
  Testimonialstest(
      "Sarah L.",
      "Web Developer",
      "The web design course provided a solid foundation for me. The instructors were knowledgeable and supportive, and the interactive learning environment was engaging. Highly recommend it!",
      Appimages.TT1),
  Testimonialstest(
      "Jason M.",
      "UI/UX Designer",
      "The UI/UX design course exceeded my expectations. The instructor's expertise and practical assignments helped me improve my design skills. I feel more confident in my career now. Thank you!",
      Appimages.TT2),
  Testimonialstest(
      "Farah N.",
      "Mobile Developer",
      "The web design course provided a solid foundation for me. The instructors were knowledgeable and supportive, and the interactive learning environment was engaging. Highly recommend it!",
      Appimages.TT3),
  Testimonialstest(
      "George N.",
      "Graphic Designer",
      "I excelled in the graphic design course as a beginner, and it was the perfect starting point. The instructor's guidance and feedback improved my design abilities significantly. I'm grateful for this course!",
      Appimages.TT4),
];
