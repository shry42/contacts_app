class Contact {
  String id;
  String name;
  String phone;
  String email;
  bool isFavorite;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    this.email = '',
    this.isFavorite = false,
  });

  factory Contact.fromMap(Map<String, dynamic> data) {
    return Contact(
      id: data['id'],
      name: data['name'],
      phone: data['phone'],
      email: data['email'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'isFavorite': isFavorite,
    };
  }
}
