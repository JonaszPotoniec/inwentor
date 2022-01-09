import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
import 'package:flutter/src/widgets/text.dart' as Text;
import 'package:flutter/src/material/colors.dart' as Colors;
import './qr_result.dart';

class ContainerNameState extends State<ContainerName> {
  emojiPicker.Emoji emoji;

  ContainerNameState({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.Text("Nazwanie pojemnika"),
        backgroundColor: Colors.Colors.grey[900],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            autofocus: true,
            textInputAction: TextInputAction.go,
            onSubmitted: (val) {
              if (val.isNotEmpty) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QrResult(emoji: emoji, containerName: val)),
                    (Route<dynamic> route) => route.isFirst);
              } else {
                var snackBar = const SnackBar(
                  content: Text.Text('Podaj nazwę!'),
                  backgroundColor: Colors.Colors.deepOrange,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            decoration: InputDecoration(
                labelText: 'Nazwa pojemnika',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                helperText:
                    'Co planujesz trzymać w pojemniku (nazwa pojemnika)?'),
          ),
        ),
      ),
    );
  }
}

class ContainerName extends StatefulWidget {
  final emojiPicker.Emoji emoji;

  const ContainerName({Key? key, required this.emoji}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ContainerNameState createState() => ContainerNameState(
        emoji: emoji,
      );
}
