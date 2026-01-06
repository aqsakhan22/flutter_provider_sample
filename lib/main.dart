import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:providerproject/pagination_demo.dart';
// import 'package:providerproject/user_view.dart';
import 'package:providerproject/http_sample/provider_file/user_provider.dart';
// import 'package:providerproject/user_view_pagination.dart';
// import 'package:providerproject/http_sample/screens/user_view_stful.dart';
import 'package:providerproject/screens/dio_example/provider/user_dio_provider.dart';
import 'package:providerproject/screens/dio_example/screens/user_dio_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => UserDio()..fetchUsers())
      
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:UserScreen()
        //UserViewStful()
        //UsersScreen()
        //UserViewStful()
        //DummyJsonPagination()
        //UserViewStful()
    ),
    
    );
  }
}


