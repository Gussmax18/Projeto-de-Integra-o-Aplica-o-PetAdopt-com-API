import 'package:flutter/material.dart';
import 'package:projeto_mobile/widgets/header.dart';
import 'package:projeto_mobile/models/animal.dart';
import 'package:projeto_mobile/widgets/animal_grid.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Pet> favoritos = [
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(location: "Cotia, SP"), 
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.favorite, color: Colors.red, size: 28),
                  SizedBox(width: 8),
                  Text(
                    "Favoritos",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            AnimalGrid(animais: favoritos),
          ],
        ),
      ),
    );
  }
}
