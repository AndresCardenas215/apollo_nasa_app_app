class NasaItem {
  final String id;
  final String title;
  final String imageUrl;

  NasaItem({required this.id, required this.title, required this.imageUrl});

  factory NasaItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw const FormatException('Invalid JSON format for NasaItem');
    }

    if (json.containsKey('data') && json.containsKey('links')) {
      return NasaItem(
        id: json['data'][0]['nasa_id'] ?? 'NoId',
        title: json['data'][0]['title'] ?? 'No Title',
        imageUrl: json['links'][0]['href'] ?? '',
      );
    }

    if (json.containsKey('data')) {
      return NasaItem(
        id: json['data'][0]['nasa_id'] ?? 'NoId',
        title: json['data'][0]['title'] ?? 'No Title',
        imageUrl: '',
      );
    }

    print('Invalid JSON format for NasaItem: $json');
    throw const FormatException('Invalid JSON format for NasaItem');
  }
}
