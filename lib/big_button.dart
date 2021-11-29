import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:decorated_icon/decorated_icon.dart';

class BigButtonState extends State<BigButton> {
  String title;
  String description;
  IconData image;
  String buttonText;
  Color iconColor;
  GestureTapCallback onPressed;

  BigButtonState(
      {required this.title,
      required this.description,
      required this.image,
      required this.buttonText,
      required this.iconColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    print(onPressed);
    return Container(
      margin: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(35), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 0,
          blurRadius: 4,
          offset: Offset(0, 4), // changes position of shadow
        ),
      ]),
      child: RawMaterialButton(
        fillColor: Colors.grey[900],
        splashColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 6),
                    Text(
                      description,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: onPressed,
                      child: Text(buttonText,
                          style: const TextStyle(color: Colors.white)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1.0, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              DecoratedIcon(
                image,
                color: iconColor,
                size: 117,
                shadows: [
                  const BoxShadow(
                    color: Colors.black,
                    offset: Offset(3.0, 3.0),
                  )
                ],
              ),
            ],
          ),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class BigButton extends StatefulWidget {
  final String title;
  final String description;
  final IconData image;
  final String buttonText;
  final Color iconColor;
  final GestureTapCallback onPressed;

  const BigButton(
      {Key? key,
      required this.title,
      required this.description,
      required this.image,
      required this.buttonText,
      required this.iconColor,
      required this.onPressed})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  BigButtonState createState() => BigButtonState(
      // ignore: unnecessary_this
      title: this.title,
      // ignore: unnecessary_this
      onPressed: this.onPressed,
      // ignore: unnecessary_this
      image: this.image,
      // ignore: unnecessary_this
      description: this.description,
      buttonText: this.buttonText,
      iconColor: this.iconColor);

  // const BigButton(
  //     {required this.title,
  //     required this.description,
  //     required this.image,
  //     required this.onPressed});
}
