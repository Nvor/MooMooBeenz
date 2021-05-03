import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class ApiService with ChangeNotifier {
  final String apiUrl = "http://10.0.2.2:5000/";

  Future<dynamic> get(String resource) async {
    Uri url = Uri.parse(apiUrl + resource);
    var response = await http.get(url)
        .then((http.Response response) {
          validateHttpResponse(response);
        });

    return jsonDecode(response.body);
  }

  Future<dynamic> post(String resource, {Map<String, String> body}) async {
    Uri url = Uri.parse(apiUrl + resource);
    var response = await http.post(url, body: body)
        .then((http.Response response) {
          validateHttpResponse(response);
      });

    return jsonDecode(response.body);
  }

  void validateHttpResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 400) {
      throw new Exception("Error fetching data");
    }
  }
}