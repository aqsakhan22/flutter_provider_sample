import 'package:flutter/material.dart';
import 'package:providerproject/network/api/user_service.dart' show UserService;
class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  final service=UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: service.fetchUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          final users = snapshot.data!.users;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, index) {
              final user = users[index];
              return ListTile(
                title: Text("${user.fname} ${user.lname}"),
                subtitle: Text(user.email),
              );
            },
          );
        },
      ),
    );
  }
}
