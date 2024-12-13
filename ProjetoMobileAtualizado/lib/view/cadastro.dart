import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto_mobile/view/login.dart';

class Cadastro extends StatelessWidget {
  final TextEditingController _controladorUsername = TextEditingController();
  final TextEditingController _controladorEmail = TextEditingController();
  final TextEditingController _controladorPhone = TextEditingController();
  final TextEditingController _controladorPassword = TextEditingController();
  final TextEditingController _controladorConfirmpassword =
      TextEditingController();

  Cadastro({super.key});

  Future<void> registrarUsuario(BuildContext context) async {
    final String username = _controladorUsername.text;
    final String email = _controladorEmail.text;
    final String phone = _controladorPhone.text;
    final String password = _controladorPassword.text;
    final String confirmpassword = _controladorConfirmpassword.text;

    if (username.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha todos os campos!")),
      );
      return;
    }

    final Map<String, dynamic> usuarioJson = {
      "name": username,
      "email": email,
      "phone": phone,
      "password": password,
      "confirmpassword": confirmpassword,
    };

    const url = 'https://pet-adopt-dq32j.ondigitalocean.app/user/register';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(usuarioJson),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cadastro realizado com sucesso!")),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro no cadastro: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro de conexão: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('AppDoption'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Logo
            Center(
              child: Image.asset(
                'assets/pawn.png', // Caminho da logo
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Cadastre-se no AppDoption!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 40),

            // Campos de entrada
            TextField(
              controller: _controladorUsername,
              decoration: const InputDecoration(
                labelText: 'Nome de Usuário',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controladorEmail,
              decoration: const InputDecoration(
                labelText: 'E-mail',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controladorPhone,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controladorPassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controladorConfirmpassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar Senha',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 40),

            // Botão de cadastro
            ElevatedButton(
              onPressed: () => registrarUsuario(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Cadastrar'),
            ),
            const SizedBox(height: 20),

            // Link para login
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: const Text('Já tem uma conta? Faça login'),
            ),
          ],
        ),
      ),
    );
  }
}
