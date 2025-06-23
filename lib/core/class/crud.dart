import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/ckeckInternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  //post Request
  Future<Either<Statusrequest, Map>> postRequest(
      String LinkUrl, Map data) async {
    try {
      if (await checkInternet()) {
        Map<String, String> stringData =
            data.map((key, value) => MapEntry(key, value.toString()));
        var response = await http.post(Uri.parse(LinkUrl), body: stringData);
        print("🔗 Request to: $LinkUrl");
        print("📤 Data sent: $stringData");
        print("📥 Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return Left(Statusrequest.serverfailure);
        }
      } else {
        return Left(Statusrequest.offlinefailure);
      }
    } catch (e) {
      print(" Exception during POST request: $e");
      return Left(Statusrequest.serverException);
    }
  }
  // Future<Either<Statusrequest, Map>> postRequest(
  //     String LinkUrl, Map data) async {
  //   try {
  //     if (await checkInternet()) {

  //       var response = await http.post(Uri.parse(LinkUrl), body: data);
  //            print("🔗 Request to: $LinkUrl");
  //     print("📤 Data sent: $data");
  //     print("📥 Status Code: ${response.statusCode}");
  //     print("📥 Response Body: ${response.body}");
  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         Map responsebody = jsonDecode(response.body);
  //         return Right(responsebody);
  //       } else {
  //         return Left(Statusrequest.serverfailure);
  //       }
  //     } else {
  //       return Left(Statusrequest.offlinefailure);
  //     }
  //   } catch (e) {
  //     return Left(Statusrequest.serverException);
  //   }
  // }

//get Request
  Future<Either<Statusrequest, Map>> getRequest(String LinkUrl) async {
    try {
      if (await checkInternet()) {
        var response = await http.get(Uri.parse(
          LinkUrl,
        ));
        print("🔗 Request to: $LinkUrl");

        print("📥 Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          return Left(Statusrequest.serverfailure);
        }
      } else {
        return Left(Statusrequest.offlinefailure);
      }
    } catch (e) {
      print("Exception in getRequest: $e");
      return Left(Statusrequest.serverException);
    }
  }

// Delete Request
  Future<Either<Statusrequest, Map>> deleteRequest(String linkUrl) async {
    try {
      if (await checkInternet()) {
        final box = GetStorage();
        String? token = box.read('token');

        var response = await http.delete(
          Uri.parse(linkUrl),
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 204) {
          Map responseBody = {};
          if (response.body.isNotEmpty) {
            responseBody = jsonDecode(response.body);
          }
          return Right(responseBody);
        } else {
          return Left(Statusrequest.serverfailure);
        }
      } else {
        return Left(Statusrequest.offlinefailure);
      }
    } catch (_) {
      return Left(Statusrequest.serverException);
    }
  }
}
