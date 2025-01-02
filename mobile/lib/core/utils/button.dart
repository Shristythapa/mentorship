import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final VoidCallback onPressed;
  String buttonName;

  Button({
    required this.buttonName,
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          widget.onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 146, 114, 174),
          foregroundColor: const Color.fromARGB(255, 230, 211, 239),
        ),
        child: Text(
          widget.buttonName,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
