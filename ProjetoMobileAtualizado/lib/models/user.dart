class User {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String? confirmPassword; // Confirm password é opcional, pois é usado apenas no cadastro

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.confirmPassword, // No cadastro, confirmPassword é necessário, mas no login é nulo.
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      confirmPassword: json['confirmPassword'], // Optional campo de confirmação
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };

    // Inclui o campo confirmPassword apenas no cadastro
    if (confirmPassword != null) {
      data['confirmPassword'] = confirmPassword;
    }

    return data;
  }
}
