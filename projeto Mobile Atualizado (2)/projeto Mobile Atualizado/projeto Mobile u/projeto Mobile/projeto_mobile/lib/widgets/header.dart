import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String location;

  const Header({required this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 8), // Diminui o espaçamento no topo
          child: Column(
            children: [
              // Logo centralizada
              Center(
                child: Image.asset(
                  'assets/pawn.png', // Substitua pelo caminho da sua logo
                  height: 80, // Tamanho da logo
                ),
              ),
              // Texto "AppDoption" centralizado
              Text(
                "AppDoption",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange, // Mesma cor de destaque usada na tela de login
                ),
              ),
            ],
          ),
        ),
        // Informações de localização e avatar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    location,
                    style: TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: Colors.orange, // Cor do avatar
                child: Text("A", style: TextStyle(color: Colors.white)), // Inicial de exemplo
              ),
            ],
          ),
        ),
      ],
    );
  }
}
