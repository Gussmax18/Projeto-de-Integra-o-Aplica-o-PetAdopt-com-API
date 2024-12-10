class Pet {
  final String id;
  final String name;
  final String age;
  final String color;
  final List<String> images;
  final String sex;
  final double weight; // Novo campo 'peso'

  Pet({
    required this.id,
    required this.name,
    required this.age,
    required this.color,
    required this.images,
    required this.sex,
    required this.weight, // Adicionando peso no construtor
  });

  // Função para converter o objeto Pet em um mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'color': color,
      'images': images,
      'sex': sex,
      'weight': weight, // Incluindo o peso no JSON
    };
  }

  // Função para converter um JSON em um objeto Pet
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] ?? '',
      name: json['name'],
      age: json['age'],
      color: json['color'],
      images: List<String>.from(json['images'] ?? []),
      sex: json['sex'],
      weight: json['weight']?.toDouble() ?? 0.0, // Convertendo o peso
    );
  }
}
