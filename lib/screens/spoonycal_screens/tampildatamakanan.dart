import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/model/catatan_model.dart';
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
import 'package:tugasakhir_app/providers/favorite_food.dart';
import 'package:tugasakhir_app/services/api_catatan_service.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:http/http.dart' as http;

class TampilDataMakanan extends StatefulWidget {
  const TampilDataMakanan({Key? key}) : super(key: key);

  @override
  State<TampilDataMakanan> createState() => _TampilDataMakananState();
}

class _TampilDataMakananState extends State<TampilDataMakanan> {
  bool isLoading = false;
  bool isLoadingSecond = false;

  @override
  Widget build(BuildContext context) {
    ProviderFavoriteFood providerFavoriteFood =
        Provider.of<ProviderFavoriteFood>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    DateTime tempToday = DateTime.now();
    String finalToday = DateFormat('yyyy-MM-dd').format(tempToday);
    String finalTime = DateFormat('HH:mm').format(tempToday);

    // MENGIRIM DATA KE CATATAN
    sendData() {
      setState(() {
        isLoadingSecond = true;
      });

      Future.delayed(const Duration(milliseconds: 1500));

      CatatanApiService().postCatatanModel(
          tanggal: finalToday,
          waktu: finalTime,
          kalori_masuk: providerFavoriteFood.totalKalori(),
          target_kalori: user!.kaloriHarian!,
          sisa_kalori: user.kaloriHarian! - providerFavoriteFood.totalKalori());

      providerFavoriteFood.clearList();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green[400],
          content: const Text("Berhasil mengirim catatan!")));

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/main_page', (Route<dynamic> route) => false);
    }

    // WARNING POP UP
    Widget warning() => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Icon(
            Icons.warning,
            size: 70,
            color: Colors.red,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'WARNING!',
                style: Styles.outfitDialogText3,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Isi piring anda melebihi sisa kalori harian anda saat ini!',
                style: Styles.outfitDialogText4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'KEMBALI',
                        style: Styles.outfitDialogTidakText5,
                        textAlign: TextAlign.center,
                      )),
                ],
              )
            ],
          ),
        );

    Widget showKirimData() => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            'Perhatian!',
            style: Styles.outfitDialogText3,
          ),
          content: Text(
            'Total Kalori yang Anda makan adalah : ${providerFavoriteFood.totalKalori()} kalori',
            style: Styles.outfitDialogText4,
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'KEMBALI',
                  style: Styles.outfitDialogTidakText5,
                )),
            TextButton(
                onPressed: () {
                  sendData();
                },
                child: isLoadingSecond
                    ? const CircularProgressIndicator(
                        color: Styles.appBarPrimaryColor,
                      )
                    : const Text('KIRIM SEKARANG!',
                        style: Styles.outfitDialogYaText6)),
          ],
        );

    // CEK WARNING JIKA SISA KALORI HARI INI MELEBIHI BATAS
    cekSisaKaloriAkhir({required num totalKalori}) async {
      setState(() {
        isLoading = true;
      });

      List<Datum> results = [];
      String urlList = "https://spoonycal.ik3d.site/api/catatan";
      num? targetKalori;
      num kaloriMasuk = 0;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      try {
        var response = await http.get(
          Uri.parse(urlList),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '$token',
          },
        );

        if (response.statusCode == 200) {
          var data = json.decode(response.body)['data'];
          results = (data as List).map((e) => Datum.fromJson(e)).toList();
          print(response.statusCode);
          print(results);
          print(finalToday);
          if (results.length != 0) {
            for (int i = 0; i < results.length; i++) {
              for (int j = 0; j < results[i].catatan!.length; j++) {
                print("Haloo");
                if (i == (results.length - 1)) {
                  String finalDataHari =
                      DateFormat('yyyy-MM-dd').format(results[i].date!);
                  if (finalToday == finalDataHari) {
                    targetKalori = results[i].catatan?[j].targetKalori;
                    kaloriMasuk =
                        kaloriMasuk + results[i].catatan![j].kaloriMasuk!;
                    print('HARI INI TGL 27');
                    if (j == results[i].catatan!.length - 1) {
                      if (targetKalori! - (kaloriMasuk + totalKalori) < 0) {
                        print(kaloriMasuk + totalKalori);
                        print("Kalori yang masuk melebihi kalori harian anda");
                        setState(() {
                          isLoading = false;
                        });
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) => warning());
                      } else {
                        print('Kalori tidak melebihi kalori harian!');
                        setState(() {
                          isLoading = false;
                        });
                        return showDialog(
                            context: context,
                            builder: (BuildContext context) => showKirimData());
                      }
                    }
                  } else {
                    print('HARI INI BEDA DENGAN HARI AKHIR DI API');
                    setState(() {
                      isLoading = false;
                    });
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) => showKirimData());
                  }
                }
              }
            }
          } else {
            print('Data masih kosong');
            setState(() {
              isLoading = false;
            });
            return showDialog(
                context: context,
                builder: (BuildContext context) => showKirimData());
          }
        } else {
          print(token);
          print(response.statusCode);
          print("fetch error");
        }
      } on Exception catch (e) {
        print('error: $e');
      }
      return results;
    }

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
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.67,
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
                              "${favoriteList[index].tempBerat} gram (g) - " +
                                  "${favoriteList[index].tempKaloriPerGram}" +
                                  " kal",
                              style: Styles.soraMakananText3,
                            ),
                            IconButton(
                                onPressed: () {
                                  providerFavoriteFood.removeFromList(index);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor:
                                              Color.fromARGB(255, 206, 83, 81),
                                          duration:
                                              Duration(milliseconds: 1000),
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
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    title: const Text(
                      'Total Kalori',
                      style: Styles.soraMakananText4,
                    ),
                    trailing: Text(
                      '${providerFavoriteFood.totalKalori()} kal',
                      style: Styles.soraMakananText5,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton.icon(
                      icon: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const SizedBox.shrink(),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xff45625d)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF54A5CC)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ))),
                      onPressed: () => {
                            isLoading
                                ? null
                                : cekSisaKaloriAkhir(
                                    totalKalori:
                                        providerFavoriteFood.totalKalori()),
                          },
                      label: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          isLoading ? '' : "Isi piring saya sudah lengkap!",
                          style: Styles.bodyQuestion1,
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 50,
                )
              ]),
        ],
      ),
    );
  }
}
