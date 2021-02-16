import 'package:http/http.dart' as http;

import './parser.dart';

class NetworkHelper {
  Future<Parser> getData(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final data = parserFromJson(response.body);
      return data;
    }
    return null;
  }
}
