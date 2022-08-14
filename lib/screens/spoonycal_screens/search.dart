import 'package:flutter/material.dart';
import 'package:tugasakhir_app/screens/spoonycal_screens/count_calorie.dart';
import 'package:tugasakhir_app/services/api_makanan_service.dart';
import 'package:tugasakhir_app/styles.dart';

import '../../model/makanan_model.dart';
import '../../services/api_makanan_service.dart';

class SearchMakanan extends SearchDelegate {
  final FetchDatumMakananList _makananList = FetchDatumMakananList();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            Navigator.pop(context); // pop current page
            showSearch(context: context, delegate: SearchMakanan());
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Stack(
        children: [
          FutureBuilder<List<DatumMakananList>>(
              future: _makananList.getDatumMakananList(query: query),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<DatumMakananList>? data = snapshot.data;
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
                                              style:
                                                  Styles.outfitDialogYaText6)),
                                    ],
                                  ));
                        },
                      ));
                    });
              }),
        ],
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text('Cari Makanan'),
    );
  }
}
