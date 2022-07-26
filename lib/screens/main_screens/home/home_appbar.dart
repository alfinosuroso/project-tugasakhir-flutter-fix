import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
import 'package:tugasakhir_app/styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    return AppBar(
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
                          "Halo, ${user?.name}",
                          style: Styles.welcomeUserAppBar1,
                        ),
                        Text(
                          "${user?.email}",
                          style: Styles.welcomeUserAppBar2,
                        ),
                      ],
                    ),

                    // 2. Logo - Logo Spoonycal dan Wifi Hotspot
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                        onTap: () => AppSettings.openDeviceSettings(asAnotherTask: true,),
                        child: Image(
                          image: AssetImage('assets/images/wifi-hotspot.png'),
                          
                          // width: 100,
                          // height: 100,
                        ),
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
                          3.0,
                        ),
                        blurRadius: 6.0,
                        spreadRadius: 3.0,
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
                            style: Styles.shareFont1,
                          ),
                          Text(
                            "${user?.berat}".toString() + ' Kg',
                            style: Styles.shareFont2,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "KALORI HARIAN",
                            style: Styles.shareFont1,
                          ),
                          Text(
                            "${user?.kaloriHarian}".toString() + ' Kalori',
                            style: Styles.shareFont2,
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
    );
  }
}
