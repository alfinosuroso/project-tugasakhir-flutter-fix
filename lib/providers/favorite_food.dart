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

  void addCart({String? makan, int? kalori}) {
    favoriteFood.add(FavoriteFoodCalorie(
      tempMakanan: makan,
      tempKaloriPerGram: kalori,
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
