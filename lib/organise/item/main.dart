import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../big_button.dart';
import './item_name.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class OrganiseItemPageState extends State<OrganiseItemPage> {
  String containerID;

  OrganiseItemPageState({required this.containerID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dodawanie przedmiotu"),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BigButton(
              title: "Zeskanuj kod kreskowy",
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    "#000000", "Cancel", true, ScanMode.DEFAULT);

                if (barcodeScanRes != '-1') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemName(
                              type: 'barcode',
                              containerID: containerID,
                              itemBarcode: barcodeScanRes)));
                }
              },
              image: Icons.photo_camera,
              description:
                  "Twój przedmiot ma już własny kod kreskowy? Zeskanuj go aby dodać do aplikacj!",
              buttonText: 'Skanuj',
              iconColor: const Color(0xffffa6a6),
            ),
            BigButton(
              title: "Wygeneruj kod QR",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ItemName(type: 'qr', containerID: containerID)));
              },
              image: Icons.brush,
              description:
                  "Twój przedmiot nie ma kodu QR? Bez obaw! Nasza aplikacja stworzy kod dla Ciebie!",
              buttonText: 'Stwórz',
              iconColor: const Color(0xFFE59BFF),
            ),
          ],
        ),
      ),
    );
  }
}

class OrganiseItemPage extends StatefulWidget {
  final String containerID;

  const OrganiseItemPage({Key? key, required this.containerID})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  OrganiseItemPageState createState() => OrganiseItemPageState(
        containerID: containerID,
      );
}
