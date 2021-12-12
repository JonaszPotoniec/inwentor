import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
import 'container_name.dart';

class ChooseEmoji extends StatelessWidget {
  const ChooseEmoji({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wybór ikonki"),
        backgroundColor: Colors.grey[900],
      ),
      body: Column(
        children: [Expanded(child: 
          emojiPicker.EmojiPicker(
            onEmojiSelected: (category, emoji) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContainerName(emoji: emoji)));
            },
            onBackspacePressed: () {
              // Backspace-Button tapped logic
              // Remove this line to also remove the button in the UI
            },
            config: emojiPicker.Config(
                columns: 7,
                emojiSizeMax: 32 *
                    (Platform.isIOS
                        ? 1.30
                        : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                verticalSpacing: 0,
                horizontalSpacing: 0,
                initCategory: emojiPicker.Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                progressIndicatorColor: Colors.blue,
                showRecentsTab: true,
                recentsLimit: 28,
                noRecentsText: "No Recents",
                noRecentsStyle:
                    const TextStyle(fontSize: 20, color: Colors.black26),
                categoryIcons: const emojiPicker.CategoryIcons(),
                buttonMode: emojiPicker.ButtonMode.MATERIAL),
          ),
        ),]
      ),
    );
  }
}
