import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../viewModel/apollo_detail_view_model.dart';
import '../viewModel/apollo_list_view_model.dart';

import '../models/apolo_model.dart';
import '../service/nasa_api_service.dart';
import '../viewModel/we.model.dart';
import 'apollo_detail_view.dart';

class NasaListWidget extends StatefulWidget {
  final NasaItem? item;
  final Function(double)? onStarRatingChanged;

  NasaListWidget({ this.item, this.onStarRatingChanged});
  @override
  _NasaListWidgetState createState() => _NasaListWidgetState();
}

class _NasaListWidgetState extends State<NasaListWidget> {
  final NasaService _nasaService = NasaService();
  late List<NasaItem> _nasaItems;
  late List<NasaItem> _filteredItems;
  double valor = 0.0;
  String titulo = "";

  @override
  void initState() {
    super.initState();
    _nasaItems = [];
    _filteredItems = [];
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final items = await _nasaService.getNasaItems();
      setState(() {
        _nasaItems = items;
        _filteredItems = items;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _filterList(String query) {
    setState(() {
      _filteredItems = _nasaItems
          .where((item) =>
          item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _onStarRatingChanged(double rating, NasaItem item) {
    Provider.of<RatingProvider>(context, listen: false).setRating(item.id, rating);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NasaDetailScreen(
          item: item,
          onStarRatingChanged: (rating) => _onStarRatingChanged(rating, item),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NASA Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NasaSearchDelegate(_nasaItems, _filterList),
              );
            },
          ),
        ],
      ),
      body: Consumer<RatingProvider>(
        builder: (context, ratingProvider, child) {
          return _filteredItems.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: _filteredItems.length,
            itemBuilder: (context, index) {
              final item = _filteredItems[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(item.title),
                      leading: ClipOval(
                        child: GestureDetector(
                          onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NasaDetailScreen(
                                    item: item,
                                    onStarRatingChanged: (rating) =>
                                        _onStarRatingChanged(rating, item),
                                  ),
                                ),
                              );
                          },
                          child: CachedNetworkImage(
                            imageUrl: item.imageUrl,
                            placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    StarRating(
                      onRatingChanged: (rating) {
                        _onStarRatingChanged(rating, item);
                      },
                      rating: ratingProvider.getRating(item.id),
                    ),

                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }}