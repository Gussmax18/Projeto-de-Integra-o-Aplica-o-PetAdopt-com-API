import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<String> cadastrarUsuario() async {
    if (passwordController.text != confirmPasswordController.text) {
      return 'As senhas não coincidem';
    }

    final response = await http.post(
      Uri.parse('https://pet-adopt-dq32j.ondigitalocean.app/user/register'),
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
      final error = jsonDecode(response.body)['message'] ?? 'Erro ao cadastrar usuário.';
      return 'Erro: $error';
    }
  }
}
