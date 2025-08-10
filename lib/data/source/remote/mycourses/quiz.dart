import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:learn_nova/core/class/crud.dart';
import 'package:learn_nova/core/constant/AppLinks.dart';

class GetQuizzesData {
  Future<dynamic> getData(int courseId) async {
    try {
      final url = Uri.parse("${Applinks.quiz}/$courseId/quiz/");
      final box = GetStorage();
      String? token = box.read('token');
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print("🔗 Request to: $url");
      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decoded = jsonDecode(response.body);
        if (decoded is List && decoded.isNotEmpty && decoded[0] is Map) {
          return decoded[0];
        }
        return decoded;
      } else {
        // تقدر ترجع خطأ أو null حسب ما يناسبك
        return null;
      }
    } catch (e) {
      print("❌ Exception in getData: $e");
      return null;
    }
  }
}

class CheckQuizAttemptData {
  Crud? crud;
  CheckQuizAttemptData({this.crud});
  getData(int courseId, int quizeid) async {
    var response = await crud!.getRequest(
      "${Applinks.quiz}/$courseId/quizzes/$quizeid/attempt-status",
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}

class SubmitQuizData {
  Crud? crud;
  SubmitQuizData({this.crud});
  getData(int courseId, int quizId, Map<String, int> selectedAnswers) async {
    var response = await crud!.postRequest(
      "${Applinks.quiz}/$courseId/quiz/$quizId/submit",
      {"answers": selectedAnswers},
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}

class GetQuizResultsData {
  Crud? crud;
  GetQuizResultsData({this.crud});
  getData(int attemptId) async {
    var response = await crud!.postRequest(
      "${Applinks.quizResults}/$attemptId/results",
      {},
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}

class GetCertificateData {
  Crud? crud;
  GetCertificateData({this.crud});
  getData(int idcourse, int idquiz) async {
    var response = await crud!.postRequest(
      "${Applinks.quiz}/$idcourse/certificate",
      {'quiz_id': idquiz},
      withToken: true,
    );
    return response.fold((l) => l, (r) => r);
  }
}
