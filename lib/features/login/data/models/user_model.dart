class UserModel {
  final String name;
  final String email;
  final String photoURL;

  UserModel({
    required this.name,
    required this.email,
    this.photoURL = '',
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'photo_url': photoURL,
      };
}
