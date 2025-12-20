import 'dart:convert';

import 'package:providerproject/network/response/user_response.dart';
import 'package:http/http.dart' as http;
class UserService{

  Future<UserResponse> fetchUsers() async{
    
    final response= await http.get(Uri.parse('https://dummyjson.com/users'));
    if(response.statusCode == 200){
      final jsonData=jsonDecode(response.body);
      return UserResponse.fromJson(jsonData);

    }
    else {
      throw Exception("Failed to load users");
    }
  }
}