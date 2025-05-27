import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:advance_todo/presentations/widgets/custom_back_button.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title, this.hideBackButton = false, this.onPressed});

  final String title;
  final bool hideBackButton;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(20, statusBarHeight, 20, 0),
      decoration: BoxDecoration(
        borderRadius: !hideBackButton ?  const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ) : null ,
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFFD7E0FF),
            Color(0xFF9AEEFF),
            Color(0xFFD9FFFA),
          ],
          stops: <double>[0.25, 0.5, 0.8],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 12),
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              if (!hideBackButton)
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomBackButton(onPressed: onPressed),
                ),
              Text(
                title,
                style: AppFonts.h3(),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
