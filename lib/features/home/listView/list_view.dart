import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/features/home/listView/controller.dart';

class ListViewScreen extends StatelessWidget {
  const ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final ListViewController dataController = Get.put(ListViewController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Integration'),
      ),
      body: Obx(() {
        if (dataController.posts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () => dataController.fetchPosts(),
            child: ListView.builder(
              itemCount: dataController.posts.length,
              itemBuilder: (context, index) {
                final post = dataController.posts[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }
}