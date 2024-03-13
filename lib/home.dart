import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'; //You can also import the browser version
import 'package:web3dart/web3dart.dart';
import 'package:quickalert/quickalert.dart';
import 'dart:io';

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

  ///to get
  // Replace with placeholders (refer to security note above)
  final String infuraEndpoint =
      'https://sepolia.infura.io/v3/4887f9655ec94842a2d3206deae69ad2'; // Replace with actual endpoint
  final String infuraApiKey =
      '4887f9655ec94842a2d3206deae69ad2'; // Replace with actual API key
  final String contractAddress = '0xc691a5f193883bE1Ef4d03f0c7f60De8B88913A3';

  Future<void> getbalance() async {
    var ethClient = Web3Client(apiUrl, httpClient);
    var address = credentials.address;
    EtherAmount balance = await ethClient.getBalance(address);
    print(balance.getValueInUnit(EtherUnit.ether));
  }

  ///function begin

  ///to get json from firebase

  Future<String> getnamejson() async {
    final ref = FirebaseStorage.instance.ref('c/namecontract.json');
    final bytes = await ref.getData();
    final jsonString = utf8.decode(bytes!);
    return (jsonString);
  }

  Future<String> nameagejson() async {
    final ref = FirebaseStorage.instance.ref('c/agecontract.json');
    final bytes = await ref.getData();
    final jsonString = utf8.decode(bytes!);
    return (jsonString);
  }

  Future<String> getmyjson() async {
    final ref = FirebaseStorage.instance.ref('c/contract.json');
    final bytes = await ref.getData();
    final jsonString = utf8.decode(bytes!);
    return (jsonString);
  }

  ///end
  /// function
  /// new try

  //late Web3Client ethClient;

// Ethereum address
  final String myAddress = "0x3C3f0990BAcd02C0ed689bf4Dd6CE18cD3D6A0bF";

// URL from Infura
  final String blockchainUrl =
      "https://sepolia.infura.io/v3/4887f9655ec94842a2d3206deae69ad2";

  Future<DeployedContract> getContract() async {
    String contractAddress = "0xc691a5f193883bE1Ef4d03f0c7f60De8B88913A3";
    // Obtain our smart contract using rootbundle to access our json file
    /* String abiFile = await rootBundle.loadString("assets/contract.json");

    final contract = DeployedContract(ContractAbi.fromJson(abiFile, "Voting"),
        EthereumAddress.fromHex(contractAddress));*/
    final abiFile = await getjson();
    final contract = DeployedContract(ContractAbi.fromJson(abiFile, 'Voting'),
        EthereumAddress.fromHex(contractAddress));
    print("payyya");
    return contract;

    return contract;
  }

  ///functions to get contracts
  Future<DeployedContract> getnamecontract() async {
    String contractAddress = "0x3787D8F37054cf954c02eAF65C8b37FB97946de5";

    final abiFile = await getnamejson();
    final namecontract = DeployedContract(
        ContractAbi.fromJson(abiFile, 'Voting'),
        EthereumAddress.fromHex(contractAddress));
    print("payyya");
    return namecontract;
  }

  Future<DeployedContract> getagecontract() async {
    String contractAddress = "0xd34780b7c47de1Cb09E81D4e9dE74a78CC821291";

    final abiFile = await nameagejson();
    final agecontract = DeployedContract(
        ContractAbi.fromJson(abiFile, 'Voting'),
        EthereumAddress.fromHex(contractAddress));
    print("payyya");
    return agecontract;
  }

  ///contract functions end

  Future<List<dynamic>> callFunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getContract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    print(result);
    return result;
  }

  Future<String> newfunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getContract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    String lg = result.toString();
    print(lg);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: '$lg!',
      autoCloseDuration: const Duration(seconds: 4),
      showConfirmBtn: false,
    );
    return lg;
  }

  ///for name

  /* Future<DeployedContract> getnamecontract() async {
    // Obtain our smart contract using rootbundle to access our json file
    String abiFile = await getnamejson();

    String contractAddress = "0x3787D8F37054cf954c02eAF65C8b37FB97946de5";

    final namecontract = DeployedContract(
        ContractAbi.fromJson(abiFile, "Voting"),
        EthereumAddress.fromHex(contractAddress));

    return namecontract;
  }*/
  late String newname;
  Future<List<dynamic>> callnameFunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getnamecontract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    print(result);
    if (result.length == 1 && result[0] is String) {
      newname = result[0] as String;
    } else {
      newname = 'Result is not a string.';
    }
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: '$newname',
      autoCloseDuration: const Duration(seconds: 4),
      showConfirmBtn: false,
    );
    return result;
  }

  late String values;
  Future<List<dynamic>> callagefunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getagecontract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    print(result);
    if (result.length == 1 && result[0] is String) {
      values = result[0] as String;
    } else {
      values = 'Result is not a string.';
    }
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: '$values',
      autoCloseDuration: const Duration(seconds: 4),
      showConfirmBtn: false,
    );
    return result;
  }

  /* late String newvalue;
  Future<String> namefunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getnamecontract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    //to remove the []
    if (result.length == 1 && result[0] is String) {
      newvalue = result[0] as String;
    } else {
      newvalue = 'Result is not a string.';
    }
    String lg = result.toString();
    print(lg);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: '$newvalue',
      autoCloseDuration: const Duration(seconds: 4),
      showConfirmBtn: false,
    );
    return lg;
  }*/

  ///name end
  ///
  /// name and age contract

  Future<List<dynamic>> callageFunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getagecontract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    print(result);
    return result;
  }

  late String newvalue2;
  Future<String> agefunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getagecontract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    //to remove the []
    if (result.length == 1 && result[0] is String) {
      newvalue2 = result[0] as String;
    } else {
      newvalue2 = 'Result is not a string.';
    }
    String lg = result.toString();
    print(lg);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: '$newvalue2',
      autoCloseDuration: const Duration(seconds: 4),
      showConfirmBtn: false,
    );
    return lg;
  }

  ///end

  Future<void> loadJsonFromFirebase() async {
    final ref = FirebaseStorage.instance.ref('c/contract.json');
    final bytes = await ref.getData();
    final jsonString = utf8.decode(bytes!);
    print(jsonString);
  }

  Future<String> getjson() async {
    final ref = FirebaseStorage.instance.ref('c/contract.json');
    final bytes = await ref.getData();
    final jsonString = utf8.decode(bytes!);
    return (jsonString);
  }

  /* Future<DeployedContract> getagecontract() async {
    // Obtain our smart contract using rootbundle to access our json file
    String abiFile = await getjson();

    String contractAddress = "0xd34780b7c47de1Cb09E81D4e9dE74a78CC821291";

    final agecontract = DeployedContract(
        ContractAbi.fromJson(abiFile, "Voting"),
        EthereumAddress.fromHex(contractAddress));

    return agecontract;
  }*/

/*
  @override
  void initState() {
    super.initState();

  }*/
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
                  ElevatedButton(
                      onPressed: () {
                        getbalance();
                        //callFunction("get_output");
                        newfunction("get_output");
                      },
                      child: Text('First')),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        callnameFunction("getname");
                      },
                      child: Text('Name')),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        //  agefunction("getname");
                        callagefunction("getname");
                      },
                      child: Text('Name ')),
                  ElevatedButton(
                      onPressed: () {
                        //  agefunction("getdob");

                        callagefunction("getdob");
                      },
                      child: Text(' Birthday')),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'working!',
                          autoCloseDuration: const Duration(seconds: 4),
                          showConfirmBtn: false,
                        );
                      },
                      child: Text('alert test')),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        loadJsonFromFirebase();
                      },
                      child: Text('Json Test')),
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
