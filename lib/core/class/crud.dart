import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/ckeckInternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  //post Request
  Future<Either<Statusrequest, Map>> postRequest(
    String linkUrl,
    Map data, {
    bool withToken = false,
    Map<String, String>? headers,
  }) async {
    try {
      if (await checkInternet()) {
        Map<String, String> defaultHeaders = {
          "Content-Type": "application/json",
          "Accept": "application/json",
        };

        if (withToken) {
          final box = GetStorage();
          String? token = box.read('token');
          if (token != null && token.isNotEmpty) {
            defaultHeaders['Authorization'] = 'Bearer $token';
          }
        }

        if (headers != null) {
          defaultHeaders.addAll(headers);
        }

        var response = await http.post(
          Uri.parse(linkUrl),
          body: jsonEncode(data),
          headers: defaultHeaders,
        );

        print("🔗 POST Request to: $linkUrl");
        print("📤 Data sent: $data");
        print("📥 Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return Left(Statusrequest.serverfailure);
        }
      } else {
        return Left(Statusrequest.offlinefailure);
      }
    } catch (e) {
      print("❌ Exception during POST request: $e");
      return Left(Statusrequest.serverException);
    }
  }

//get Request
  Future<Either<Statusrequest, Map>> getRequest(
    String linkUrl, {
    bool withToken = false,
  }) async {
    try {
      if (await checkInternet()) {
        Map<String, String>? headers;
        if (withToken) {
          final box = GetStorage();
          String? token = box.read('token');
          headers = {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          };
        }

        var response = await http.get(
          Uri.parse(linkUrl),
          headers: headers,
        );

        print("🔗 Request to: $linkUrl");
        print("📥 Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          return Right(responseBody);
        } else {
          return Left(Statusrequest.serverfailure);
        }
      } else {
        return Left(Statusrequest.offlinefailure);
      }
    } catch (e) {
      print(" Exception in getRequest: $e");
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
          },
        );
        print("📥 Status Code: ${response.statusCode}");
        print("📥 Response Body: ${response.body}");

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

// put Request
Future<Either<Statusrequest, Map>> putRequest(
  String linkUrl,
  Map data, {
  Map<String, String>? headers,
  String? token,
}) async {
  try {
    if (await checkInternet()) {
      var defaultHeaders = {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };
      if (token != null && token.isNotEmpty) {
        defaultHeaders["Authorization"] = "Bearer $token";
      }
      if (headers != null) {
        defaultHeaders.addAll(headers);
      }
      var response = await http.put(
        Uri.parse(linkUrl),
        body: jsonEncode(data),
        headers: defaultHeaders,
      );
      print("🔗 PUT Request to: $linkUrl");
      print("📤 Data sent: $data");
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
    print("❌ Exception during PUT request: $e");
    return Left(Statusrequest.serverException);
  }
}
