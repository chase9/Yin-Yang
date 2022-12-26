import 'package:flutter/material.dart';

/* MyButton Custom Widget */
class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.label});

  final GestureTapCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.greenAccent,
      splashColor: Colors.grey,
      onPressed: onPressed,
      shape: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Text(label)],
        ),
      ),
    );
  }
}
