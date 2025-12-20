import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerproject/http_sample/provider_file/user_provider.dart';
class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    final getUser = Provider.of<UserProvider>(context);

    return
      Scaffold(
      appBar: AppBar(
        title: Text('USER VIEW'),
      ),
      body: Column(
        children: [
          Text('${getUser.user.length}'),
          ElevatedButton(onPressed: (){
            getUser.getUserData();
          }, child: Text("getUser Data"))
        ],
      )

    );
  }

  Widget listViewWidget(){
    return  ListView.builder(
        itemCount: 5,
        itemBuilder: (context,int index){
          return ListTile(
            title: Text('hello'),
            trailing: Text(''),
          );

        });


  }
}
