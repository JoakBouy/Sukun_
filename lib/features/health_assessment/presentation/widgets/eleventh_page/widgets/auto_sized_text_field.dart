import 'package:flutter/material.dart';

class AutoSizedTextField extends StatefulWidget {
  const AutoSizedTextField({
    super.key,
    required this.controller,
    required this.focusNode,
  });
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  AutoSizedTextFieldState createState() => AutoSizedTextFieldState();
}

class AutoSizedTextFieldState extends State<AutoSizedTextField> {
  String _text = "";

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _text = widget.controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
    final textWidth =
        _text.isEmpty
            ? 20.0
            : (TextPainter(
                  text: TextSpan(text: _text, style: textStyle),
                  maxLines: 1,
                  textDirection: TextDirection.ltr,
                )..layout()).width +
                20; // Padding for cursor

    return SizedBox(
      width: textWidth,
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        style: textStyle,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          border: UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
