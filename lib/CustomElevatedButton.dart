import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomElevatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String buttonText;
  CustomElevatedButton({Key? key, this.onPressed, required this.buttonText});

  @override
  _CustomElevatedButton createState() => _CustomElevatedButton();
}

class _CustomElevatedButton extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      onPressed: widget.onPressed,
      child: Text(widget.buttonText),
    );
  }
}
