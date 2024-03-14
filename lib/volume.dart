import 'dart:async';

import 'package:dapp2/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';

class Volume extends StatefulWidget {
  const Volume({Key? key}) : super(key: key);

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  StreamSubscription<HardwareButton>? subscription;
  @override
  void initState() {
    super.initState();
  }

  void startListening() {
    subscription = FlutterAndroidVolumeKeydown.stream.listen((event) {
      if (event == HardwareButton.volume_down) {
        print("Volume down received");
      } else if (event == HardwareButton.volume_up) {
        print("Volume up received");
      }
    });
  }

  void stopListening() {
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Spacer(),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                    onPressed: startListening,
                    child: const Text("Start listsening")),
                ElevatedButton(
                    onPressed: stopListening,
                    child: const Text("Stop listening")),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  child: Text(
                    'Volume Detection',
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
