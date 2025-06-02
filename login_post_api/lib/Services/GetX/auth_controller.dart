import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:login_post_api/Services/Model/user_model.dart';

// https://fakeapi.platzi.com/en/rest/auth-jwt/

class AuthController extends GetxController {
  final box = GetStorage();
  var user = Rxn<UserModelModel>();
  String? _token;

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
        headers: {'Content-Type': 'application/json'},
        // 'Content-Type': This header tells the server what kind of data you are sending in the body of the HTTP request.

        // 'application/json': This value specifies that the data you’re sending is in JSON (JavaScript Object Notation) format.
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data["access_token"];

        // Now fetch user profile using token
        return await getUserProfile();
      } else {
        print('Login failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  Future<bool> getUserProfile() async {
  try {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
      headers: {'Authorization': 'Bearer $_token'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final userModel = UserModelModel.fromMap(data);
      user.value = userModel;
      box.write('user', userModel.toMap());
      return true;
    } else {
      print('Profile fetch failed: ${response.body}');
      return false;
    }
  } catch (e) {
    print('Error fetching profile: $e');
    return false;
  }
}

}
