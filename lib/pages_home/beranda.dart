import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.0, // Set this height
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,

          flexibleSpace: Container(
            height: 140.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Styles.appBarPrimaryColor,
                  ),
                  // 2 Row - Kumpulan User dan Logo
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1. Teks User - Welcome User dan Email User
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Pagi, User!",
                              style: Styles.welcomeUserAppBar1,
                            ),
                            Text(
                              "Username@gmail.com",
                              style: Styles.welcomeUserAppBar2,
                            ),
                          ],
                        ),

                        // 2. Logo - Logo Spoonycal dan Bluetooth
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  'assets/images/bluetooth-icon.png'),
                              // width: 100,
                              // height: 100,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Image(
                              image: AssetImage(
                                  'assets/images/spoonycal-icon.png'),
                              // width: 100,
                              // height: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // KONTAINER DATA BERAT DAN TINGGI BADAN
                Positioned(
                  top: 80.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: const Offset(
                              0.0,
                              10.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),

                      // BERAT BADAN DAN TINGGI BADAN
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "BERAT BADAN",
                                style: Styles.headlineData1,
                              ),
                              Text(
                                "57 Kg",
                                style: Styles.headlineData2,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "KALORI HARIAN",
                                style: Styles.headlineData1,
                              ),
                              Text(
                                "2500 Kalori",
                                style: Styles.headlineData2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        // extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 200),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 200),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                  Text(
                    "HOLAAA",
                    style: TextStyle(fontSize: 100),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
            ),
          ],
        ));
  }
}


// Text("HOLAAA", style: TextStyle(fontSize: 100),),