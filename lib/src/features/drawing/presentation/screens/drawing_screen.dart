import 'package:drawing_app/src/features/drawing/presentation/controller/drawing_controller.dart';
import 'package:drawing_app/src/features/drawing/presentation/widgets/color_button_widget.dart';
import 'package:drawing_app/src/features/drawing/presentation/widgets/drawing_painter_widget.dart';
import 'package:drawing_app/src/features/drawing/presentation/widgets/eraser_button_widget.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_color_tokens.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_constants.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_icon_assets.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_messages.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_svg_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shake_gesture/shake_gesture.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({super.key});

  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  double scaleFactor = DrawingConstants.scaleFactor;
  final TransformationController _transformationController =
      TransformationController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ShakeGesture.registerCallback(
      onShake: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(DrawingMessages.shakePhone),
            action: SnackBarAction(
                label: DrawingMessages.confirm,
                onPressed: () => context.read<DrawingController>().clear()),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(DrawingMessages.appName),
        actions: [
          const Text(DrawingMessages.tapToSelectMode),
          IconButton(
            icon: Icon(
              context.read<DrawingController>().isDrawingMode
                  ? DrawingIconAssets.brush
                  : DrawingIconAssets.zoomOutMap,
            ),
            onPressed: () {
              context.read<DrawingController>().toggleMode();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              scaleEnabled: !context.read<DrawingController>().isDrawingMode,
              panEnabled: !context.read<DrawingController>().isDrawingMode,
              transformationController: _transformationController,
              child: IgnorePointer(
                ignoring: !context.read<DrawingController>().isDrawingMode,
                child: GestureDetector(
                  onPanStart: (details) {
                    if (context.read<DrawingController>().isDrawingMode) {
                      context
                          .read<DrawingController>()
                          .startStroke(details.localPosition);
                    }
                  },
                  onPanUpdate: (details) {
                    if (context.read<DrawingController>().isDrawingMode) {
                      context
                          .read<DrawingController>()
                          .addPoint(details.localPosition);
                    }
                  },
                  onPanEnd: (details) {
                    if (context.read<DrawingController>().isDrawingMode) {
                      context.read<DrawingController>().endStroke();
                    }
                  },
                  child: CustomPaint(
                    painter: DrawingPainterWidget(
                      strokes: context.watch<DrawingController>().strokes,
                      strokeColors:
                          context.watch<DrawingController>().strokeColors,
                      strokeWidth:
                          context.watch<DrawingController>().strokeWidth,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: context.read<DrawingController>().isDrawingMode,
              child: InteractiveViewer(
                maxScale: DrawingConstants.maxScale,
                transformationController: _transformationController,
                child: SvgPicture.asset(
                  DrawingSvgAssets.backgroundImage,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          scrollbarOrientation: ScrollbarOrientation.top,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ColorButtonWidget(
                  color: DrawingColorTokens.red,
                  currentColor: context.watch<DrawingController>().currentColor,
                  isEraseMode: context.watch<DrawingController>().isEraserMode,
                ),
                ColorButtonWidget(
                  color: DrawingColorTokens.green,
                  currentColor: context.watch<DrawingController>().currentColor,
                  isEraseMode: context.watch<DrawingController>().isEraserMode,
                ),
                ColorButtonWidget(
                  color: DrawingColorTokens.blue,
                  currentColor: context.watch<DrawingController>().currentColor,
                  isEraseMode: context.watch<DrawingController>().isEraserMode,
                ),
                ColorButtonWidget(
                  color: DrawingColorTokens.yellow,
                  currentColor: context.watch<DrawingController>().currentColor,
                  isEraseMode: context.watch<DrawingController>().isEraserMode,
                ),
                ColorButtonWidget(
                  color: DrawingColorTokens.orange,
                  currentColor: context.watch<DrawingController>().currentColor,
                  isEraseMode: context.watch<DrawingController>().isEraserMode,
                ),
                ColorButtonWidget(
                  color: DrawingColorTokens.black,
                  currentColor: context.watch<DrawingController>().currentColor,
                  isEraseMode: context.watch<DrawingController>().isEraserMode,
                ),
                EraserButtonWidget(
                  isEraserMode: context.watch<DrawingController>().isEraserMode,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
