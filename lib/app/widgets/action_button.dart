import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';

// ignore: must_be_immutable
class ActionButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final bool? enabled;
  final Color color;
  final Color? textColor;
  double? height;
  double? width;

  ActionButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.height,
      this.width,
      required this.color,
      this.enabled,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    height ??= screenHeight(context) * .055;
    width ??= screenWidth(context) * .35;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: TextButton(
        style: ButtonStyle(
            fixedSize: WidgetStateProperty.resolveWith((states) => Size(width!, height!)),
            backgroundColor: enabled ?? true
                ? WidgetStateColor.resolveWith((states) => color)
                : WidgetStateColor.resolveWith((states) => primaryColor)),
        onPressed: () {
          if (enabled ?? true) {
            onPressed();
          }
        },
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.01, vertical: screenHeight(context) * 0.005),
          child: AutoSizeText(
            label,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: textColor ?? whiteColor),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
