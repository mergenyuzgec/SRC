import 'dart:convert';

import 'package:http/http.dart' as http;

class InstagramService {
  final String _baseUrl = 'https://graph.instagram.com';
  final String _accessToken = 'YOUR_INSTAGRAM_ACCESS_TOKEN';

  Future<List<dynamic>> fetchInstagramPosts(String userId) async {
    final url = '$_baseUrl/$userId/media?fields=id,caption,media_url&access_token=$_accessToken';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load Instagram posts');
    }
  }
}
