import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  /// function
  /// new try

  //late Web3Client ethClient;

// Ethereum address
  final String myAddress = "0x3C3f0990BAcd02C0ed689bf4Dd6CE18cD3D6A0bF";

// URL from Infura
  final String blockchainUrl =
      "https://sepolia.infura.io/v3/4887f9655ec94842a2d3206deae69ad2";
  Future<DeployedContract> getContract() async {
    // Obtain our smart contract using rootbundle to access our json file
    String abiFile = await rootBundle.loadString("assets/contract.json");

    String contractAddress = "0xc691a5f193883bE1Ef4d03f0c7f60De8B88913A3";

    final contract = DeployedContract(ContractAbi.fromJson(abiFile, "Voting"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> callFunction(String name) async {
    final pakeclient = Web3Client(blockchainUrl, httpClient);
    final contract = await getContract();
    final function = contract.function(name);
    final result = await pakeclient
        .call(contract: contract, function: function, params: []);
    print(result);
    return result;
  }

/*
//me helo eka hri gye na

  Future<void> gethello() async {
    List<dynamic> resultsA = await callFunction("getTotalVotesAlpha");
    // List<dynamic> resultsB = await callFunction("getTotalVotesBeta");
    String work = (await callFunction("get_output")) as String;
    print(work);
    setState(() {});
  }
*/
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
                    style: TextStyle(fontSize: 15.0),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        getbalance();
                        callFunction("get_output");
                      },
                      child: Text('Test')),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Balance',
                    style: TextStyle(fontSize: 15.0),
                  ),
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
