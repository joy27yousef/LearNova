import 'package:get/get.dart';
import 'package:learn_nova/core/constant/AppImages.dart';
import 'package:learn_nova/data/model/TestimonialsTest.dart';
import 'package:learn_nova/data/model/benefitsModel.dart';
import 'package:learn_nova/data/model/fAQHomePage.dart';
import 'package:learn_nova/data/model/homeScrolMesModel.dart';
import 'package:learn_nova/data/model/onboardingModel.dart';

List<Onboardingmodel> onboardingList = [
  Onboardingmodel(title: "2".tr, image: Appimages.onboadring1, body: "3".tr),
  Onboardingmodel(title: "4".tr, image: Appimages.onboadring2, body: "5".tr),
  Onboardingmodel(title: "6".tr, image: Appimages.onboadring3, body: "7".tr),
  Onboardingmodel(title: "8".tr, image: Appimages.onboadring4, body: "9".tr),
];

List<Homescrolmesmodel> get homeScrol => [
      Homescrolmesmodel(
        content: '40'.tr,
        image: Appimages.homeScrol1,
      ),
      Homescrolmesmodel(
        content: '41'.tr,
        image: Appimages.homeScrol2,
      ),
      Homescrolmesmodel(
        content: '42'.tr,
        image: Appimages.homeScrol3,
      ),
      Homescrolmesmodel(
        content: '43'.tr,
        image: Appimages.homeScrol4,
      ),
    ];

//\ Test for Category
List categoryImage = [
  Appimages.cat1,
  Appimages.cat2,
  Appimages.cat3,
  Appimages.cat4,
  Appimages.cat5,
  Appimages.cat6,
  Appimages.cat7,
];

//Benefits
List<Benefitsmodel> get Benefits => [
      Benefitsmodel(
          'Flexible Learning',
          """Learn at your own pace with 24/7 access to courses. Set your own schedule and learn when it's most convenient for you""",
          Appimages.books),
      Benefitsmodel(
          'Expert Instructors',
          """Learn from industry professionals with years of practical experience. Our instructors are passionate about sharing their knowledge.""",
          Appimages.teacher),
      Benefitsmodel(
          'Interactive Content',
          """Engage with hands-on projects, quizzes, and interactive assignments that reinforce your learning and keep you motivated.""",
          Appimages.hand),
      Benefitsmodel(
          'Career Support',
          """Get guidance on career paths, resume building, and job opportunities. Connect with our network of industry partners.""",
          Appimages.suitcase),
      Benefitsmodel(
          'Community Learning',
          """Join a vibrant community of learners. Collaborate on projects, share insights, and grow together through peer learning.""",
          Appimages.social),
      Benefitsmodel(
          'Certified Courses',
          """Earn recognized certificates upon course completion. Add valuable credentials to your professional portfolio.""",
          Appimages.mortarboard),
    ];

//Test for Testimonialstest
List<Testimonialstest> get Testimonials => [
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
List<Faqhomepage> get fAQHomePage => [
      Faqhomepage('Can I enroll in multiple courses at once ?',
          "Absolutely! You can enroll in multiple courses simultaneously and access them at your convenience."),
      Faqhomepage('What kind of support can I expect from instructors ?',
          "Our instructors provide comprehensive support including live Q&A sessions, personalized feedback on assignments, and timely responses to your questions through our learning platform."),
      Faqhomepage(
          'Are the courses self-paced or do they have specific start and end dates ?',
          "We offer both types of courses. Self-paced courses allow you to learn at your own speed, while scheduled courses have specific start and end dates to help you stay on track."),
      Faqhomepage('Are there any prerequisites for the courses ?',
          "Prerequisites vary by course. Basic courses typically don't require prior knowledge, while advanced courses might need specific skills or completion of prerequisite courses."),
      Faqhomepage('Can I download the course materials for offline access ?',
          "Yes, most course materials including video lectures, PDFs, and assignments can be downloaded for offline viewing through our mobile app."),
    ];
