import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/model/articlemod.dart';

class NetworkService {
  Future<List<ArticleModel>> fetchHeadlinesApi() async {
    print("ENTER URL");
    String url =
        'https://newsapi.org/v2/everything?q=bitcoin&apiKey=c6bab6ed7a8b4a609abf5c00314fce39';

    try {
      final resp = await http.get(Uri.parse(url));
      print("Response status: ${resp.statusCode}");
      if (resp.statusCode == 200) {
        final body = jsonDecode(resp.body);
        print("Response body: $body");

        ArticleModel articleModel = ArticleModel.fromJson(body);
        return [articleModel];
      } else {
        print("Failed to load headlines. Status code: ${resp.statusCode}");
        throw Exception("Failed to load headlines");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("Failed to load headlines: $e");
    }
  }
}
