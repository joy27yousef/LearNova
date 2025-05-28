import 'package:get/get.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/handilingData.dart';
import 'package:learn_nova/data/source/remote/test_data.dart';

class Testcontroller extends GetxController {
  TestData testData = TestData(Get.find());
  List data = [];
  late Statusrequest statusrequest;
  getData() async {
    statusrequest = Statusrequest.loading;
    var response = await testData.getData();
    print(response);
    print("data.length${data.length}");
    statusrequest = handilingData(response);
    if (Statusrequest.success == statusrequest) {
      print('success');
      if (response['status'] == 'success') {
        data.addAll(response['data']);
      } else {
        statusrequest = Statusrequest.failure; 
      }
    }

    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
