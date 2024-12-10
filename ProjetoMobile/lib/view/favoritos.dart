import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_mobile/widgets/header.dart';
import 'package:projeto_mobile/models/animal.dart'; // Modelo Pet
import 'package:projeto_mobile/widgets/animal_grid.dart'; // Grid dos animais

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  List<Pet> favoritos = [];

  // Função para pegar o token do SharedPreferences
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Função para pegar os animais cadastrados pelo usuário
  Future<void> _fetchPets() async {
    final token = await _getAuthToken();

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuário não autenticado. Faça login novamente.')),
      );
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://pet-adopt-dq32j.ondigitalocean.app/pet/mypets'),
        headers: {
          'Authorization': 'Bearer $token', // Enviando o token no cabeçalho
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          favoritos = data.map((json) => Pet.fromJson(json)).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar favoritos: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de conexão. Tente novamente.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPets(); // Chama a função de pegar os pets ao carregar a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(location: "Cotia, SP"),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Icon(Icons.favorite, color: Colors.red, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "Favoritos",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Exibe os favoritos no grid
            favoritos.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : AnimalGrid(pets: favoritos), // Grid de animais
          ],
        ),
      ),
    );
  }
}
