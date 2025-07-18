import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class ViewProgress {
  Crud? crud;
  ViewProgress({this.crud});
  getData(int courseId) async {
    var response = await crud!
        .getRequest("${Applinks.progress}/$courseId/progress", withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}

class UpdateProgress {
  Crud? crud;
  UpdateProgress({this.crud});
  getData(int courseId, int progress, int videos) async {
    var response = await crud!.postRequest(
        "${Applinks.progress}/$courseId/progress",
        {"progress": progress, "videos_completed": videos},
        withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}

class MakeWatchedVideo {
  Crud? crud;
  MakeWatchedVideo({this.crud});
  getData(int videoId) async {
    var response = await crud!.postRequest(
        "${Applinks.videoProgress}/$videoId/watch", {},
        withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}

class GetUserVideo {
  Crud? crud;
  GetUserVideo({this.crud});
  getData() async {
    var response =
        await crud!.getRequest(Applinks.uservidewProgress, withToken: true);
    return response.fold((l) => l, (r) => r);
  }
}
