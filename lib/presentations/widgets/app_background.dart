import 'package:flutter/material.dart';


class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      // key: Provider.of<ThemeManager>(context).key,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFFF1CAC2),
            Color(0xFFFDFBF3),
            Color(0xFFE2FDF9),
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: <double>[0, 0.28, 0.8],
        ),
      ),
      child: child,
    );
  }
}
