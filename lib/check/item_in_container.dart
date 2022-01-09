import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:decorated_icon/decorated_icon.dart';
import 'package:inwentor/database/db.dart';

class ItemInContainer extends StatelessWidget {
  ItemInContainer(
      {required this.name, required this.itemId, required this.refresh});

  final String name;
  final String itemId;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      child: Row(
        children: <Widget>[
          Text(
            "• " + name,
            maxLines: 1,
            style: const TextStyle(
                color: Color.fromRGBO(38, 50, 56, 1),
                fontSize: 16,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            child: const Text("Usuń przedmiot",
                style: TextStyle(color: Colors.black)),
            onPressed: () async {
              WidgetsFlutterBinding.ensureInitialized();
              final db = DatabaseHelper();
              await db.deleteItem(itemId);
              Navigator.pop(context);
              refresh();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0))),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
