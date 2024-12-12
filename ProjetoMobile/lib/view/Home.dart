import 'package:flutter/material.dart';
import 'package:projeto_mobile/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:projeto_mobile/view/favoritos.dart';
import 'package:projeto_mobile/view/cadastrarAnimal.dart';
import 'package:projeto_mobile/view/perfil.dart';
import 'package:projeto_mobile/models/animal.dart';
import 'package:projeto_mobile/widgets/animal_cards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    FavoritosScreen(),
    CadastrarAnimalScreen(),
    PerfilScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text(
          '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Color.fromARGB(195, 218, 83, 20),
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Pets cadastrados',
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

class HomeContent extends StatelessWidget {
  Future<List<Pet>> fetchAnimals() async {
    try {
      final response = await http.get(Uri.parse('https://exemplo.com/api/animais'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((animalJson) => Pet.fromJson(animalJson)).toList();
      } else {
        throw Exception('Erro na resposta da API');
      }
    } catch (e) {
      print('Erro ao buscar os animais: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(location: "Cotia, SP"),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Categorias",
              style: TextStyle(fontSize: 18, color: Colors.orange),
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CategoryButton(text: "Próximos de você"),
                CategoryButton(text: "Gatos"),
                CategoryButton(text: "Cães"),
                CategoryButton(text: "Aves"),
                IconButton(
                  onPressed: () {
                    // Implementar ação do filtro
                  },
                  icon: Icon(Icons.tune, color: Colors.orange),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          FutureBuilder<List<Pet>>(
            future: fetchAnimals(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text('Erro ao carregar os animais')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text('Nenhum animal encontrado')),
                );
              }

              List<Pet> pets = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: pets.length,
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return AnimalCard(
                      name: pet.name,
                      breed: pet.color, // Adapte se houver campo específico
                      imageUrl: pet.images.isNotEmpty ? pet.images[0] : '',
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String text;
  const CategoryButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Implementar a lógica para filtrar por categoria
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
