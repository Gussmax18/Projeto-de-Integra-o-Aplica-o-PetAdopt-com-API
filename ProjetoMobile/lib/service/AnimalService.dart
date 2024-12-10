import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_mobile/models/animal.dart';

class PetService {
  static const String _baseUrl = 'https://pet-adopt-dq32j.ondigitalocean.app/pet/pets';

  static Future<List<Pet>> fetchPets() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      
      // Imprime a resposta para depuração
      print('Resposta da API: $jsonResponse');
      
      if (jsonResponse is List) {
        // Caso a resposta seja uma lista de pets
        return jsonResponse.map((json) => Pet.fromJson(json)).toList();
      } else if (jsonResponse['data'] != null && jsonResponse['data'] is List) {
        // Caso os pets estejam dentro de um campo 'data'
        return (jsonResponse['data'] as List).map((json) => Pet.fromJson(json)).toList();
      } else {
        throw Exception('Formato inesperado na resposta da API');
      }
    } else {
      throw Exception('Erro ao carregar os pets. Status: ${response.statusCode}');
    }
  }
}