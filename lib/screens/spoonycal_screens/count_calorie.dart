import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/model/favorite_food.dart';
import 'package:tugasakhir_app/providers/favorite_food.dart';
import 'package:tugasakhir_app/styles.dart';

class CountCalorie extends StatelessWidget {
  final String? finalMakanan;
  final int? finalKaloriPerGram;

  const CountCalorie({
    Key? key,
    @required this.finalMakanan,
    @required this.finalKaloriPerGram,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderFavoriteFood providerFavoriteFood =
        Provider.of<ProviderFavoriteFood>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * 30),
          child: AlertDialog(
            backgroundColor: Styles.askAccColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, color: Styles.primaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Hurray :)', style: Styles.bodyQuestion1),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Item added successfully',
                    style: Styles.bodyQuestion1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Styles.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('View My Cart', style: Styles.bodyQuestion1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('$finalMakanan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('$finalKaloriPerGram'.toString()),
            TextButton(
                onPressed: () {
                  providerFavoriteFood.addCart(
                      makan: finalMakanan, kalori: finalKaloriPerGram);
                  showSuccessDialog();
                  // Navigator.pop(context);
                },
                child: const Text('HITUNG')),
            TextButton(
                onPressed: () {
                  providerFavoriteFood.clearList();
                  showSuccessDialog();
                  // Navigator.pop(context);
                },
                child: const Text('HAPUS')),
            TextButton(
                onPressed: () {
                  print(providerFavoriteFood.favoriteFood);
                  Navigator.pushNamed(context, '/tampil_data');
                },
                child: const Text('TAMPILKAN')),
          ],
        ),
      ),
    );
  }
}
