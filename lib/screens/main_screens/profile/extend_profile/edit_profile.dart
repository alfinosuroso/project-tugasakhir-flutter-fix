import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tugasakhir_app/screens/main_screens/components_main/fab.dart';
import 'package:tugasakhir_app/screens/main_screens/main_page.dart';
import 'package:tugasakhir_app/styles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgMainColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: Styles.appBarPrimaryColor,
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
      ),
      body: Stack(
        children: [
          // Kontainer atas - biru
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            color: Styles.appBarPrimaryColor,
            // 2 Row - Kumpulan User dan Logo
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 50.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Edit Profil",
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

          Align(
            alignment: Alignment(-0.9, -0.95),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Container utama - Putih
          //** Kontainer dalam - Edit Profil - Pengaturan - Bantuan */
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
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
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // USERNAME
                        Text(
                          "Username",
                          style: Styles.shareFontProfile11,
                        ),
                        TextField(
                          controller: ControlEditProfile.controllerUsername,
                          decoration: InputDecoration(),
                          maxLines: 1,
                          style: Styles.shareFontProfileText12,
                        ),

                        // EMAIL
                        const SizedBox(height: 12),
                        Text(
                          "Email Address",
                          style: Styles.shareFontProfile11,
                        ),
                        TextField(
                          controller: ControlEditProfile.controllerEmail,
                          decoration: InputDecoration(),
                          maxLines: 1,
                          style: Styles.shareFontProfileText12,
                        ),
                        const SizedBox(height: 12),

                        // TINGGI BADAN
                        Text(
                          "Tinggi Badan",
                          style: Styles.shareFontProfile11,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: TextField(
                                controller: ControlEditProfile.controllerTinggi,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                maxLines: 1,
                                style: Styles.shareFontProfileText12,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  // FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                              ),
                            ),
                            Text(
                              "  Cm",
                              style: Styles.shareFontProfile11,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // BERAT BADAN
                        Text(
                          "Berat Badan",
                          style: Styles.shareFontProfile11,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: TextField(
                                controller: ControlEditProfile.controllerBerat,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                maxLines: 1,
                                style: Styles.shareFontProfileText12,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  // FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                              ),
                            ),
                            Text(
                              "  Kg",
                              style: Styles.shareFontProfile11,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // UMUR
                        Text(
                          "Usia",
                          style: Styles.shareFontProfile11,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: TextField(
                                controller: ControlEditProfile.controllerUmur,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                maxLines: 1,
                                style: Styles.shareFontProfileText12,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  // FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d+\.?\d{0,2}')),
                                ],
                              ),
                            ),
                            Text(
                              "  Tahun",
                              style: Styles.shareFontProfile11,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // ** FLOATING BUTTON ** //
        floatingActionButton: const FabProfile(),
    );
  }
}

class ControlEditProfile {
  static final TextEditingController controllerUsername =
      TextEditingController(text: finalName);
  static final TextEditingController controllerEmail =
      TextEditingController(text: finalEmail);
  static final TextEditingController controllerTinggi =
      TextEditingController(text: finalTinggiBadan.toString());
  static final TextEditingController controllerBerat =
      TextEditingController(text: finalBeratBadan.toString());
  static final TextEditingController controllerGender =
      TextEditingController(text: finalGender);
  static final TextEditingController controllerUmur =
      TextEditingController(text: finalUmur.toString());
}
