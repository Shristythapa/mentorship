import 'package:flutter/material.dart';

class FlashingText extends StatefulWidget {
  final String text;
  const FlashingText({Key? key, required this.text}) : super(key: key);

  @override
  _FlashingTextState createState() => _FlashingTextState();
}

class _FlashingTextState extends State<FlashingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.fromLTRB(35, 15, 0, 2),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 15,
              color: Colors.purple.withOpacity(_controller.value),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
