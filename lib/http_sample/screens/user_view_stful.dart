import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerproject/http_sample/provider_file/user_model.dart';
import 'package:providerproject/http_sample/provider_file/user_provider.dart';
class UserViewStful extends StatefulWidget {
  const UserViewStful({super.key});

  @override
  State<UserViewStful> createState() => _UserViewStfulState();
}

class _UserViewStfulState extends State<UserViewStful> {
  // Create HomeScreen class extending StatefulWidget (Since I want to trigger the api call inside initState()) and in initState() call the provider as follows.
  //
  // Provider.of<DataProvider>(context, listen: false).getData(context);

  //You can only write above code with listen: false if you are writing it inside initState(). By setting listen: false you tell not to rebuild the widget upon data changes happen inside the provider. But inside build method we write,
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      Provider.of<UserProvider>(context, listen: false).getUserData();
    });

  }
  @override
  Widget build(BuildContext context) {
    // final getUser = Provider.of<UserProvider>(context);
    return   Scaffold(
        appBar: AppBar(
          title: Text('USER VIEW'),
        ),
        body:
       Consumer<UserProvider>(builder: (context,userprovider,child){
         if(userprovider.isLoading == true){

           return Center(child: CircularProgressIndicator(color: Colors.blue,),);
         }



         return
           ListView.builder(
             itemCount: userprovider.user.length,
             itemBuilder: (context,int index){
               // final user=userprovider.user[index];
               final id = userprovider.user[index].id;
               return
             Selector<UserProvider,UserModel>(
               selector: (_, p) => p.getUserById(id),
               builder: (context,userModel,child){
                 return   Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       Container(
                         padding: EdgeInsets.all(10),
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20.0),
                             color: Colors.blue,
                           ),

                           child: Text("${userModel.fname} ${userModel.lname}",
                             textAlign: TextAlign.center,
                             style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),)),
                       Image.network("${userModel.image}",
                         fit: BoxFit.cover,
                       ),
                       ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Colors.blue,
                             foregroundColor: Colors.white
                           ),
                           onPressed: (){
                         Provider.of<UserProvider>(context, listen: false)
                             .updateLocally(userModel.id, "Updated Locally",userModel);
                       }, child: Text('Updated')),

                       // ElevatedButton(onPressed: (){
                       //   Provider.of<UserProvider>(context, listen: false)
                       //       .updateUsingApi(userModel.id, "aqsa khan",userModel);
                       // }, child: Text('Updated Api'))
                     ],
                   ),
                 );
               },

             );


             });
       },)

    );
  }
}
