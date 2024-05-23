import 'dart:convert';

import 'package:http/http.dart' as http;

class TwitterService {
  final String _baseUrl = 'https://api.twitter.com/2/tweets/search/recent';
  final String _apiKey = 'YOUR_TWITTER_API_KEY';

  Future<List<dynamic>> fetchTweets(String query) async {
    final url = '$_baseUrl?query=$query';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $_apiKey',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['data'];
    } else {
      throw Exception('Failed to load tweets');
    }
  }
}
