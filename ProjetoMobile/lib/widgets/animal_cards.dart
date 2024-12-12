import 'package:flutter/material.dart';
import 'package:projeto_mobile/models/animal.dart'; // Modelo Pet

class AnimalCard extends StatelessWidget {
  final String name;
  final String breed;
  final String imageUrl;

const AnimalCard({
    Key? key,
    required this.name,
    required this.breed,
    required this.imageUrl 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey, blurRadius: 4.0, offset: Offset(0.9, 2)),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      width: 170,
      height: 200,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xffD7F4DD),
            ),
            height: 130,
            width: 190,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        breed,
                        style: const TextStyle(
                          color: Color(0xff909090),
                          fontSize: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(135, 248, 186, 29),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  "Male",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 216, 155, 0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(255, 255, 168, 159),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  "Adult",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 252, 52, 30),
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





