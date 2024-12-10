import 'package:flutter/material.dart';
import 'package:projeto_mobile/models/animal.dart';
import 'package:projeto_mobile/widgets/animal_cards.dart'; // Modelo Pet

class AnimalGrid extends StatelessWidget {
  final List<Pet> pets;

  const AnimalGrid({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Permite que o GridView ajuste o tamanho automaticamente
      physics: const NeverScrollableScrollPhysics(), // Desativa o scroll interno
      itemCount: pets.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return AnimalCard(pet: pets[index]);
      },
    );
  }
}
