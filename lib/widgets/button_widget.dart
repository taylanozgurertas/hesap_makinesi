import 'package:flutter/material.dart';

class ButonWidget extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const ButonWidget({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
