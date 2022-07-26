import 'package:flutter/cupertino.dart';
import 'package:tugasakhir_app/model/favorite_food.dart';

class ProviderFavoriteFood extends ChangeNotifier {
  List<FavoriteFoodCalorie> favoriteFood = [];
  

  void removeFromList(int index) {
    favoriteFood.removeAt(index);
    notifyListeners();
  }

  void clearList() {
    favoriteFood.clear();
    notifyListeners();
  }

  void addCart({String? makan, int? kalori, int? berat}) {
    favoriteFood.add(FavoriteFoodCalorie(
      tempMakanan: makan,
      tempKaloriPerGram: kalori,
      tempBerat: berat
    ));

    notifyListeners();
  }

  double totalKalori() {
    double total = 0;
    for (var item in favoriteFood) {
      total += item.tempKaloriPerGram!;
    }

    return total;
  }
}
