import 'package:flutter/material.dart';
import 'package:projeto_mobile/models/animal.dart'; // Modelo Pet

class AnimalCard extends StatelessWidget {
  final Pet pet;

  const AnimalCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(pet.images.isNotEmpty ? pet.images[0] : ''),
          Text(pet.name),
          Text('Idade: ${pet.age}'),
          Text('Cor: ${pet.color}'),
          Text('Sexo: ${pet.sex}'),
          Text('Peso: ${pet.weight} kg'), // Exibindo o peso
        ],
      ),
    );
  }
}
