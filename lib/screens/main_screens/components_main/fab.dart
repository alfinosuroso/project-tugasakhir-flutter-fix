import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tugasakhir_app/styles.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

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
    // Future<void> useCamera() async {
    //   WidgetsFlutterBinding.ensureInitialized();

    //   // Obtain a list of the available cameras on the device.
    //   final cameras = await availableCameras();

    //   // Get a specific camera from the list of available cameras.
    //   final firstCamera = cameras.first;

    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => TakePictureScreen(
    //               // Pass the appropriate camera to the TakePictureScreen widget.
    //               camera: firstCamera,
    //             )),
    //   );
    // }
    Future<void> useCamera() async {
      WidgetsFlutterBinding.ensureInitialized();
      // PERMISSION //
      await Permission.camera.request();
      await Permission.microphone.request();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectDetectionWebview()),
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
                                useCamera();
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             ObjectDetectionWebview()));
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
          title: Text(
            "Deteksi Makanan",
            style: Styles.shareTitleAppbarText13,
          ),
          backgroundColor: Styles.appBarPrimaryColor,
        ),
        body: Center(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    "https://hf.space/embed/dblitzz21/food-spoonycal/+")),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
