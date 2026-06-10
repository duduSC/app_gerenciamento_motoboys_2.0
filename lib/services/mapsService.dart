import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MapsService {
  static final String? _apiKey = dotenv.env['API_KEY'];

  Future<double> getDistance(String origin, String destination) async {
    if (_apiKey == null) {
      throw Exception("Chave de API do Google Maps não encontrada no .env");
    }

    final uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/directions/json',
      <String, String>{
        'origin': origin.trim(),
        'destination': destination.trim(),
        'mode': 'driving',
        'units': 'metric',
        'key': _apiKey!,
      },
    );


    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if ((jsonResponse['routes'] as List).isNotEmpty) {
        final route = jsonResponse['routes'][0];
        final leg = route['legs'][0];
        final distanceInMeters = leg['distance']['value'];
        return distanceInMeters / 1000.0;
      } else {
        final status = jsonResponse['status'];
        if (status == 'ZERO_RESULTS') {
          throw Exception(
            'Não foi possível encontrar uma rota. Verifique os endereços.',
          );
        }
        throw Exception(
          'Erro ao obter rota: $status. Verifique se a API Directions está ativa no Google Console.',
        );
      }
    } else {
      final error =
          json.decode(response.body)['error_message'] ??
          'Erro desconhecido na API.';
      throw Exception('Erro na API do Google Maps: $error');
    }
  }
}
