import 'package:dio/dio.dart' as dio;
import 'package:providerproject/network/api/network_service.dart';

class AppUrl{
  static final baseUrl='https://dummyjson.com/';
  static  ApiService networkService=ApiService(dio.Dio(),baseUrl);

}