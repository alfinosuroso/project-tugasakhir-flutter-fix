import 'package:flutter/material.dart';
import 'package:tugasakhir_app/services/api_makanan_service.dart';
import 'package:tugasakhir_app/styles.dart';

import '../../model/makanan_model.dart';
import '../../services/api_makanan_service.dart';

class SearchMakanan extends SearchDelegate {
  final FetchDatumMakananList _makananList = FetchDatumMakananList();
  int? selectedRadioTile = 0;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
            Navigator.pop(context); // pop current page
            showSearch(context: context, delegate: SearchMakanan());
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
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
                  return Center(child: CircularProgressIndicator());
                }
                List<DatumMakananList>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: RadioListTile<int?>(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: data?[index].kaloriPerGram,
                          groupValue: selectedRadioTile,
                          title: Text(
                            "${data?[index].makanan}",
                            style: Styles.soraMakananText1,
                          ),
                          subtitle: Text(
                            "100 gram (g) - " +
                                "${data?[index].kaloriPerGram}" +
                                " kkal",
                            style: Styles.soraMakananText2,
                          ),
                          onChanged: (val) {
                            print("Radio Tile pressed $val");
                            setState(() {
                              selectedRadioTile = val;
                            });
                          },
                          activeColor: Styles.mainBlueColor,
                          selected: false,
                        ),
                      );
                    });
              }),
          selectedRadioTile == 0
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment(0.0, 0.9),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff45625d)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF498FB1)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))),
                      onPressed: () =>
                          Navigator.pushNamed(context, '/search_screen'),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Hitung kalori sekarang",
                          style: Styles.bodyQuestion1,
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
        ],
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Cari Makanan'),
    );
  }
}
