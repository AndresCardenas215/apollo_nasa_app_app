
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/apolo_model.dart';

class NasaSearchDelegate extends SearchDelegate<String> {
  final List<NasaItem> _items;
  final Function(String) _filterList;

  NasaSearchDelegate(this._items, this._filterList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          _filterList('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    _filterList(query);
    return NasaSearchResults(items: _items, query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return NasaSearchResults(items: _items, query: query);
  }
}

class NasaSearchResults extends StatelessWidget {
  final List<NasaItem> items;
  final String query;

  NasaSearchResults({required this.items, required this.query});

  @override
  Widget build(BuildContext context) {
    final filteredItems = items
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return ListTile(
          title: Text(item.title),
          leading: ClipOval(
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
