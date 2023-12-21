import 'package:flutter/foundation.dart';

class RatingProvider with ChangeNotifier {
  Map<String, double> _ratings = {};

  double getRating(String itemId) {
    return _ratings[itemId] ?? 0.0;
  }

  void setRating(String itemId, double value) {
    _ratings[itemId] = value;
    notifyListeners();
  }
}
