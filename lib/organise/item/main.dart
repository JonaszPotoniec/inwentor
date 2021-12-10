import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../big_button.dart';
import './item_name.dart';

class OrganiseItemPage extends StatelessWidget {
  const OrganiseItemPage({Key? key}) : super(key: key);

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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ItemName(
                              type: 'barcode',
                            )));
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
                        builder: (context) => const ItemName(type: 'qr')));
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
