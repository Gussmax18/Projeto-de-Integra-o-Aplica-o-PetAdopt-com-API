import 'package:flutter/material.dart';
import 'package:projeto_mobile/Controller/UserController.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final UserController _userController = UserController();
  final _formKey = GlobalKey<FormState>();
  String feedbackMessage = '';

  void _realizarCadastro() async {
    if (_formKey.currentState!.validate()) {
      final mensagem = await _userController.cadastrarUsuario();
      setState(() {
        feedbackMessage = mensagem;
      });
    }
  }

  String? _validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o email';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zAZ0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Informe um email válido';
    }
    return null;
  }

  String? _validarSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe a senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  String? _validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Informe o telefone';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Informe apenas números';
    }
    if (value.length < 10) {
      return 'O telefone deve ter no mínimo 10 dígitos';
    }
    return null;
  }

  // Validação de confirmação de senha
  String? _validarConfirmacaoSenha(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirme a senha'; // Verifica se o campo está vazio
    }
    if (value != _userController.passwordController.text) {
      return 'As senhas não coincidem'; // Verifica se as senhas são iguais
    }
    return null; // Retorna null se não houver erro
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nome
              TextFormField(
                controller: _userController.nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              // Email
              TextFormField(
                controller: _userController.emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: _validarEmail,
              ),
              // Telefone
              TextFormField(
                controller: _userController.phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: _validarTelefone,
              ),
              // Senha
              TextFormField(
                controller: _userController.passwordController,
                decoration: const InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: _validarSenha,
              ),
              // Confirmar Senha
              TextFormField(
                controller: _userController.confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirme a Senha'),
                obscureText: true,
                validator: _validarConfirmacaoSenha, // Validação corrigida
              ),
              const SizedBox(height: 16),
              // Botão de cadastro
              ElevatedButton(
                onPressed: _realizarCadastro,
                child: const Text('Cadastrar'),
              ),
              const SizedBox(height: 16),
              // Feedback da operação
              Text(
                feedbackMessage,
                style: TextStyle(
                  color: feedbackMessage.contains('sucesso') ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
