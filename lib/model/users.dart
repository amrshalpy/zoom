class Users {
  String? email;
  String? name;
  String? id;
  Users({this.email, this.id, this.name});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'email': email,
    };
  }
}
