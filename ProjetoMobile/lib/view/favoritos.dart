import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_mobile/view/cadastrarAnimal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_mobile/widgets/header.dart';
import 'package:projeto_mobile/models/animal.dart'; // Modelo Pet
import 'package:projeto_mobile/widgets/animal_cards.dart'; // Widget do Card Pet

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  List<Pet> petsCadastrados = [];
  bool isLoading = true;

  // Função para pegar o token do SharedPreferences
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  // Função para pegar os animais cadastrados pelo usuário
  Future<void> _fetchPetsCadastrados() async {
    final token = await _getAuthToken();

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Usuário não autenticado. Faça login novamente.')),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://pet-adopt-dq32j.ondigitalocean.app/pet/mypets'), // Endpoint para pets cadastrados
        headers: {
          'Authorization': 'Bearer $token', // Enviando o token no cabeçalho
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          petsCadastrados = data.map((json) => Pet.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Erro ao carregar pets cadastrados: ${response.body}')),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro de conexão. Tente novamente.')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPetsCadastrados(); // Chama a função para carregar os pets cadastrados ao inicializar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : petsCadastrados.isEmpty
              ? const Center(
                  child: Text(
                    "Nenhum pet cadastrado.",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffE9ECF4),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 23),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.menu,
                                    size: 45, color: Colors.grey[700]),
                                Image.asset("assets/images/Mypet.png",
                                    height: 40, fit: BoxFit.cover),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(40),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.asset(
                                        "assets/images/Mulher.png",
                                        height: 40),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 17),
                              child: Text(
                                "Meus Pets Cadastrados",
                                style: TextStyle(
                                  fontFamily: 'Baloo_Thambi_2',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(14),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3 / 4,
                        ),
                        itemCount: petsCadastrados.length,
                        itemBuilder: (context, index) {
                          final pet = petsCadastrados[index];
                          return GestureDetector(
                            onTap: () {
                              // Aqui você pode implementar a navegação para uma tela de detalhes do pet
                              // Exemplo: Navigator.push(...);
                            },
                            child: AnimalCard(
                              name: pet.name ?? 'Desconhecido',
                              breed: pet.breed ?? 'Raça desconhecida',
                              imageUrl: pet.images ?? 'https://via.placeholder.com/150',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                
    );
  }
}
