// ignore_for_file: unrelated_type_equality_checks

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:tugasakhir_app/model/user_model.dart';
import 'package:tugasakhir_app/providers/auth_provider.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerTinggi = TextEditingController();
  TextEditingController controllerBerat = TextEditingController();
  TextEditingController controllerUmur = TextEditingController();
  TextEditingController controllerKaloriHarian = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel? user = authProvider.user;
    num newKalori = 0;

    TextEditingController controllerEmail =
        TextEditingController(text: user?.email);
    TextEditingController controllerGender =
        TextEditingController(text: user?.gender);

    num? newKaloriHarian() {
      if (user?.gender == 'Laki-Laki') {
        newKalori = 66.5 +
            (13.8 * user!.berat!) +
            (5.0 * user.tinggi!) -
            (6.8 * user.umur!);
        return newKalori;
      } else if (user?.gender == 'Perempuan') {
        newKalori = 655.1 +
            (9.6 * user!.berat!) +
            (1.9 * user.tinggi!) -
            (4.7 * user.umur!);
        return newKalori;
      }
      return null;
    }

    handleUpdate() async {
      setState(() {
        isLoading = true;
      });

      if (controllerUsername.text == '' ||
          controllerBerat.text == '' ||
          controllerTinggi == '' ||
          controllerUmur == '' ||
          controllerKaloriHarian == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'Ada data yang kosong',
            ),
          ),
        );
      } else if (await authProvider.editData(
        token: user!.token!,
        name: controllerUsername.text,
        berat: num.parse(controllerBerat.text),
        tinggi: num.parse(controllerTinggi.text),
        umur: num.parse(controllerUmur.text),
        kalori_harian: newKaloriHarian(),
      )) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green[400],
            content: Text("Data berhasil disimpan")));
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/main_page', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Styles.buttonAuthBg,
            content: Text(
              'Ada data yang kosong',
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget showUpdateData() => AlertDialog(
          title: Text(
            'Update Data',
            style: Styles.outfitDialogText3,
          ),
          content: Text(
            'Yakin ingin mengupdate data anda?',
            style: Styles.outfitDialogText4,
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'TIDAK',
                  style: Styles.outfitDialogTidakText5,
                )),
            TextButton(
                onPressed: () {
                  handleUpdate();
                },
                child: const Text('YA', style: Styles.outfitDialogYaText6)),
          ],
        );

    return Scaffold(
      backgroundColor: Styles.bgMainColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
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
                  const Spacer(
                    flex: 1,
                  ),
                  // 1. Teks User - Welcome User dan Email User
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Edit Profil",
                          style: Styles.welcomeUserAppBar1,
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Text(
                          "${user?.name}",
                          style: Styles.shareFont8,
                        ),
                        Text(
                          "${user?.email}",
                          style: Styles.welcomeUserAppBar1,
                        ),
                      ],
                    ),
                  ),

                  // 2. Logo - Logo Spoonycal dan Wifi Hotspot
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => AppSettings.openDeviceSettings(
                            asAnotherTask: true,
                          ),
                          child: Image(
                            image: AssetImage('assets/images/wifi-hotspot.png'),

                            // width: 100,
                            // height: 100,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/pairing_device_screen'),
                          child: Image(
                            image: AssetImage('assets/images/spoonycal-icon.png'),
                            // width: 100,
                            // height: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: const Alignment(-0.9, -0.95),
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(
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
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // USERNAME
                        const Text(
                          "Username",
                          style: Styles.shareFontProfile11,
                        ),
                        TextField(
                          onChanged: (value) => {},
                          controller: controllerUsername,
                          maxLines: 1,
                          style: Styles.shareFontProfileText12,
                          decoration: InputDecoration(
                            hintText: user?.name,
                          ),
                        ),

                        // EMAIL
                        const SizedBox(height: 12),
                        const Text(
                          "Email",
                          style: Styles.shareFontProfile11,
                        ),
                        TextField(
                          enabled: false,
                          controller: controllerEmail,
                          maxLines: 1,
                          style: Styles.shareFontProfileText12_2,
                        ),
                        const SizedBox(height: 12),

                        // JENIS KELAMIN
                        const SizedBox(height: 12),
                        const Text(
                          "Jenis Kelamin",
                          style: Styles.shareFontProfile11,
                        ),
                        TextField(
                          enabled: false,
                          controller: controllerGender,
                          maxLines: 1,
                          style: Styles.shareFontProfileText12_2,
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
                                controller: controllerTinggi,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: user?.tinggi.toString(),
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
                                controller: controllerBerat,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: user?.berat.toString(),
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
                                controller: controllerUmur,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: user?.umur.toString(),
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

                        // KALORI HARIAN
                        Text(
                          "Kalori Harian",
                          style: Styles.shareFontProfile11,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: TextField(
                                enabled: false,
                                controller: controllerKaloriHarian,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintText: user?.kaloriHarian.toString(),
                                ),
                                maxLines: 1,
                                style: Styles.shareFontProfileText12_2,
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
                              "  kal",
                              style: Styles.shareFontProfile11,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // ** FLOATING BUTTON ** //
      floatingActionButton: SpeedDial(
          icon: FontAwesomeIcons.save,
          animatedIconTheme: IconThemeData(size: 25.0),
          backgroundColor: Styles.mainBlueColor,
          overlayOpacity: 0.8,
          onPress: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => showUpdateData()),
              }),
    );
  }
}
