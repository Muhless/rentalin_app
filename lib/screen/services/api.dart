import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rentalin_app/screen/services/post.dart';


class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Post.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}

}