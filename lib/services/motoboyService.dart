import 'dart:convert';
import 'package:app_gerenciamento_motoboys/model/motoboy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MotoboyService {
  // A URL agora é um caminho relativo para funcionar com o reverse proxy
  static String _baseUrl = dotenv.env['API_URL'] ?? '/api';

  Future<List<Motoboy>> getMotoboys() async {
    final url = '$_baseUrl/motoboys';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) => Motoboy.fromJson(user)).toList();
    } else {
      throw Exception(
        "Falha ao buscar motoboys.\n Código: ${response.statusCode}\n Request : ${response.request} \n Body: ${response.body} ",
      );
    }
  }

  Future<Motoboy> getMotoboy(String cpf) async {
    final url = '$_baseUrl/motoboys/$cpf';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Motoboy.fromJson(json.decode(response.body));
    } else {
      throw Exception("Falha ao buscar motoboy ${response.statusCode}");
    }
  }

  Future<Motoboy> createMotoboy(Motoboy motoboy) async {
    final url = '$_baseUrl/motoboys';
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "Application/json"},
      body: json.encode(motoboy.toJsonEdit()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Motoboy.fromJson(json.decode(response.body));
    } else {
      throw Exception("Usuario nao foi criado: ${response.statusCode}");
    }
  }

  Future<Motoboy> updateMotoboy(Motoboy motoboy) async {
    final url = '$_baseUrl/motoboys/${motoboy.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(motoboy.toJson()),
    );
    if (response.statusCode == 200) {
      return Motoboy.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao atualizar ${response.statusCode}");
    }
  }

  Future<Motoboy> createTele({
    required String idMotoboy,
    required String novaTele,
  }) async {
    final motoboy = await getMotoboy(idMotoboy);
    motoboy.teles = motoboy.teles ?? [];
    motoboy.teles!.add(novaTele);

    final url = '$_baseUrl/motoboys/${motoboy.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(motoboy.toJson()),
    );

    if (response.statusCode == 200) {
      return Motoboy.fromJson(json.decode(response.body));
    } else {
      throw Exception("Erro ao atualizar ${response.statusCode}");
    }
  }

  Future<void> deleteMotoboy(String id) async {
    final url = '$_baseUrl/motoboys/$id';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Falha ao remover usuário (${response.statusCode})');
    }
  }
}
