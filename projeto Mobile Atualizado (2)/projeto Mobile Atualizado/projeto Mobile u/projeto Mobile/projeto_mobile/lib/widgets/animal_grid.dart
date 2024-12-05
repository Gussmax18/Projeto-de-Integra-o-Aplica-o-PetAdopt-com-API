import 'package:flutter/material.dart';
import 'package:projeto_mobile/models/animal.dart';
import 'package:projeto_mobile/widgets/animal_cards.dart';

class AnimalGrid extends StatelessWidget {
  final List<Pet> animais;

  const AnimalGrid({required this.animais});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(), // Desabilita o scroll dentro do grid
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: animais.length,
        itemBuilder: (context, index) {
          Pet animal = animais[index];

          return AnimalCard(
            id: animal.id,
            name: animal.name,
            age: animal.age,
            color: animal.color,
            imageUrl: animal.images.isNotEmpty ? animal.images[0] : '', // Primeira imagem da lista
          );
        },
      ),
    );
  }
}
