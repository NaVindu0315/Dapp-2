import 'package:flutter/material.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var apiUrl =
      "https://sepolia.infura.io/v3/4887f9655ec94842a2d3206deae69ad2"; //Replace with your API

  var httpClient = Client();

  var credentials = EthPrivateKey.fromHex(
      "bdb3d39f69282abbce39e6d834b762a6ab093d97b94411f018b1fe607ea017e6");

  Future<void> getbalance() async {
    var ethClient = Web3Client(apiUrl, httpClient);
    var address = credentials.address;
    EtherAmount balance = await ethClient.getBalance(address);
    print(balance.getValueInUnit(EtherUnit.ether));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Text(
                    'HI',
                    style: TextStyle(fontSize: 30.0),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getbalance();
                      },
                      child: Text('Test')),
                  Spacer(),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
