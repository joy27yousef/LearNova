import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:learn_nova/core/class/statusRequest.dart';
import 'package:learn_nova/core/function/ckeckInternet.dart';
import 'package:http/http.dart' as http;

class Crud {
  Future<Either<Statusrequest, Map>> getRequest(
      String LinkUrl, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(LinkUrl), body: data);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          return Right(responsebody);
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
