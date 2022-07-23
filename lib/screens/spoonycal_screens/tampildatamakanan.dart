import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Styles.appBarPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        title: const Text(
          'Isi Piring Anda',
          style: Styles.shareTitleAppbarText13,
        ),
      ),
      body: Column(
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
                          title: Text(
                            favoriteList[index].tempMakanan!,
                            style: Styles.soraMakananText1,
                          ),
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                              "100 gram (g) - " +
                                  "${favoriteList[index].tempKaloriPerGram}" +
                                  " kal",
                              style: Styles.soraMakananText3,
                            ),
                            IconButton(
                                onPressed: () {
                                  providerFavoriteFood.removeFromList(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 206, 83, 81),
                                          content: Text(
                                              "Berhasil menghapus data!")));
                                },
                                icon: const Icon(FontAwesomeIcons.circleXmark,
                                    color: Styles.redMainColor)),
                          ]),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
              title: Text('Total Kalori', style: Styles.soraMakananText4,),
              trailing: Text('${providerFavoriteFood.totalKalori()} kal', style: Styles.soraMakananText5,),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.9),
            child: ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff45625d)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF54A5CC)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
                onPressed: () => {
                  
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Isi piring saya sudah lengkap!",
                    style: Styles.bodyQuestion1,
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
