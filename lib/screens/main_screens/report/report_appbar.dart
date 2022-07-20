import 'package:flutter/material.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';
import 'package:tugasakhir_app/styles.dart';

class ReportAppBar extends StatelessWidget {
  const ReportAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100.0, // Set this height
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,

      flexibleSpace: Container(
        height: 100.0,
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
                padding: const EdgeInsets.fromLTRB(30, 38, 30, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 1. Teks User - Welcome User dan Email User
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo, $finalName",
                          style: Styles.welcomeUserAppBar1,
                        ),
                        Text(
                          "$finalEmail",
                          style: Styles.welcomeUserAppBar2,
                        ),
                      ],
                    ),

                    // 2. Logo - Logo Spoonycal dan Bluetooth
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/bluetooth-icon.png'),
                          // width: 100,
                          // height: 100,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image(
                          image: AssetImage('assets/images/spoonycal-icon.png'),
                          // width: 100,
                          // height: 100,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
