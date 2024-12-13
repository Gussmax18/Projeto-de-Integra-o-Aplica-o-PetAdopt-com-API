import 'package:flutter/material.dart';
import 'package:projeto_mobile/widgets/header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetalhesDoAnimal(),
    );
  }
}

class DetalhesDoAnimal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        elevation: 0.0,
        title: const Text(
          'Detalhes do animal',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color.fromARGB(195, 216, 79, 15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(location: 'Cotia (1 km)'),
            const SizedBox(height: 16),
            Container(
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/bido.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bidu 🐾',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Chip(
                  label: const Text('Resgatado'),
                  backgroundColor: Colors.orangeAccent,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.orangeAccent),
                const SizedBox(width: 4),
                const Text('ANJOS DA RUA'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Chip(label: const Text('5 Anos'), backgroundColor: Colors.orangeAccent[200]),
                Chip(label: const Text('Golden'), backgroundColor: Colors.orangeAccent[200]),
                Chip(label: const Text('Macho'), backgroundColor: Colors.blue[200]),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Blandit risus molestie diam, eu volutpat, tellus amet morbi. '
              'Mauris sed enim eget enim massa nulla rhoncus pellentesque. '
              'In a fames integer maecenas sed lectus quam.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print('Quero adotar o animal!');
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(195, 216, 79, 15),
                ),
                child: const Text(
                  'Quero adotar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
