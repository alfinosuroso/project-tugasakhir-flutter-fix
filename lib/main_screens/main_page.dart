import 'dart:async';
import 'dart:convert';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugasakhir_app/Register%20and%20Login%20Screens/sign_in_page.dart';
import 'package:tugasakhir_app/Register%20and%20Login%20Screens/sign_up_page.dart';
import 'package:tugasakhir_app/main_screens/components_main/fab.dart';
import 'package:tugasakhir_app/main_screens/home/home_appbar.dart';
import 'package:tugasakhir_app/main_screens/home/home_body.dart';
import 'package:tugasakhir_app/main_screens/profile/profile_appbar.dart';
import 'package:tugasakhir_app/main_screens/profile/profile_body.dart';
import 'package:tugasakhir_app/main_screens/report/report_appbar.dart';
import 'package:tugasakhir_app/main_screens/report/report_body.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:after_layout/after_layout.dart';
import 'package:http/http.dart' as http;

String? finalEmail;
String? finalName;
SharedPreferences? localStorage;
String? finalGender;
double? finalBeratBadan;
double? finalTinggiBadan;
double? finalUmur;
double? finalKaloriHarian;
String? finalToken;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final isDialOpen = ValueNotifier(false);

  int currentIndexBotNavBar = 0;
  final screensAppBar = [
    const HomeAppBar(),
    const ReportAppBar(),
    const ProfileAppBar(),
  ];
  final screensBody = [
    const HomeBody(),
    const ReportBody(),
    const ProfileBody(),
  ];

  List appBarHeight = [
    120.0,
    80.0,
    0.0,
  ];

  @override
  // void afterFirstLayout(BuildContext context) {
  //   getValidationData();
  // }

  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      getValidationData();
    });
  }

  void getValidationData() async {
    localStorage = await SharedPreferences.getInstance();
    final String? getToken = localStorage?.getString('token');
    final responseProfil = await http.get(
        Uri.parse("https://spoonycal-ta.herokuapp.com/api/profile"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $getToken',
        });

    final dataProfile = jsonDecode(responseProfil.body)['data']['data'];
    // localStorage?.setDouble('kalori_harian', dataProfile['kalori_harian']);

    setState(() {
      finalName = localStorage?.getString("name")!;
      finalEmail = localStorage?.getString("email")!;
      finalGender = localStorage?.getString("gender_user");
      finalBeratBadan = localStorage?.getDouble("berat_badan");
      finalTinggiBadan = localStorage?.getDouble("tinggi_badan");
      finalUmur = localStorage?.getDouble("umur");
      finalKaloriHarian = localStorage?.getDouble("kalori_harian");;
      finalToken = getToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Styles.bgMainColor,

        // ** APPBAR - DIFFERENT SCREENAPPBAR */
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight[currentIndexBotNavBar]),
          child: screensAppBar[currentIndexBotNavBar],
        ),

        // ** BODY - DIFFERENT SCREENBODY */
        body: IndexedStack(
          index: currentIndexBotNavBar,
          children: screensBody,
        ),

        // ** FLOATING BUTTON ** //
        floatingActionButton: const Fab(),

        //** BOTTOM NAVIGATION BAR */
        bottomNavigationBar: SizedBox(
          height: 70,
          child: BottomNavigationBar(
              currentIndex: currentIndexBotNavBar,
              onTap: (index) => setState(() {
                    currentIndexBotNavBar = index;
                  }),
              selectedLabelStyle: Styles.selectedBottomNavBarText,
              unselectedLabelStyle: Styles.unselectedBottomNavBarText,
              selectedItemColor: Styles.appBarPrimaryColor,
              unselectedItemColor: Styles.offGreyColor,
              iconSize: 32,
              items: [
                const BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: "Beranda",
                ),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.auto_graph),
                    label: "Laporan",
                    backgroundColor: Colors.orange),
                const BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: "Profile",
                    backgroundColor: Colors.greenAccent),
              ]),
        ),
      ),
    );
  }
}
