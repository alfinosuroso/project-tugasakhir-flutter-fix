
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
  void initState() {
    super.initState();
    selectedRadioTile = 0;
  }

  setSelectedRadioTile(int? val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  Future<void> sendCalorieValue() async {
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    // localStorage.setString('makanan', ['data']['name']);
  }

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
                  var data = snapshot.data;
                  return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Card(
                            child: ListTile(
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
                          // When a user taps the ListTile, navigate to the DetailScreen.
                          // Notice that you're not only creating a DetailScreen, you're
                          // also passing the current todo through to it.
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Hitung Kalori ${data?[index].makanan}'),
                                      content: Text(
                                          'Ingin menghitung kalori ${data?[index].makanan} sekarang?'),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: const Text('TIDAK')),
                                        TextButton(
                                            onPressed: () => Navigator.pushReplacement(
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
                                            child: const Text('YA')),
                                      ],
                                    ));
                          },
                        )
                            // RadioListTile<int?>(
                            //   controlAffinity: ListTileControlAffinity.trailing,
                            //   value: data?[index].kaloriPerGram,
                            //   groupValue: selectedRadioTile,
                            // title: Text(
                            //   "${data?[index].makanan}",
                            //   style: Styles.soraMakananText1,
                            // ),
                            // subtitle: Text(
                            //   "100 gram (g) - " +
                            //       "${data?[index].kaloriPerGram}" +
                            //       " kkal",
                            //   style: Styles.soraMakananText2,
                            // ),
                            //   onChanged: (val) {
                            //     print("Radio Tile pressed $val");
                            //     setSelectedRadioTile(val);
                            //   },
                            //   activeColor: Styles.mainBlueColor,
                            //   selected: false,
                            // ),
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
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
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
        ),
      ),
    );
  }
}
