

class AuthModel {
    final String email;
    final String password;

    AuthModel({
        required this.email,
        required this.password,
    });

    factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
    };
}

/**
 POST https://api.escuelajs.co/api/v1/auth/login
Content-Type: application/json

{
  "email": "john@mail.com",
  "password": "changeme"
}
 */