import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class TestData {
  Crud crud;
  TestData(this.crud);
  getData() async {
    var response = await crud.getRequest(Applinks.test, {});
    return response.fold((l) => l, (r) => r);
  }
}
