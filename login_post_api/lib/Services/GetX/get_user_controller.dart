import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_post_api/Services/Model/user_model.dart';

class GetUserController extends GetxController {
  var user = <UserModelModel>[].obs;

  Future<void> getUser() async {
    try {
      final response = await http.get(Uri.parse('https://api.escuelajs.co/api/v1/users'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List;
        user.value = data.map((e) => UserModelModel.fromMap(e)).toList();
      } else {
        throw Exception('Faile to load data');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  
}