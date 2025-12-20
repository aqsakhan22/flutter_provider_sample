import 'package:flutter/material.dart';
import 'package:providerproject/http_sample/api_services.dart';


class DummyJsonPagination extends StatefulWidget {
  @override
  _DummyJsonPaginationState createState() => _DummyJsonPaginationState();
}

class _DummyJsonPaginationState extends State<DummyJsonPagination> {
  final ScrollController _controller = ScrollController();
   final ApiServices apiServices=ApiServices();
  List<dynamic> users = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    loadMore();

    _controller.addListener(() {
      if (_controller.position.pixels ==
          _controller.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;

    setState(() => isLoading = true );

    try {
      final newUsers = await apiServices.fetchPaginationUsers(page);

      if (newUsers.isEmpty) {
        hasMore = false;
      } else {
        page++;
        users.addAll(newUsers);
      }
    } catch (e) {
      print("ERROR: $e");
    }

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DummyJSON Pagination")),

      body: ListView.builder(
        controller: _controller,
        itemCount: users.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {

          if (index == users.length) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final user = users[index];

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user["image"]),
            ),
            title: Text("${user["firstName"]} ${user["lastName"]}"),
            subtitle: Text("Email: ${user["email"]}"),
          );
        },
      ),
    );
  }
}
// limit=20 → fetch 20 users at a time
//
// skip=(page-1)*20 → moves pagination offset
//
// API gives list in "users" key
//
// When scrolling hits bottom → loadMore()
//
// hasMore stops calling API when no more users
//
// Smooth & optimized for large data