import 'package:flutter/material.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:intl/intl.dart';

// Variabel Const dari kalori-kalori
const TWO_PI = 3.14 * 2;
const targetKalori = 2200;
const sisaKalori = 1800;
const percentageCircular = sisaKalori / targetKalori;

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    // Mendefinisikan Controller, Size, dan Listlist
    final controllerPage = PageController(initialPage: 0);
    const sizeContainer = 185.0;

    @override
    void dispose() {
      controllerPage.dispose();
    }

    // _remove(List mylist, int index) {
    //   if (mylist[index] = mylist[mylist.length-1]) {
    //     return true;
    //   } else {
    //     return false;
    //   }
    // }

    DateTime today = DateTime.now();
    List<int> eatenCalorie = [700, 1200, 300];
    List<String> time = ["08.10", "12.30", "18.23"];
    // List<int> eatenCalorie = [700, 1200, 300];
    List<DateTime> dateTime = [
      today,
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2))
    ];
    List<String> stringDateTime = [
      DateFormat.yMMMEd().format(dateTime[0]),
      DateFormat.yMMMEd().format(dateTime[1]),
      DateFormat.yMMMEd().format(dateTime[2])
    ];
    List<String> dateTime2 = ["3022", "3023"];
    // List<bool> checkRemove = [true, false, true];

    // Menghapus visible pada button jika tanggal awal dan akhir
    return PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: controllerPage,
        itemCount: dateTime.length,
        itemBuilder: (context, position) {
          return SingleChildScrollView(
            //** LEBAR KESELURUHAN KONTAINER BODY */
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //** PREVIOUS BUTTON, TEXT, NEXT BUTTON */
                      Visibility(
                        visible: true,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        maintainInteractivity: true,
                        child: IconButton(
                            onPressed: () => controllerPage.previousPage(
                                duration: const Duration(milliseconds: 700),
                                curve: Curves.easeInOut),
                            icon: Icon(Icons.keyboard_arrow_left),
                            iconSize: 50,
                            color: Styles.mainBlueColor),
                      ),
                      Text(
                        stringDateTime[position],
                        style: Styles.shareFont3,
                      ),
                      IconButton(
                          onPressed: () => controllerPage.nextPage(
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeInOut),
                          icon: Icon(Icons.keyboard_arrow_right),
                          iconSize: 50,
                          color: Styles.mainBlueColor),
                    ],
                  ),

                  //** CONTAINER DARI CIRCULAR DESIGN */
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 220,
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
                                3.0,
                              ),
                              blurRadius: 6.0,
                              spreadRadius: 3.0,
                            ),
                          ],
                        ),

                        //** CIRCULAR DESIGN */
                        child: Center(
                          child: TweenAnimationBuilder(
                            tween: Tween(begin: 0.0, end: percentageCircular),
                            duration: Duration(milliseconds: 1500),
                            curve: Curves.easeInOut,
                            builder: (BuildContext context, double value,
                                Widget? child) {
                              int persen = (value * targetKalori).ceil();
                              return Container(
                                width: sizeContainer,
                                height: sizeContainer,
                                child: Stack(
                                  // alignment: Alignment.center,
                                  children: [
                                    //** SHADER MASK */
                                    ShaderMask(
                                      shaderCallback: (rect) {
                                        return SweepGradient(
                                            startAngle: 0.0,
                                            endAngle: TWO_PI,
                                            stops: [value, value],
                                            // 0.0 , 0.5 , 0.5 , 1.0
                                            center: Alignment.center,
                                            colors: [
                                              Colors.blue,
                                              Colors.grey.withAlpha(30)
                                            ]).createShader(rect);
                                      },
                                      child: Container(
                                        width: sizeContainer,
                                        height: sizeContainer,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),

                                    // //** CIRCULAR PUTIH */
                                    Center(
                                      child: Container(
                                        width: sizeContainer - 40,
                                        height: sizeContainer - 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),

                                        //** TEKS - SISA KALORI DAN VALUE */
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "TERSISA",
                                              style: Styles.shareFont4,
                                            ),
                                            Text(
                                              '$persen kal',
                                              style: Styles.shareFont5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )),
                  ),

                  // PEMBATAS
                  SizedBox(
                    height: 30,
                  ),

                  //** KONTAINER LAPORAN KALORI HARIAN DAN LISTVIEW */
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                              3.0,
                            ),
                            blurRadius: 6.0,
                            spreadRadius: 3.0,
                          ),
                        ],
                      ),

                      //** KONTAINER LAPORAN KALORI HARIAN */
                      child: Column(
                        children: [
                          //** KOLOM 1 - KONTAINER ATAS */
                          Container(
                            width:
                                MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                            padding:
                                EdgeInsets.symmetric(horizontal: 30.0),
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
                              child: Center(
                                  child: Text(
                                "LAPORAN KALORI HARIAN",
                                style: Styles.shareFont8,
                              )),
                            ),
                          ),

                          //** KOLOM 2 - KONTAINER LISTVIEW */
                          for (int i = 0; i < eatenCalorie.length; i++)
                            ListTile(
                              title: Text(
                                "${eatenCalorie[i]} Kalori",
                                style: Styles.shareFont6,
                              ),
                              trailing: Text("${time[i]} WIB",
                                  style: Styles.shareFont7),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
