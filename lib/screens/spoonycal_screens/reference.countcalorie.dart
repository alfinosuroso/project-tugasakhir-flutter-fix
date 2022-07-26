import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tugasakhir_app/model/calorie_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

const String esp_url = 'ws://192.168.207.73:81';

class ReferenceCountCalorie extends StatelessWidget {
  const ReferenceCountCalorie({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DHT11 eps-websocket-flutter',
      home: MyHomePage(title: 'Tes Suhu Realtime'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoaded = false;
  String msg = '';
  CalorieModel dht = CalorieModel(0, 0);
  final channel = IOWebSocketChannel.connect(esp_url);
  @override
  void initState() {
    super.initState();

    channel.stream.listen(
      (message) {
        channel.sink.add('Flutter received $message');
        if (message == "connected") {
          print('Received from MCU: $message');
          setState(() {
            msg = message;
          });
        } else {
          print('Received from MCU: $message');
          // {'tempC':'30.50','humi':'64.00'}
          Map<String, dynamic> json = jsonDecode(message);
          setState(() {
            dht = CalorieModel.fromJson(json);
            isLoaded = true;
          });
        }
        //channel.sink.close(status.goingAway);
      },
      onDone: () {
        //if WebSocket is disconnected
        print("Web socket is closed");
        setState(() {
          msg = 'disconnected';
          isLoaded = false;
        });
      },
      onError: (error) {
        print(error.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: !isLoaded
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text('Kalibrasi: ',
                            style: TextStyle(fontSize: 50, color: Colors.blue)),
                        Text(
                          '${dht.tempC.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 50, color: Colors.blue),
                        ),
                        Text(
                          '%',
                          style: TextStyle(fontSize: 30, color: Colors.blue),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text('Berat: ',
                            style: TextStyle(fontSize: 50, color: Colors.blue)),
                        Text(
                          '${dht.humi.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 50, color: Colors.blue),
                        ),
                        Text(
                          ' gr',
                          style: TextStyle(fontSize: 20, color: Colors.blue),
                        )
                      ],
                    )
                  ],
                )),
    );
  }
}
