

import 'package:dio/dio.dart';
import 'package:providerproject/network/interceptor/logging_interceptor.dart';
import 'package:providerproject/network/response/user_response.dart';
// import 'package:retrofit/error_logger.dart';
// import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
part 'network_service.g.dart';

@RestApi(baseUrl: "https://dummyjson.com/") // Enter Your API Base URL
abstract class ApiService {
  factory ApiService(Dio dio, baseUrl) {
    dio.options = BaseOptions(
        receiveTimeout: Duration(minutes: 5),
        connectTimeout: Duration(minutes: 5),
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        /* If needed headers */
        // headers: {
        //   'Content-Type': 'application/json',
        //
        //   'Authorization': 'Basic RVhFSWRlYXMgSW50ZXJuYXRpb25hbCB3d3cuZXhlaWRlYXMubmV0'
        // }
    );


    dio.interceptors.add(AppLoggingInterceptor());
    return _ApiService(dio, baseUrl: "https://dummyjson.com/");
  }

  @GET("/users")
  Future<UserResponse> getUsers();
  @GET("/users")
  Future<UserResponse> getUsersParams(@Query("limit") int param1,@Query("skip") int param2);



}
