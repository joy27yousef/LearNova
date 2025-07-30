import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learn_nova/core/constant/AppLinks.dart';

class AiAssistantData {
  Future<Map<String, dynamic>> getData(String message) async {
    final url = Uri.parse(Applinks.aiAssistant);
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    final body = jsonEncode({"string": message});
    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          final data = jsonDecode(response.body);
          return {"data": data};
        } catch (e) {
          return {"data": response.body};
        }
      } else {
        return {"error": "Server error: ${response.statusCode}"};
      }
    } catch (e) {
      return {"error": "Exception: $e"};
    }
  }
}
