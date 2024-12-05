
import 'dart:convert';
import  'package:http/http.dart' as http;
import 'package:projeto_mobile/models/animal.dart';
 
class PetService {
  static const String apiUrl = "https://pet-adopt-dq32j.ondigitalocean.app/pet/pets";
 
  static Future<List<Pet>> fetchPets() async {
    final response = await http.get(Uri.parse(apiUrl));
 
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['pets'];
      return data.map((pet) => Pet.fromJson(pet)).toList();
    } else {
      throw Exception('Erro ao carregar os pets');
    }
  }
}