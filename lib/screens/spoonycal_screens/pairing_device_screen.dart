import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tugasakhir_app/styles.dart';

class PairingDeviceScreen extends StatelessWidget {
  const PairingDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Styles.blueBackButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.77,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Sambungkan Spoonycal Anda",
                  style: Styles.outfitTextPairing3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.wifi_find,
                                color: Styles.buttonAuthBg),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "Nyalakan Hotspot pada Smartphone Anda",
                            style: Styles.latoPairing1,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          const Text(
                            "SSID : SPOONYCAL",
                            style: Styles.latoPairing1,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                          const Text(
                            "PASSWORD : SPOONYCAL",
                            style: Styles.latoPairing1,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ]),
                        
                  ),
                  
                ),
                const SizedBox(
                  height: 20.0,
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(
                            0.0,
                            3.0,
                          ),
                          blurRadius: 6.0,
                          spreadRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.spoon,
                                color: Styles.buttonAuthBg),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            "Pastikan spoonycal anda sudah aktif",
                            style: Styles.latoPairing1,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ]),
                        
                  ),
                  
                ),

                const SizedBox(
                  height: 20.0,
                ),

                ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff45625d)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(const Color(0xFF4FCAB4)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ))),
                onPressed: () => Navigator.pushNamed(context, '/search_screen'),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Perangkat sudah tersambung",
                    style: Styles.latoPairing3,
                    textAlign: TextAlign.center,
                  ),
                )),

                TextButton(onPressed: () => Navigator.pop(context), child: const Text(
                    "Tidak Sekarang",
                    style: Styles.latoPairing4,
                    textAlign: TextAlign.center,
                  ),)
              ]),
        ),
      ),
    );
  }
}
