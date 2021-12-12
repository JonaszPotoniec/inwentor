import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
import 'package:flutter/src/widgets/text.dart' as Text;
import 'package:flutter/src/material/colors.dart' as Colors;
import './qr_result.dart';

class ItemNameState extends State<ItemName> {
  String type;
  String containerID;
  String? itemBarcode;

  ItemNameState(
      {required this.type, required this.containerID, this.itemBarcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.Text("Nazwanie przedmiotu"),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrResult(
                            containerName: val,
                            type: type,
                            containerID: containerID,
                            itemBarcode: itemBarcode)));
              } else {
                var snackBar = const SnackBar(
                  content: Text.Text('Podaj nazwę!'),
                  backgroundColor: Colors.Colors.deepOrange,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            decoration: InputDecoration(
                labelText: 'Nazwa przedmiotu',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                helperText:
                    'Podaj nazwę przedmiotu, który chcesz schować do pojemnika'),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemName extends StatefulWidget {
  final String type;
  final String containerID;
  String? itemBarcode;

  ItemName(
      {Key? key,
      required this.type,
      required this.containerID,
      this.itemBarcode})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  ItemNameState createState() => ItemNameState(
      type: type, itemBarcode: itemBarcode, containerID: containerID);
}
