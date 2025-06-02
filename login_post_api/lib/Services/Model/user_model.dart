
class UserModelModel {
    final int id;
    final String email;
    final String password;
    final String name;
    final String role;
    final String avatar;

    UserModelModel({
        required this.id,
        required this.email,
        required this.password,
        required this.name,
        required this.role,
        required this.avatar,
    });

    factory UserModelModel.fromMap(Map<String, dynamic> json) => UserModelModel(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
    };
}
