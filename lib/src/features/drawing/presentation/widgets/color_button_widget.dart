import 'package:drawing_app/src/features/drawing/presentation/controller/drawing_controller.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_color_tokens.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColorButtonWidget extends StatelessWidget {
  final Color color;
  final Color currentColor;
  final bool isEraseMode;

  const ColorButtonWidget({
    super.key,
    required this.color,
    required this.currentColor,
    required this.isEraseMode,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentColor == color && !isEraseMode;

    return Container(
      margin: const EdgeInsets.all(DrawingConstants.margin4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? DrawingColorTokens.black
              : DrawingColorTokens.transparent,
          width: DrawingConstants.width3,
        ),
      ),
      child: IconButton(
        icon: Icon(Icons.circle, color: color),
        onPressed: () {
          context.read<DrawingController>().setColor(color);
        },
      ),
    );
  }
}
