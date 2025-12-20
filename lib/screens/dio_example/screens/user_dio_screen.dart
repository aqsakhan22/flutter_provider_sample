// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerproject/http_sample/provider_file/user_model.dart';
import 'package:providerproject/screens/dio_example/provider/user_dio_provider.dart';
class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      // Provider.of<UserDio>(context,listen: false).getUsers();
      // Provider.of<UserDio>(context,listen: false).getUserswithparams(2,0);
      // Provider.of<UserDio>(context,listen: false).fetchUsers();
      final provider = context.read<UserDio>();
      _scrollController.addListener(() {

        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
            !provider.isLoading &&
            provider.hasMore) {
          provider.fetchUsers();
        }
      });


    });

  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Pagination')),
      body: Consumer<UserDio>(
        builder: (context, provider, child) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: provider.users.length +
                (provider.hasMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < provider.users.length) {
                final user = provider.users[index];
                return Column(
                                  children: [
                                    Text('${user.fname}'),
                                    Text('${user.lname}'),
                                    Text('${user.email}'),
                                    Image.network('${user.image}')
                                    // CachedNetworkImage(imageUrl: '${user.image}')

                                  ],
                                );
              } else {
                return Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }


}

// @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text("API sample with DIO"),
  //     ),
  //     body:Consumer<UserDio>(
  //         builder: (context,userprovider,child){
  //
  //           if(userprovider.isLoading){
  //             return const Center(child: CircularProgressIndicator(color: Colors.blue,),);
  //           }
  //
  //          // return ElevatedButton(onPressed: (){
  //          //   Provider.of<UserDio>(context,listen: false).getUserswithparams(2);
  //          //
  //          // }, child: Text('ONcLICK'));
  //
  //           return  ListView.builder(
  //               itemCount: userprovider.users.length,
  //               itemBuilder: (context,int index){
  //                 final user=userprovider.users[index];
  //
  //             return  Column(
  //               children: [
  //                 Text('${user.fname}'),
  //                 Text('${user.lname}'),
  //                 Text('${user.email}'),
  //                 Image.network('${user.image}')
  //                 // CachedNetworkImage(imageUrl: '${user.image}')
  //
  //               ],
  //             );
  //           });
  //         })
  //   );
  // }

