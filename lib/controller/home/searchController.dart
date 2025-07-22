import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/model/searchCoursesModel.dart';
import 'package:learn_nova/data/source/remote/home/ExternalCourse.dart';

class SearchCourseController extends GetxController {
  Statusrequest statusrequest = Statusrequest.none;
    final box = GetStorage();


  ExternalCourseData externalCourseData =
      ExternalCourseData(crud: Get.find<Crud>());

  String searchText = '';
  String? selectedCategory;
  String? selectedLevel;
  String? selectedDuration;
  bool showFilters = false;
  bool hasTyped = false;

  List<String> searchHistory = [];
  List<SearchCoursesModel> filteredCourses = [];
  List<SearchCoursesModel> allCourses = [];


  @override
  void onInit() {
    super.onInit();
    getCourseData();

    List<dynamic>? savedHistory = box.read<List<dynamic>>('searchHistory');
    if (savedHistory != null) {
      searchHistory = savedHistory.cast<String>();
    }
  }

  getCourseData() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await externalCourseData.getData();
    statusrequest = handilingData(response);
    if (statusrequest == Statusrequest.success) {
      allCourses = (response['data'] as List)
          .map((courseJson) => SearchCoursesModel.fromJson(courseJson))
          .toList();
      // ما نخلي filteredCourses هنا تساوي كل الكورسات
      filteredCourses = [];
    }
    update();
  }

  void updateSearchText(String text) {
    searchText = text;
    hasTyped = text.trim().isNotEmpty;
    filterCourses();
    update();
  }

  void updateCategory(String? category) {
    selectedCategory = category;
    filterCourses();
    update();
  }

  void updateLevel(String? level) {
    selectedLevel = level;
    filterCourses();
    update();
  }

  void updateDuration(String? duration) {
    selectedDuration = duration;
    filterCourses();
    update();
  }

  void filterCourses() {
    final query = searchText.toLowerCase().trim();

    // إذا المستخدم ما كتب شي وما اختار أي فلتر → لا تعرض شي
    final noSearchAndNoFilters = query.isEmpty &&
        selectedCategory == null &&
        selectedLevel == null &&
        selectedDuration == null;

    if (noSearchAndNoFilters) {
      filteredCourses = [];
      update();
      return;
    }

    // فلترة حقيقية
    filteredCourses = allCourses.where((course) {
      final matchSearch =
          query.isEmpty || course.title.toLowerCase().contains(query);

      final matchCategory = selectedCategory == null ||
          selectedCategory == 'All' ||
          course.category == selectedCategory;

      final matchLevel = selectedLevel == null ||
          selectedLevel == 'All' ||
          course.difficulty_level.toLowerCase() == selectedLevel!.toLowerCase();

      final matchDuration = selectedDuration == null ||
          selectedDuration == 'All' ||
          course.duration == selectedDuration;

      return matchSearch && matchCategory && matchLevel && matchDuration;
    }).toList();

    update();
  }

  List<String> getCategories() {
    final unique = allCourses.map((e) => e.category).toSet().toList();
    return ['All', ...unique];
  }

  List<String?> getLevels() {
    final unique = allCourses.map((e) => e.difficulty_level).toSet().toList();
    return ['All', ...unique];
  }

  List<String?> getDurations() {
    final unique = allCourses.map((e) => e.duration).toSet().toList();
    return ['All', ...unique];
  }

  void addToSearchHistory(String search) {
    if (search.trim().isEmpty) return;

    searchHistory.removeWhere((element) => element == search);
    searchHistory.insert(0, search);
    box.write('searchHistory', searchHistory);
    updateSearchText(search);
  }

  void clearSearchHistory() {
    searchHistory.clear();
    box.remove('searchHistory');
    hasTyped = false;
    searchText = '';
    filteredCourses.clear();
    update();
  }

  void toggleFiltersVisibility() {
    showFilters = !showFilters;
    update();
  }
}
