import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';
import 'package:tugasakhir_app/styles.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  logout() async {
    final localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token'); // <- remove sharedpreferences

    Navigator.pushReplacementNamed(
        context, "/sign_in_page"); // <- navigasi ke halaman awal
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Kontainer atas - biru
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.31,
          color: Styles.appBarPrimaryColor,
          // 2 Row - Kumpulan User dan Logo
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 50.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(
                    flex: 1,
                  ),
                // 1. Teks User - Welcome User dan Email User
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Profil Saya",
                        style: Styles.welcomeUserAppBar1,
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Text(
                        "$finalName",
                        style: Styles.shareFont8,
                      ),
                      Text(
                        "$finalEmail",
                        style: Styles.welcomeUserAppBar1,
                      ),
                    ],
                  ),
                ),

                // 2. Logo - Logo Spoonycal dan Bluetooth
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                ),
              ],
            ),
          ),
        ),

        // Container utama - Putih 
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: const Offset(
                    0.0,
                    -3.0,
                  ),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  //** EDIT */
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Styles.offGreyBorder, width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.edit,
                          color: Styles.appBarPrimaryColor,
                          size: 30,
                        ),
                        title: Text(
                          'Edit Profil',
                          style: Styles.shareFont9,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/edit_profile');
                        },
                      ),
                    ),
                  ),

                  //** PENGATURAN */
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Styles.offGreyBorder, width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.settings,
                          color: Styles.appBarPrimaryColor,
                          size: 30,
                        ),
                        title: Text(
                          'Pengaturan',
                          style: Styles.shareFont9,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/question1');
                        },
                      ),
                    ),
                  ),

                  //** BANTUAN */
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Styles.offGreyBorder, width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.help,
                          color: Styles.appBarPrimaryColor,
                          size: 30,
                        ),
                        title: Text(
                          'Bantuan',
                          style: Styles.shareFont9,
                        ),
                        onTap: () {
                          logout();
                        },
                      ),
                    ),
                  ),

                  //** LOGOUT */
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Styles.offGreyBorder, width: 2))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Styles.logOutColor,
                          size: 30,
                        ),
                        title: Text(
                          'Keluar',
                          style: Styles.shareFontLogOut10,
                        ),
                        onTap: () {
                          logout();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
      ],
    );
  }
}
