import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tugasakhir_app/styles.dart';

class Fab extends StatefulWidget {
  const Fab({Key? key}) : super(key: key);

  @override
  State<Fab> createState() => _FabState();
}

class _FabState extends State<Fab> {
  final isDialOpen = ValueNotifier(false);
  Future ShowToast(String message) async {
    await Fluttertoast.cancel();

    Fluttertoast.showToast(
        msg: message, fontSize: 15, backgroundColor: Colors.blueGrey[800]);
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: FontAwesomeIcons.add,
      activeIcon: FontAwesomeIcons.minus,
      animatedIconTheme: IconThemeData(size: 25.0),
      backgroundColor: Styles.mainBlueColor,
      curve: Curves.bounceOut,
      overlayOpacity: 0.8,
      spacing: 5.0,
      spaceBetweenChildren: 5.0,
      onOpen: () => ShowToast("Pilih Perhitungan Kalori.."),
      onClose: () => ShowToast("Menutup.."),
      openCloseDial: isDialOpen,
      children: [
        SpeedDialChild(
            child: Icon(
              FontAwesomeIcons.camera,
              color: Styles.mainBlueColor,
            ),
            label: 'Kamera',
            labelStyle: Styles.fabText1,
            onTap: () => ShowToast("Memilih Kamera...")),
        SpeedDialChild(
            child: Icon(FontAwesomeIcons.spoon, color: Styles.mainBlueColor),
            label: 'Spoonycal',
            labelStyle: Styles.fabText1,
            onTap: () => ShowToast("Memilih Spoonycal...")),
      ],
    );
  }
}
