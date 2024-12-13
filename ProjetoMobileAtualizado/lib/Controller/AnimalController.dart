import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projeto_mobile/models/animal.dart';  // Certifique-se de importar seu modelo Pet

class AnimalController {
  // URL da API
  static const String apiUrl = 'https://pet-adopt-dq32j.ondigitalocean.app/pet';

  // Função para cadastrar um animal
  Future<bool> cadastrarAnimal(Pet pet) async {
    try {
      final response = await http.post(
        Uri.parse('$apiUrl/create'), // Endpoint para criar o animal
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(pet.toJson()), // Envia os dados do pet como JSON
      );

      if (response.statusCode == 200) {
        return true; // Cadastro bem-sucedido
      } else {
        print('Erro ao cadastrar animal: ${response.body}');
        return false; // Erro no cadastro
      }
    } catch (e) {
      print('Erro de conexão: $e');
      return false; // Erro de conexão
    }
  }

  // Função para obter todos os animais cadastrados
  Future<List<Pet>> obterAnimais() async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/list'), // Endpoint para obter todos os animais
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body); // Decodifica o JSON

        // Mapeia os dados para uma lista de objetos Pet
        return data.map((item) => Pet.fromJson(item)).toList();
      } else {
        print('Erro ao obter animais: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Erro de conexão: $e');
      return [];
    }
  }
}
