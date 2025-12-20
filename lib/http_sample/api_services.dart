import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:providerproject/http_sample/provider_file/user_model.dart';
class ApiServices{
final String _baseUrl = 'https://dummyjson.com'; // Example API

// View Model jaha api call hugi
Future<Map<String,dynamic>> fetchUsers() async{
try{

 final response=await http.get(Uri.parse('$_baseUrl/users'));
 // print('RESPONSE GET ${jsonDecode(response.body)['users']}');
 // we getting list dynamic data but for model we have to convert that lis<dynamic> to List<UserModel>
 List<dynamic> user_list_dynamic =jsonDecode(response.body)['users'];
 // [{
 //  id:1,
 //  fname:'aqsa',
 //  lname:'lhan'
 // }]
 List<UserModel> data = user_list_dynamic.map((json) => UserModel.fromJson(json)).toList();
 return {'user_list':data,'success':true};
}
    catch(e){
     List<UserModel> data=[];
     return {'user_list':data,'success':false};


    }
 


}

  Future<List<dynamic>> fetchPaginationUsers(int page, {int limit = 20}) async {
  print('page is ${page} limit ${limit}');
    int skip = (page - 1) * limit;

    final url = Uri.parse(
        "https://dummyjson.com/users?limit=$limit&skip=$skip");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["users"]; // returns list of users
    } else {
      throw Exception("Failed to load users");
    }
  }

  Future<Map<String,dynamic>> updateData(int id,String newName) async{
   final response= await http.put(
      Uri.parse("https://dummyjson.com/users/$id"),
      body: jsonEncode({"firstName": newName}),
      headers: {"Content-Type": "application/json"},
    );
   return jsonDecode(response.body);

  }
}