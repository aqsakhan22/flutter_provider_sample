import 'package:flutter/material.dart';
class PaginationDemo extends StatefulWidget {
  const PaginationDemo({super.key});

  @override
  State<PaginationDemo> createState() => _PaginationDemoState();
}

class _PaginationDemoState extends State<PaginationDemo> {
  final ScrollController _scrollController = ScrollController();
  List<String> items = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadMore();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }
  Future<List<String>> fetchItems(int page) async {
    await Future.delayed(Duration(seconds: 2)); // simulate API delay

    return List.generate(
      20,
          (index) => 'Item ${(page - 1) * 20 + index + 1}',
    );
  }
  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;

    setState(() => isLoading = true);

    final newItems = await fetchItems(page);

    if (newItems.isEmpty) {
      hasMore = false;
    } else {
      page++;
      items.addAll(newItems);
    }

    setState(() => isLoading = false);
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination Example")),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}

