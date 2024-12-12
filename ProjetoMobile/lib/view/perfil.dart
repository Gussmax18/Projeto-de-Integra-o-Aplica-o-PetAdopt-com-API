import 'package:flutter/material.dart';
import 'package:projeto_mobile/widgets/header.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(location: "São Paulo, SP"),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromRGBO(216, 79, 15, 0.765),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 224, 178, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color.fromRGBO(255, 152, 0, 1),
                    child: const Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileInfoRow(
                    icon: Icons.person,
                    label: 'Nome',
                    value: 'Bruce Martin',
                  ),
                  ProfileInfoRow(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'bruce.martin@email.com',
                  ),
                  ProfileInfoRow(
                    icon: Icons.calendar_today,
                    label: 'Idade',
                    value: '28 anos',
                  ),
                  ProfileInfoRow(
                    icon: Icons.location_on,
                    label: 'Endereço',
                    value: 'Rua São Paulo, 123',
                  ),
                  ProfileInfoRow(
                    icon: Icons.perm_identity,
                    label: 'CPF',
                    value: '123.456.789-10',
                  ),
                  ProfileInfoRow(
                    icon: Icons.male,
                    label: 'Sexo',
                    value: 'Masculino',
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text('Editar Perfil'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(216, 79, 15, 0.765),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: const Color.fromRGBO(255, 152, 0, 1)),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
