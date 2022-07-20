import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/providers/favorite_food.dart';
import 'package:tugasakhir_app/styles.dart';

class TampilDataMakanan extends StatelessWidget {
  const TampilDataMakanan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderFavoriteFood providerFavoriteFood =
        Provider.of<ProviderFavoriteFood>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Consumer<ProviderFavoriteFood>(
              builder: (context, providerlistState, _) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: providerlistState.favoriteFood.length,
                  itemBuilder: (context, index) {
                    var favoriteList = providerlistState.favoriteFood;

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(favoriteList[index].tempMakanan!),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                              "100 gram (g) - " +
                                  "${favoriteList[index].tempKaloriPerGram}" +
                                  " kkal",
                              style: Styles.soraMakananText2,
                            ),
                            IconButton(
                                onPressed: () {
                                  providerFavoriteFood.removeFromList(index);
                                },
                                icon: const Icon(Icons.delete)),
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.9),
            child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff45625d)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF4FCAB4)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
                onPressed: () => {},
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Isi piring saya sudah lengkap!",
                    style: Styles.bodyQuestion1,
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: Text('${providerFavoriteFood.totalKalori()}'))
        ],
      ),
    );
  }
}
