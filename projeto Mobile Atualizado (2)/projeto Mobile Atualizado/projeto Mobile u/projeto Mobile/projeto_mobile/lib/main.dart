import 'package:flutter/material.dart';
import 'package:projeto_mobile/view/DetalhesDoAnimal.dart';
import 'package:projeto_mobile/view/Home.dart';
import 'package:projeto_mobile/view/cadastrarAnimal.dart';
import 'package:projeto_mobile/view/cadastro.dart';
import 'package:projeto_mobile/view/favoritos.dart';
import 'package:projeto_mobile/view/login.dart';
import 'package:projeto_mobile/view/perfil.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Para usar SharedPreferences
import 'package:projeto_mobile/Controller/UserController.dart';
import 'Models/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AppDoption',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder<bool>(
        future: checkUserLoggedIn(), // Função que checa se o usuário está logado
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Exibe um indicador de carregamento enquanto verifica
          } else if (snapshot.hasData && snapshot.data == true) {
            return MainScreen(); // Se o usuário estiver logado, vai para a tela principal
          } else {
            return Login(); // Caso contrário, vai para o login
          }
        },
      ),
    );
  }

  // Função que verifica se o usuário está logado utilizando SharedPreferences
  Future<bool> checkUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Retorna true ou false
    return isLoggedIn;
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Lista de telas da barra de navegação na ordem especificada
  final List<Widget> _screens = [
    HomeScreen(),            // Tela Home
    FavoritosScreen(),       // Tela Favoritos
    CadastrarAnimalScreen(), // Tela Cadastrar Animal
    PerfilScreen(),          // Tela Perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Cadastrar Animal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
