import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String text;
  const BoldText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(20),
      width: width * 0.9,
      height: height * 0.8,
      color: Colors.red,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}
