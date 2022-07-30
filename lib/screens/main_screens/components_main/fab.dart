import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tugasakhir_app/screens/camera/webview.dart';
import 'package:tugasakhir_app/screens/camera_screens/takepicture.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

// don't forget this line
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:webview_pro_android/webview_android.dart';
import 'dart:io' show Platform;

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
    Future<void> useCamera() async {
      WidgetsFlutterBinding.ensureInitialized();

      // Obtain a list of the available cameras on the device.
      final cameras = await availableCameras();

      // Get a specific camera from the list of available cameras.
      final firstCamera = cameras.first;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(
                  // Pass the appropriate camera to the TakePictureScreen widget.
                  camera: firstCamera,
                )),
      );
    }

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
      openCloseDial: isDialOpen,
      children: [
        SpeedDialChild(
            child: Icon(
              FontAwesomeIcons.camera,
              color: Styles.mainBlueColor,
            ),
            label: 'Kamera',
            labelStyle: Styles.fabText1,
            onTap: () {
              ShowToast("Memilih Kamera...");
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: const Text(
                          'Perhatian',
                          style: Styles.outfitDialogText3,
                          textAlign: TextAlign.center,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Pastikan makanan yang anda foto harus :',
                              style: Styles.outfitDialogText4,
                            ),
                            Text(
                              '- Memiliki cahaya yang cukup',
                              style: Styles.outfitDialogText4,
                            ),
                            Text(
                              '- Dapat mendeteksi keseluruhan makanan',
                              style: Styles.outfitDialogText4,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'KEMBALI',
                                style: Styles.outfitDialogTidakText5,
                              )),
                          TextButton(
                              onPressed: () {
                                // useCamera();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ObjectDetectionWebview()));
                              },
                              child: const Text('DIMENGERTI',
                                  style: Styles.outfitDialogYaText6)),
                        ],
                      ));
            }),
        SpeedDialChild(
            child: Icon(FontAwesomeIcons.spoon, color: Styles.mainBlueColor),
            label: 'Spoonycal',
            labelStyle: Styles.fabText1,
            onTap: () {
              ShowToast("Memilih Spoonycal...");
              Navigator.pushNamed(context, '/pairing_device_screen');
            }),
      ],
    );
  }
}

class FabProfile extends StatefulWidget {
  const FabProfile({Key? key}) : super(key: key);

  @override
  State<FabProfile> createState() => _FabProfileState();
}

class _FabProfileState extends State<FabProfile> {
  final isDialOpen = ValueNotifier(false);
  Future ShowToast(String message) async {
    await Fluttertoast.cancel();

    Fluttertoast.showToast(
        msg: message, fontSize: 15, backgroundColor: Colors.blueGrey[800]);
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: FontAwesomeIcons.save,
      animatedIconTheme: IconThemeData(size: 25.0),
      backgroundColor: Styles.mainBlueColor,
      overlayOpacity: 0.8,
      openCloseDial: isDialOpen,
      onPress: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Styles.buttonAuthBg,
          content: Text("Data berhasil disimpan (belum post patch)"))),
    );
  }
}



class ObjectDetectionWebview extends StatefulWidget {
  const ObjectDetectionWebview({Key? key}) : super(key: key);

  @override
  State<ObjectDetectionWebview> createState() => _ObjectDetectionWebviewState();
}

class _ObjectDetectionWebviewState extends State<ObjectDetectionWebview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deteksi Makanan'),
      ),
      body: const SizedBox(
          width: double.infinity,
          // the most important part of this example
          child: WebView(
            initialUrl: 'https://hf.space/embed/dblitzz21/food-spoonycal/+',

            // Enable Javascript on WebView
            javascriptMode: JavascriptMode.unrestricted,
            gestureNavigationEnabled: true,
          )),
    );
  }
}