import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class AddNotesData {
  Crud? crud;
  AddNotesData({this.crud});
  getData(int courseId, String content, int? videoId) async {
    Map<String, dynamic> data = {
      "course_id": courseId,
      "content": content,
    };

    if (videoId != null) {
      data["video_id"] = videoId;
    }
    var response = await crud!.postRequest(
      "${Applinks.notes}",
      data,
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}

class ViewNotesData {
  Crud? crud;
  ViewNotesData({this.crud});
  getData(int courseId) async {
    var response = await crud!.getRequest(
      "${Applinks.notes}?$courseId",
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}

class DeleteNotesData {
  Crud? crud;
  DeleteNotesData({this.crud});
  getData(int noteID) async {
    var response = await crud!.deleteRequest("${Applinks.notes}/$noteID");
    return response.fold((l) => l, (r) => r);
  }
}

class EditNotesData {
  Crud? crud;
  EditNotesData({this.crud});
  getData(int noteId, String content) async {
    var response = await crud!.putRequest(
      "${Applinks.notes}/$noteId",
      {"content": content},
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}
