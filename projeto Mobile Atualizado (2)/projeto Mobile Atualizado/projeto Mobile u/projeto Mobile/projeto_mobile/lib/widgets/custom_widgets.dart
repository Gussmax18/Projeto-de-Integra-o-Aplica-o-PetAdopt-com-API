// lib/widgets/custom_widgets.dart

import 'package:flutter/material.dart';

// Definição do widget CategoryButton
class CategoryButton extends StatelessWidget {
  final String text;

  const CategoryButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 224, 178, 1), // Mesma paleta de cores
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: const Color.fromRGBO(245, 124, 0, 1)),
      ),
    );
  }
}

// Definição do widget ONGCard
class ONGCard extends StatelessWidget {
  final String name;
  final Color color;

  const ONGCard({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 224, 178, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.pets, size: 40, color: color), // Cor alterada
            SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
