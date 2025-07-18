import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class AddToFavoritesData {
  Crud? crud;
  AddToFavoritesData({this.crud});
  getData(int courseId) async {
    var response = await crud!
        .postRequest("${Applinks.FavCour}/$courseId", {}, withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}

class RemoveFromFavoritesData {
  Crud? crud;
  RemoveFromFavoritesData({this.crud});
  getData(int courseId) async {
    var response = await crud!.deleteRequest("${Applinks.FavCour}/$courseId");
    return response.fold((l) => l, (r) => r);
  }
}

class ViewFavoritesData {
  Crud? crud;
  ViewFavoritesData({this.crud});
  getData() async {
    var response = await crud!.getRequest(Applinks.FavCour, withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}

class CheckFavoritesData {
  Crud? crud;
  CheckFavoritesData({this.crud});
  getData(int courseId) async {
    var response = await crud!
        .getRequest("${Applinks.FavCour}/$courseId/check", withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}
