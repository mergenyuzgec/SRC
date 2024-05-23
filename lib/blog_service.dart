import 'dart:convert';

import 'package:http/http.dart' as http;

class BlogService {
  final String _baseUrl = 'https://your-blog-api.com';

  Future<List<dynamic>> fetchBlogPosts() async {
    final url = '$_baseUrl/posts';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load blog posts');
    }
  }
}
