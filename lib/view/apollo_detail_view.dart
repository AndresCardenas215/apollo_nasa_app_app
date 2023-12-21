import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../models/apolo_model.dart';
import '../viewModel/apollo_detail_view_model.dart';
import '../viewModel/we.model.dart';

class NasaDetailScreen extends StatefulWidget {
  final NasaItem item;
  final Function(double) onStarRatingChanged;

  NasaDetailScreen({required this.item, required this.onStarRatingChanged});

  @override
  State<NasaDetailScreen> createState() => _NasaDetailScreenState();
}

class _NasaDetailScreenState extends State<NasaDetailScreen> {


  @override
  Widget build(BuildContext context) {
    var ratingProvider = Provider.of<RatingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nasa Detail'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: widget.item.imageUrl.isNotEmpty ? widget.item.imageUrl : "",
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) {
                  print("Error al cargar la imagen: $error");
                  return const Icon(Icons.error);
                },
              ),
            ),
          ),
          Text(
            widget.item.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Rate:',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(width: 8.0),
              StarRating(
                rating: ratingProvider.getRating(widget.item.id),
                onRatingChanged: (double value) {
                  ratingProvider.setRating(widget.item.id, value);
                },
              ),

            ],
          ),
        ],
      ),
    );
  }
}
