class User2 {
  final String name;
  final String email;

  User2({required this.name, required this.email});

  factory User2.fromJson(Map<String, dynamic> json) {
    return User2(
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
