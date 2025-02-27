import 'package:flutter/material.dart';

class LineDivider extends StatelessWidget {
  const LineDivider({super.key, this.margin});

  final EdgeInsets? margin;
  @override
  Widget build(BuildContext context) {
   return Container(
    height: 1,
    margin: margin,
    decoration: BoxDecoration(
      color: const Color(0xFFDFDFDF),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
    ),
   );
  }
}