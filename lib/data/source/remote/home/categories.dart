import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class CategoriesData {
  Crud? crud;
  CategoriesData({this.crud});
  getData() async {
    var response = await crud!.getRequest(Applinks.categories);
    return response.fold((l) => l, (r) => r);
  }
}
