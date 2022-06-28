import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';

class Beranda extends StatelessWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120.0, // Set this height
          backgroundColor: Colors.transparent,
          elevation: 0,

          flexibleSpace: Container(
            height: 120.0,
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
                    padding: const EdgeInsets.all(25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 1. Teks User - Welcome User dan Email User
                        Container(
                          child: Column(
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
                        ),

                        // 2. Logo - Logo Spoonycal dan Bluetooth
                        Container(
                          child: Row(
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
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 80.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1.0),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5), width: 1.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                              // _scaffoldKey.currentState.openDrawer();
                            },
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              print("your menu action here");
                            },
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
                child: Icon(Icons.plus_one),
              ),
            ),
          ],
        ));
  }
}


// Text("HOLAAA", style: TextStyle(fontSize: 100),),