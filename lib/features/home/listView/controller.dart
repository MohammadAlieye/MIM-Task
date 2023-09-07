import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task/core/models/post.dart';


class ListViewController extends GetxController {
  final posts = <Post>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final postsList = data.map((json) => Post(
        id: json['id'],
        title: json['title'],
        body: json['body'],
      )).toList();

      posts.assignAll(postsList);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
