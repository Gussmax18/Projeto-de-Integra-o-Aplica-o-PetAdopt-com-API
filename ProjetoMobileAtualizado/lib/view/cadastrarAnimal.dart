import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:projeto_mobile/models/animal.dart'; // Certifique-se de importar seu modelo Pet.

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
  final TextEditingController _pesoController = TextEditingController();
  String _sexo = 'Macho';

  Future<String?> _getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<void> _cadastrarAnimal() async {
    if (_formKey.currentState!.validate()) {
      final pet = Pet(
        id: '',
        name: _nomeController.text,
        age: _idadeController.text,
        color: _corController.text,
        images: [_imagemController.text],
  
      );

      final petData = pet.toJson();

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
          _clearForm();
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

  void _clearForm() {
    _nomeController.clear();
    _idadeController.clear();
    _corController.clear();
    _imagemController.clear();
    _pesoController.clear();
    setState(() {
      _sexo = 'Macho';
    });
  }

  List<Widget> _buildFormFields() {
    return [
      _buildTextField(controller: _nomeController, label: 'Nome do Animal', validator: _validarCampoObrigatorio),
      _buildTextField(controller: _idadeController, label: 'Idade', validator: _validarCampoObrigatorio),
      _buildTextField(controller: _corController, label: 'Cor', validator: _validarCampoObrigatorio),
      _buildTextField(controller: _pesoController, label: 'Peso (kg)', validator: _validarCampoObrigatorio),
      _buildTextField(controller: _imagemController, label: 'URL da Imagem'),
      _buildDropdownField(),
    ];
  }

  Padding _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sexo',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'Macho', child: Text('Macho')),
              DropdownMenuItem(value: 'Fêmea', child: Text('Fêmea')),
            ],
            onChanged: (value) {
              setState(() {
                _sexo = value!;
              });
            },
            value: _sexo,
            hint: const Text('Selecione o Sexo'),
          ),
        ],
      ),
    );
  }

  String? _validarCampoObrigatorio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório!';
    }
    return null;
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
                      color: const Color.fromRGBO(216, 79, 15, 0.765),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ..._buildFormFields(),
                const SizedBox(height: 20),
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
                          backgroundColor: const Color.fromARGB(195, 216, 79, 15),
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
}
