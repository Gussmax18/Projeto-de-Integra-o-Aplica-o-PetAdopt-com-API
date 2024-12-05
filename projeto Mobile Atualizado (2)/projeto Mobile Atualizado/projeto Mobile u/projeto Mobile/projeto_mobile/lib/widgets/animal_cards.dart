import 'package:flutter/material.dart';

class AnimalCard extends StatelessWidget {
  final String id;
  final String name;
  final String age;
  final String color;
  final String imageUrl;
 
  const AnimalCard({
    Key? key,
    required this.id,
    required this.name,
    required this.age,
    required this.color,
    required this.imageUrl,
  }) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey, blurRadius: 4.0, offset: Offset(0.9, 2))
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
              color: Color(0xffD7F4DD),
            ),
            height: 130,
            width: 190,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
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
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(195, 19, 182, 127),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: Text(
                                  "Male",
                                  style: TextStyle(
                                    color: Color.fromARGB(195, 19, 182, 127),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(255, 187, 187, 187),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
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
 