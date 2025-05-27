import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        if (onPressed != null) {
          onPressed!();
        } else {
          context.pop();
        }
      },
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.white.withValues(alpha: .7),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 10,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Icon(
          Icons.arrow_back,
          size: 24,
          color: Color(0xFF17563C),
        ),
      ),
    );
  }
}
