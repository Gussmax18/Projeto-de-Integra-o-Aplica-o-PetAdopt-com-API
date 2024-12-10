import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_mobile/models/animal.dart'; // Certifique-se de importar seu modelo Pet.
import 'package:projeto_mobile/Controller/AnimalController.dart';

class CadastrarAnimalScreen extends StatefulWidget {
  const CadastrarAnimalScreen({Key? key}) : super(key: key);

  @override
  _CadastrarAnimalScreenState createState() => _CadastrarAnimalScreenState();
}

class _CadastrarAnimalScreenState extends State<CadastrarAnimalScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _imagemController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController(); // Novo controlador para peso

  String _sexo = 'Macho';

  // Função para pegar o token salvo no SharedPreferences
  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> _cadastrarAnimal() async {
    if (_formKey.currentState!.validate()) {
      // Criando uma instância do modelo Pet
      final pet = Pet(
        id: '', // Deixe vazio ou gere um ID automaticamente no backend
        name: _nomeController.text,
        age: _idadeController.text,
        color: _corController.text,
        images: [_imagemController.text], // A lista de imagens
        sex: _sexo, // Sexo
        weight: double.tryParse(_pesoController.text) ?? 0.0, // Convertendo o peso para double
      );

      final petData = pet.toJson(); // Convertemos para Map<String, dynamic>

      try {
        final token = await _getAuthToken();

        if (token == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário não autenticado. Faça login novamente.')),
          );
          return;
        }

        final response = await http.post(
          Uri.parse('https://pet-adopt-dq32j.ondigitalocean.app/pet/create'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode(petData),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Animal cadastrado com sucesso!')),
          );
          _nomeController.clear();
          _idadeController.clear();
          _corController.clear();
          _imagemController.clear();
          _pesoController.clear(); // Limpar o campo de peso
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao cadastrar animal: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro de conexão. Tente novamente.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text(
          'AppDoption',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Color.fromARGB(195, 218, 83, 20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/pawn.png',
                    height: 80,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Cadastre seu animal',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 24 : 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(216, 79, 15, 0.765),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Nome
                _buildTextField(
                  controller: _nomeController,
                  label: 'Nome do Animal',
                  validator: (value) {
                    if (value!.isEmpty) return 'Nome é obrigatório!';
                    return null;
                  },
                ),

                // Idade
                _buildTextField(
                  controller: _idadeController,
                  label: 'Idade',
                  validator: (value) {
                    if (value!.isEmpty) return 'Idade é obrigatória!';
                    return null;
                  },
                ),

                // Cor
                _buildTextField(
                  controller: _corController,
                  label: 'Cor',
                  validator: (value) {
                    if (value!.isEmpty) return 'Cor é obrigatória!';
                    return null;
                  },
                ),

                // Sexo
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sexo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          DropdownMenuItem(value: 'Macho', child: Text('Macho')),
                          DropdownMenuItem(value: 'Fêmea', child: Text('Fêmea')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _sexo = value!;
                          });
                        },
                        value: _sexo,
                        hint: Text('Selecione o Sexo'),
                      ),
                    ],
                  ),
                ),

                // Imagem
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Imagem',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _imagemController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'URL da Imagem ou caminho local',
                        ),
                      ),
                    ],
                  ),
                ),

                // Peso
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peso (kg)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _pesoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Peso do Animal',
                        ),
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        validator: (value) {
                          if (value!.isEmpty) return 'Peso é obrigatório!';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Botão de cadastrar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _cadastrarAnimal,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: isSmallScreen ? 12 : 18,
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(195, 216, 79, 15),
                        ),
                        child: Text(
                          'Cadastrar Animal',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Função para criar campos de texto
  Padding _buildTextField({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: label,
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }
}
