import 'package:get/get.dart';
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/home/ExternalCourse.dart';
import 'package:learn_nova/data/source/remote/home/categories.dart';

abstract class CategoryController extends GetxController {
  getCourseData();
  getCategoryData();
  onInit();
}

class CategoryControllerIMP extends CategoryController {
  //init
  @override
  void onInit() {
    getCourseData();
    getCategoryData();
    super.onInit();
  }

  CategoriesData categoriesData = CategoriesData(crud: Get.find<Crud>());
  ExternalCourseData externalCourseData =
      ExternalCourseData(crud: Get.find<Crud>());
  late Statusrequest statusrequest;

  List maincategories = []; // parent Categories
  List dataCategory = []; //all data in cateory
  List dataCourse = []; //all data in cateory
  List subcategoriesWithAll = [];
  var selectedIndex = 0.obs;
  var selectedCategoryId = 0.obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  getCategoryData() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await categoriesData.getData();
    statusrequest = handilingData(response);
    if (Statusrequest.success == statusrequest) {
      maincategories.clear();
      dataCategory.addAll(response['data']);
      maincategories.addAll(
          response['data'].where((element) => element['parent_id'] == null));
    } else {
      // statusrequest = Statusrequest.failure;
    }
    update();
  }

  @override
  getCourseData() async {
    statusrequest = Statusrequest.loading;
    update();
    var response = await externalCourseData.getData();
    statusrequest = handilingData(response);
    if (Statusrequest.success == statusrequest) {
      dataCourse.clear();
      dataCourse.addAll(response['data']);
    } else {
      // statusrequest = Statusrequest.failure;
    }
    update();
  }

  void updateCoursesForMainCategory(int mainCategoryId) {
    selectedCategoryId.value = 0;
    selectedIndex.value = 0;
    update();
  }
}
