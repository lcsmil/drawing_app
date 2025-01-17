import 'package:drawing_app/src/features/drawing/presentation/controller/drawing_controller.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_color_tokens.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EraserButtonWidget extends StatelessWidget {
  final bool isEraserMode;

  const EraserButtonWidget({super.key, required this.isEraserMode});

  @override
  Widget build(BuildContext context) {
    final isEraserSelected = isEraserMode;

    return Container(
      margin: const EdgeInsets.all(DrawingConstants.margin4),
      decoration: BoxDecoration(
        border: Border.all(
          color: isEraserSelected
              ? DrawingColorTokens.black
              : DrawingColorTokens.transparent,
          width: DrawingConstants.width3,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.highlight_remove),
        onPressed: () {
          context.read<DrawingController>().toggleEraser();
        },
      ),
    );
  }
}
