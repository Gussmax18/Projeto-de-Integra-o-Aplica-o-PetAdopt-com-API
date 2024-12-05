import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<String> cadastrarUsuario() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    final url = Uri.parse('https://pet-adopt-dq32j.ondigitalocean.app/user/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'confirmPassword': confirmPassword, // Garantir o envio correto
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return 'Cadastro realizado com sucesso!';
      } else {
        return 'Erro ao cadastrar: ${responseData['message'] ?? 'Erro desconhecido'}';
      }
    } catch (e) {
      return 'Erro de conexão: $e';
    }
  }
}
