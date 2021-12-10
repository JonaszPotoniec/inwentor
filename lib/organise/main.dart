import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../big_button.dart';
import 'choose_emoji.dart';

class OrganisePage extends StatelessWidget {
  const OrganisePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Organizacja"),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            BigButton(
              title: "Dodaj do istniejącego",
              onPressed: () {},
              image: Icons.file_download_outlined,
              description:
                  "Wybierz tę opcję jeśli masz już utworzone pudełka i chcesz coś do nich dodać",
              buttonText: 'Dodaj',
              iconColor: const Color(0xffffa6a6),
            ),
            BigButton(
              title: "Stwórz nowe",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChooseEmoji()));
              },
              image: Icons.brush,
              description:
                  "Zacznij tutaj jeśli nie masz jeszcze skonfigurowanych pudełek",
              buttonText: 'Stwórz',
              iconColor: const Color(0xFFE59BFF),
            ),
          ],
        ),
      ),
    );
  }
}
