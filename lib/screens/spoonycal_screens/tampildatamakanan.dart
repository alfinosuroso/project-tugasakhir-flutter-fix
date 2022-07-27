import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
import 'package:tugasakhir_app/providers/favorite_food.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';
import 'package:tugasakhir_app/services/api_catatan_service.dart';
import 'package:tugasakhir_app/styles.dart';

class TampilDataMakanan extends StatelessWidget {
  const TampilDataMakanan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProviderFavoriteFood providerFavoriteFood =
        Provider.of<ProviderFavoriteFood>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    DateTime tempToday = DateTime.now();
    String finalToday = DateFormat('yyyy-MM-dd').format(tempToday);
    String finalTime = DateFormat('HH:mm').format(tempToday);

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
                              "${favoriteList[index].tempBerat} gram (g) - " +
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
              title: Text(
                'Total Kalori',
                style: Styles.soraMakananText4,
              ),
              trailing: Text(
                '${providerFavoriteFood.totalKalori()} kal',
                style: Styles.soraMakananText5,
              ),
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
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
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
                                        CatatanApiService().postCatatanModel(
                                            tanggal: finalToday,
                                            waktu: finalTime,
                                            kalori_masuk: providerFavoriteFood
                                                .totalKalori(),
                                            target_kalori: user!.kaloriHarian!,
                                            sisa_kalori: user.kaloriHarian! -
                                                providerFavoriteFood
                                                    .totalKalori());

                                        providerFavoriteFood.clearList();

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.green[400],
                                                content: Text("Berhasil mengirim catatan!")));

                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                '/main_page',
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                      child: const Text('KIRIM SEKARANG!',
                                          style: Styles.outfitDialogYaText6)),
                                ],
                              ))
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
