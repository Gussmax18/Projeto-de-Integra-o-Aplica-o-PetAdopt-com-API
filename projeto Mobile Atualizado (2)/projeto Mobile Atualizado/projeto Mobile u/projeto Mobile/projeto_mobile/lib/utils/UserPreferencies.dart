import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  
  static Future<void> saveUserData(
      String nome, String email, String senha, String idade, String endereco, String cpf) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nome', nome);
    prefs.setString('email', email);
    prefs.setString('senha', senha);
    prefs.setString('idade', idade);
    prefs.setString('endereco', endereco);
    prefs.setString('cpf', cpf);
  }

  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? nome = prefs.getString('nome');
    String? email = prefs.getString('email');
    String? senha = prefs.getString('senha');
    String? idade = prefs.getString('idade');
    String? endereco = prefs.getString('endereco');
    String? cpf = prefs.getString('cpf');

    return {
      'nome': nome ?? '',
      'email': email ?? '',
      'senha': senha ?? '',
      'idade': idade ?? '',
      'endereco': endereco ?? '',
      'cpf': cpf ?? '',
    };
  }

  
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('email') && prefs.containsKey('senha');
  }

  // Método para limpar os dados do usuário
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('nome');
    prefs.remove('email');
    prefs.remove('senha');
    prefs.remove('idade');
    prefs.remove('endereco');
    prefs.remove('cpf');
  }
}
