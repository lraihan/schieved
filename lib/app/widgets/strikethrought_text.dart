import 'package:flutter/material.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:schieved/app/data/themes/color_themes.dart';

class StrikethroughtText extends StatefulWidget {
  final String text;
  const StrikethroughtText({super.key, required this.text});

  @override
  State<StrikethroughtText> createState() => _StrikethroughtTextState();
}

class _StrikethroughtTextState extends State<StrikethroughtText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: StrikethroughPainter(_animation.value, context, widget.text),
          child: Container(),
        );
      },
    );
  }
}

class StrikethroughPainter extends CustomPainter {
  final String text;
  final double progress;
  final BuildContext context;

  StrikethroughPainter(this.progress, this.context, this.text);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      maxLines: 1,
      text: textSpan,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: screenWidth(context) * .77);

    const double startX = 0;
    final double endX = textPainter.width * progress;
    final double y = textPainter.height;

    final Paint paint = Paint()
      ..color = blackColor.shade200
      ..strokeWidth = 1.0;

    canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
