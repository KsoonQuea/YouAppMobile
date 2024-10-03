import 'package:http/http.dart' as http;
import '';
import 'dart:convert';
import 'dart:developer' as developer;

class ApiService {
  final String baseUrl = 'https://techtest.youapp.ai';

  Future<dynamic> getData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  Future<dynamic> postRegister(Map<String, dynamic> json_data) async{
    final endpoint = "api/register";

    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(json_data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw { "message" : Exception('Failed to post data')};
    }
  }

  Future<dynamic> postLogin(Map<String, dynamic> json_data) async{
    final endpoint = "api/login";

    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(json_data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw { "message" : Exception('Failed to post data')};
    }
  }

  // Add other methods for PUT, DELETE, etc. as needed
}