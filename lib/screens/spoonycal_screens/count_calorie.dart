import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/model/calorie_model.dart';
import 'package:tugasakhir_app/providers/favorite_food.dart';
import 'package:tugasakhir_app/screens/spoonycal_screens/search_screen.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:web_socket_channel/io.dart';
import 'package:intl/intl.dart';

// const String espUrl = 'ws://192.168.1.184:81';
const String espUrl = 'ws://192.168.222.73:81';

class CountCalorie extends StatefulWidget {
  final String? finalMakanan;
  final int? finalKaloriPerGram;

  const CountCalorie({
    Key? key,
    @required this.finalMakanan,
    @required this.finalKaloriPerGram,
  }) : super(key: key);

  @override
  State<CountCalorie> createState() => _CountCalorieState();
}

class _CountCalorieState extends State<CountCalorie> {
  bool isLoaded = false;
  bool isEmpty = false;
  double? tempBerat;
  double? tempKalori;
  double totalBerat = 0;
  double totalKalori = 0;
  String msg = '';
  CalorieModel dht = CalorieModel(0, 0);
  // double? resultKal;
  final channel = IOWebSocketChannel.connect(espUrl);
  @override
  void initState() {
    super.initState();

    channel.stream.listen(
      (message) {
        channel.sink.add('Flutter received $message');
        if (message == "connected") {
          print('Received from MCU: $message');
          setState(() {
            msg = message;
          });
        } else {
          print('Received from MCU: $message');
          print('berhasil mengambil data');
          // {'tempC':'30.50','humi':'64.00'}
          Map<String, dynamic> json = jsonDecode(message);
          setState(() {
            dht = CalorieModel.fromJson(json);
            // resultKal = dht.humi * finalKaloriHarian! * 0.01;
            isLoaded = true;
          });
        }
        //channel.sink.close(status.goingAway);
      },
      onDone: () {
        //if WebSocket is disconnected
        print("Web socket is closed");
        setState(() {
          msg = 'disconnected';
          isLoaded = false;
        });
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProviderFavoriteFood providerFavoriteFood =
        Provider.of<ProviderFavoriteFood>(context);


DateTime tempToday = DateTime.now();
    String finalToday = DateFormat('yyyy-MM-dd').format(tempToday);

    Future<void> realBeratKalori() async {
      tempBerat = dht.humi;
      tempKalori = dht.humi * widget.finalKaloriPerGram! * 0.01;
      totalBerat += dht.humi;
      totalKalori += dht.humi * widget.finalKaloriPerGram! * 0.01;
      isEmpty = true;
    }

    Future<void> clearBeratKalori() async {
      tempBerat = 0;
      tempKalori = 0;
      totalBerat = 0;
      totalKalori = 0;
      isEmpty = false;
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
title: RichText(
          text: TextSpan(
              text: 'Pilih makanan anda',
              style: Styles.shareTitleAppbarText13,
              children: [
                TextSpan(
                  text: '\n' + '$finalToday',
                  style: Styles.shareDateFont16,
                )
              ]),
        ),
      ),
      body: !isLoaded
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      // ignore: prefer_const_literals_to_create_immutables
                      boxShadow: [
                        const BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Styles.appBarPrimaryColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: const Offset(
                                    0.0,
                                    3.0,
                                  ),
                                  blurRadius: 6.0,
                                  spreadRadius: 3.0,
                                ),
                              ],
                            ),

                            //** TEKS LAPORAN KALORI HARIAN */
                            child: const Center(
                                child: Text(
                              "SILAHKAN ANGKAT MAKANAN ANDA",
                              style: Styles.shareFont8,
                              textAlign: TextAlign.center,
                            )),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "BERAT PADA SENDOK SAAT INI : ",
                              style: Styles.shareBeratSendokFont14,
                            ),
                            Text(
                              '${dht.humi.toStringAsFixed(2)} gr',
                              style: Styles.shareBeratSendokFont15,
                            ),
                          ],
                        ),
                        Text(
                          "*menghitung berat ${widget.finalMakanan}",
                          style: Styles.shareBeratSendokFont14,
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        // TOTAL BERAT //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Total berat : ",
                              style: Styles.amaranthCalorieText1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              color: Color(0xFFDCDCDC),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: !isEmpty
                                      ? Text(
                                          '0',
                                          style: Styles.outfitCalorieText1,
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          '${totalBerat.toStringAsFixed(1)}',
                                          style: Styles.outfitCalorieText1,
                                          textAlign: TextAlign.center,
                                        )),
                            ),
                            const Text(
                              ' gr',
                              style: Styles.outfitCalorieText2,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // TOTAL KALORI //
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Total kalori : ",
                              style: Styles.amaranthCalorieText1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              color: const Color(0xFFDCDCDC),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: !isEmpty
                                      ? Text(
                                          '0'.toString(),
                                          // '${resultKal}'.toString(),
                                          style: Styles.outfitCalorieText1,
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          '${totalKalori.toStringAsFixed(2)}',
                                          // '${resultKal}'.toString(),
                                          style: Styles.outfitCalorieText1,
                                          textAlign: TextAlign.center,
                                        )),
                            ),
                            const Text(
                              ' kal',
                              style: Styles.outfitCalorieText2,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        const Text(
                          "*anda bisa mengangkat makanan anda sekarang",
                          style: Styles.amaranthCalorieText2,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // TANGKAP KALORI //
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFF54CC60)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {
                                realBeratKalori();
                                providerFavoriteFood.addCart(
                                    makan: widget.finalMakanan,
                                    kalori: tempKalori?.toInt(),
                                    berat: tempBerat?.toInt());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Color(0xFF54CC60),
                                        content:
                                            Text("Berhasil menangkap data!")));
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "TANGKAP KALORI",
                                  style: Styles.bodyQuestion1,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),

                        // CARI MAKANAN LAIN //
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 80, 196, 169)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
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
                                                'Sudah selesai menangkap kalori ${widget.finalMakanan}?',
                                                style: Styles.outfitDialogText4,
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      clearBeratKalori();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'TIDAK',
                                                      style: Styles
                                                          .outfitDialogTidakText5,
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              SearchScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text('YA',
                                                        style: Styles
                                                            .outfitDialogYaText6)),
                                              ],
                                            ))
                                  },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "CARI MAKANAN LAIN",
                                  style: Styles.bodyQuestion1,
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),

                        // HAPUS SEMUA KALORI //
                        providerFavoriteFood.favoriteFood.isEmpty
                            ? const SizedBox.shrink()
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 211, 81, 81)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))),
                                    onPressed: () => {
                                          clearBeratKalori(),
                                          providerFavoriteFood.clearList(),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 206, 83, 81),
                                                  content: Text(
                                                      "Berhasil menghapus semua data kalori!")))
                                        },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "HAPUS SEMUA KALORI",
                                        style: Styles.bodyQuestion1,
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),

                        // SELESAI //
                        providerFavoriteFood.favoriteFood.isEmpty
                            ? const SizedBox.shrink()
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 210, 186, 67)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ))),
                                    onPressed: () => {
                                          Navigator.pushNamed(
                                              context, '/tampil_data')
                                        },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "SELESAI",
                                        style: Styles.bodyQuestion1,
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),

                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
