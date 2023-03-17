import 'package:flutter/material.dart';
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)=>FloatingActionButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(9))),

      hoverColor: Colors.white,
      child: Text(text),
      onPressed: onClicked
  );
}
