import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseUrl = "https://reqres.in/api";

class ApiUrl {
  final String loginUrl = "$baseUrl/login";
  final String profileUrl = "$baseUrl/users";
  final String listUserUrl = "$baseUrl/users?page=";
}

class ApiHelper {
  final String url;

  ApiHelper({required this.url});

  post(Map<String, String> body) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(url));
    request.body = json.encode(body);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    }
  }

  Future<Map<String, dynamic>> get() async {
    print(url);
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    } else {
      var res = await response.stream.bytesToString();
      return json.decode(res);
    }
  }
}
