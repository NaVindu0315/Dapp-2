import 'package:flutter/material.dart';

class Volume extends StatefulWidget {
  const Volume({Key? key}) : super(key: key);

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
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
                Text(
                  'Volume Detection',
                  style: TextStyle(fontSize: 30.0),
                ),
                Spacer(),
              ],
            ),
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {},
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
