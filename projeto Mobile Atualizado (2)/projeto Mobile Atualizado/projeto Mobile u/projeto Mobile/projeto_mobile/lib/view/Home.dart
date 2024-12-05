import 'package:flutter/material.dart';
import 'package:projeto_mobile/service/AnimalService.dart';
import 'package:projeto_mobile/widgets/header.dart'; 
import 'package:projeto_mobile/widgets/animal_grid.dart'; 
import 'package:projeto_mobile/models/animal.dart';
import 'package:projeto_mobile/widgets/custom_widgets.dart'; 
import 'package:projeto_mobile/widgets/animal_cards.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(location: "Cotia, SP"),
            SizedBox(height: 16),
            _buildPetList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPetList() {
    return FutureBuilder<List<Pet>>(
      future: PetService.fetchPets(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum pet encontrado.'));
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: snapshot.data!.map((pet) {
                return AnimalCard(
                  id: pet.id,
                  name: pet.name,
                  age: pet.age,
                  color: pet.color,
                  imageUrl: pet.images.isNotEmpty ? pet.images.first : '',
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
