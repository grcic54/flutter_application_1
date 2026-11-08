import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modeli/igre.dart';

class IgreUsluga {
  const IgreUsluga();

  static final _feed = Uri.parse(
    'https://www.freetogame.com/api/games?platform=pc',
  );

  Future<List<Igre>> fetchIgre() async {
    final response = await http.get(_feed).timeout(const Duration(seconds: 10));

    if (response.statusCode != 200) {
      throw Exception('Baza je vratila status ${response.statusCode}');
    }

    final json = jsonDecode(response.body) as List<dynamic>;

    return json
        .map((game) => Igre.fromJson(game as Map<String, dynamic>))
        .toList();
  }
}
