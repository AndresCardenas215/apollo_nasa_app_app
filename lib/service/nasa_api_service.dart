import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/apolo_model.dart';


class NasaService {
  static const String apiUrl =
      "http://images-api.nasa.gov/search?q=apollo%2011";

  Future<List<NasaItem>> getNasaItems() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['collection']['items'];

      return items.map((item) => NasaItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
