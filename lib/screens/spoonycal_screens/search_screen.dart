import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/model/makanan_model.dart';
import 'package:tugasakhir_app/screens/spoonycal_screens/count_calorie.dart';
import 'package:tugasakhir_app/screens/spoonycal_screens/search.dart';
import 'package:tugasakhir_app/services/api_makanan_service.dart';
import 'package:tugasakhir_app/styles.dart';

int? selectedRadioTile;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FetchDatumMakananList _makananList = FetchDatumMakananList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Styles.appBarPrimaryColor,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.xmark, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: false,
        title: const Text(
          'Pilih makanan anda',
          style: Styles.shareTitleAppbarText13,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchMakanan());
            },
            icon: Icon(Icons.search_sharp),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            FutureBuilder<List<DatumMakananList>>(
                future: _makananList.getDatumMakananList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  var data = snapshot.data;
                  return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          title: Text(
                            " ${data?[index].makanan}",
                            style: Styles.soraMakananText1,
                          ),
                          subtitle: Text(
                            "100 gram (g) - " +
                                "${data?[index].kaloriPerGram}" +
                                " kal",
                            style: Styles.soraMakananText2,
                          ),
                          // When a user taps the ListTile, navigate to the DetailScreen.
                          // Notice that you're not only creating a DetailScreen, you're
                          // also passing the current todo through to it.
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      title: Text(
                                        'Hitung Kalori ${data?[index].makanan}',
                                        style: Styles.outfitDialogText3,
                                      ),
                                      content: Text(
                                        'Ingin menghitung kalori ${data?[index].makanan} sekarang?',
                                        style: Styles.outfitDialogText4,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text(
                                              'TIDAK',
                                              style:
                                                  Styles.outfitDialogTidakText5,
                                            )),
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CountCalorie(
                                                      finalMakanan:
                                                          "${data?[index].makanan}",
                                                      finalKaloriPerGram:
                                                          data?[index]
                                                              .kaloriPerGram,
                                                    ),
                                                  ),
                                                ),
                                            child: const Text('YA',
                                                style: Styles
                                                    .outfitDialogYaText6)),
                                      ],
                                    ));
                          },
                        ));
                      });
                }),
          ],
        ),
      ),
    );
  }
}
