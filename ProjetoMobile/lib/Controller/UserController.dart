import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<String> cadastrarUsuario() async {
    const String apiUrl = 'https://pet-adopt-dq32j.ondigitalocean.app/user/register';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'phone': phoneController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 201) {
        return 'Cadastro realizado com sucesso!';
      } else {
        final message = jsonDecode(response.body)['message'];
        return 'Erro: $message';
      }
    } catch (e) {
      return 'Erro ao conectar-se ao servidor.';
    }
  }

  Future<bool> logarUsuario(String email, String password) async {
    const String apiUrl = 'https://pet-adopt-dq32j.ondigitalocean.app/user/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
