import 'package:flutter/material.dart';
import 'package:providerproject/http_sample/api_services.dart';
import 'package:providerproject/http_sample/provider_file/user_model.dart';

class UserProvider extends ChangeNotifier{
  final ApiServices apiServices=ApiServices();
   List<UserModel> user=[];
  bool isLoading = false;


  Future<void> getUserData() async {
    isLoading = true;
    notifyListeners();
    await apiServices.fetchUsers().then((e){
      user=e['user_list'];
      isLoading=false;

    });
notifyListeners();

    //user=await apiServices.fetchUsers()

  }
// 🔹 Update One User (Locally + API Example) without API
Future<void> updateLocally(int id,String fname,UserModel users) async{
// 1. Update locally
  final index = user.indexWhere((u) => u.id == id );
  if (index == -1) return;
  // final index1=user.indexOf(users);
  // print('${index1}')
  user[index].fname = fname; // remove final keyword from fname user model data
  notifyListeners(); // only notifies listeners, selector will optimize

}

Future<void> updateUsingApi(int id,String fname,UserModel users) async{
// 1. Update using API

   Map<String,dynamic> jsonData=await apiServices.updateData(id, fname);


   // Convert json to model
   final updatedUser = UserModel.fromJson(jsonData);
   // 🔹 2. Update Local List
   final index = user.indexWhere((u) => u.id == id);
   if (index != -1) {
     user[index] = updatedUser;     // replace old with new
   }
   //print('JSON DATA UPDATED ${jsonData['id']} ${jsonData['firstName']} ${jsonData['lastName']} ${jsonData['image']} ');
// 🔹 3. Notify Listeners
    notifyListeners();



  }


// Getter for single user
  UserModel getUserById(int id) {
     // print('getUserById ${id}');
    return user.firstWhere((u) => u.id == id);
  }


}