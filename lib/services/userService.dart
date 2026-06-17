import 'dart:convert';

import 'package:app_gerenciamento_motoboys/model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  static final String _baseUrl = dotenv.env['API_URL'] ?? '/api';

  Future<List<User>> getUsers() async {
    final url = '$_baseUrl/users';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("Falha ao buscar usuarios ${response.statusCode}");
    }
  }

  Future<User> createUser(User user) async {
    final url = '$_baseUrl/users';
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "Application/json"},
      body: json.encode(user.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception("Usuario nao foi criado: ${response.statusCode}");
    }
  }
}
