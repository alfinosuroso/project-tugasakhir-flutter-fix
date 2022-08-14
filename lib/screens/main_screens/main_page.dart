import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tugasakhir_app/model/catatan_model.dart';
import 'package:tugasakhir_app/screens/main_screens/components_main/fab.dart';
import 'package:tugasakhir_app/screens/main_screens/home/home_appbar.dart';
import 'package:tugasakhir_app/screens/main_screens/home/home_body.dart';
import 'package:tugasakhir_app/screens/main_screens/profile/profile_appbar.dart';
import 'package:tugasakhir_app/screens/main_screens/profile/profile_body.dart';
import 'package:tugasakhir_app/screens/main_screens/report/report_appbar.dart';
import 'package:tugasakhir_app/screens/main_screens/report/report_body.dart';
import 'package:tugasakhir_app/services/api_catatan_service.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CatatanApiService _catatanModel = CatatanApiService();
  late Future<List<Datum>>? dataFutureCatatan;
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

  Future<List<Datum>>? _loadData() async {
    return await _catatanModel.getCatatanModel();
  }

  @override
  void initState() {
    super.initState();
    dataFutureCatatan = _loadData();
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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.auto_graph),
                    label: "Laporan",
                    backgroundColor: Colors.orange),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Profile",
                    backgroundColor: Colors.greenAccent),
              ]),
        ),
      ),
    );
  }
}
