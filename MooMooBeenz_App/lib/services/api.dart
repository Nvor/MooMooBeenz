import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class ApiService with ChangeNotifier {
  final String apiUrl = "http://localhost:8080/";

  Future<http.Response> getData(String resource) async {
    Uri url = Uri.parse(resource);
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  Future<http.Response> postData(String resource, Map<String, String> body) async {
    Uri url = Uri.parse(resource);
    var response = await http.post(url, body: body);
    return jsonDecode(response.body);
  }
}