import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favoriteItemIds = [];

  List<String> get favoriteItemIds => _favoriteItemIds;

  bool toggleFavorite(String itemId) {
    if (_favoriteItemIds.contains(itemId)) {
      _favoriteItemIds.remove(itemId);
      notifyListeners();
      return false; // Item removed from favorites
    } else {
      _favoriteItemIds.add(itemId);
      notifyListeners();
      return true; // Item added to favorites
    }
  }
}
