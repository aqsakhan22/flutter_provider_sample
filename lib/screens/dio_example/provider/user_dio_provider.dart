

import 'package:flutter/foundation.dart';
import 'package:providerproject/network/api/app_url.dart';
import 'package:providerproject/network/api/network_service.dart';
import 'package:dio/dio.dart' as dio;
import '../../../network/response/user_model.dart' show UserModel;

class UserDio extends ChangeNotifier {
  final ApiService apiServices=ApiService(dio.Dio(),AppUrl.baseUrl);
  List<UserModel> users=[];
  bool isLoading=false;

  // pagination implement
  int _skip = 0;
  final int _limit = 10;
  bool hasMore = true;

  Future<void> fetchUsers() async{

    // if loading is true and we have not data it will return like if hasmore = true , !hasmore=false
    if (isLoading || !hasMore) return;
    isLoading = true;
    notifyListeners();
    final newUsers = await apiServices.getUsersParams(_limit,_skip);
    users.addAll(newUsers.users);
    print('skip is ${_skip} limit is ${_limit} ${newUsers.users.length}');
    _skip += _limit;

    if (newUsers.users.length < _limit) {
      hasMore = false;
    }

    isLoading = false;
    notifyListeners();

  }

  Future<void> getUsers() async{
    try{
      isLoading=true;
      notifyListeners();
        final response= await apiServices.getUsers();
        // print('RESPONSE of dio is ${response.users}');

        users=response.users;


      isLoading=false;
      notifyListeners();


    }
        catch(e){

          print('CATCH ERROR ${e}');
        }
  }

  Future<void> getUserswithparams(int limit,int skip) async{

    try{
      isLoading=true;
      notifyListeners();
      final response= await apiServices.getUsersParams(limit,skip);


      users=response.users;

      print('RESPONSE of getUserswithparams is ${response.users.length} ${users.length}');
      isLoading=false;
      notifyListeners();


    }
    catch(e){

      print('CATCH ERROR ${e}');
    }
  }
  
  
  
  
}