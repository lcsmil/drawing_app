// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:shake_gesture/shake_gesture.dart';
//
// void main() {
//   runApp(const DrawingApp());
// }
//
// class DrawingApp extends StatelessWidget {
//   const DrawingApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => DrawingModel(),
//       child: const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: DrawingScreen(),
//       ),
//     );
//   }
// }
//
// class DrawingScreen extends StatefulWidget {
//   const DrawingScreen({super.key});
//
//   @override
//   State<DrawingScreen> createState() => _DrawingScreenState();
// }
//
// class _DrawingScreenState extends State<DrawingScreen> {
//   double scaleFactor = 0.8;
//   final TransformationController _transformationController =
//       TransformationController();
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     ShakeGesture.registerCallback(onShake: () {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: const Text('Shake Detected! Should it clear the drawing?'),
//           action: SnackBarAction(
//               label: 'Confirm',
//               onPressed: () => context.read<DrawingModel>().clear()),
//         ),
//       );
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Drawing App'),
//         actions: [
//           const Text('Tap to select mode: '),
//           IconButton(
//             icon: Icon(context.read<DrawingModel>().isDrawingMode
//                 ? Icons.brush
//                 : Icons.zoom_out_map),
//             onPressed: () {
//               context.read<DrawingModel>().toggleMode();
//             },
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: InteractiveViewer(
//               scaleEnabled: !context.read<DrawingModel>().isDrawingMode,
//               panEnabled: !context.read<DrawingModel>().isDrawingMode,
//               transformationController: _transformationController,
//               child: IgnorePointer(
//                 ignoring: !context.read<DrawingModel>().isDrawingMode,
//                 child: GestureDetector(
//                   onPanStart: (details) {
//                     if (context.read<DrawingModel>().isDrawingMode) {
//                       context
//                           .read<DrawingModel>()
//                           .startStroke(details.localPosition);
//                     }
//                   },
//                   onPanUpdate: (details) {
//                     if (context.read<DrawingModel>().isDrawingMode) {
//                       context
//                           .read<DrawingModel>()
//                           .addPoint(details.localPosition);
//                     }
//                   },
//                   onPanEnd: (details) {
//                     if (context.read<DrawingModel>().isDrawingMode) {
//                       context.read<DrawingModel>().endStroke();
//                     }
//                   },
//                   child: CustomPaint(
//                     painter: DrawingPainter(context.watch<DrawingModel>()),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: IgnorePointer(
//               ignoring: context.read<DrawingModel>().isDrawingMode,
//               child: InteractiveViewer(
//                 maxScale: 4.0,
//                 transformationController: _transformationController,
//                 child: SvgPicture.asset(
//                   'assets/town_scape.svg',
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomAppBar(
//         child: Scrollbar(
//           controller: _scrollController,
//           thumbVisibility: true,
//           scrollbarOrientation: ScrollbarOrientation.top,
//           child: SingleChildScrollView(
//             controller: _scrollController,
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 _buildColorButton(context, Colors.red),
//                 _buildColorButton(context, Colors.green),
//                 _buildColorButton(context, Colors.blue),
//                 _buildColorButton(context, Colors.yellow),
//                 _buildColorButton(context, Colors.black),
//                 _buildEraserButton(context),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildColorButton(BuildContext context, Color color) {
//     final currentColor = context.watch<DrawingModel>().currentColor;
//     final isSelected =
//         currentColor == color && !context.watch<DrawingModel>().isEraserMode;
//
//     return Container(
//       margin: const EdgeInsets.all(4.0),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: isSelected ? Colors.black : Colors.transparent,
//           width: 3.0,
//         ),
//       ),
//       child: IconButton(
//         icon: Icon(Icons.square, color: color),
//         onPressed: () {
//           context.read<DrawingModel>().setColor(color);
//         },
//       ),
//     );
//   }
//
//   Widget _buildEraserButton(BuildContext context) {
//     final isEraserSelected = context.watch<DrawingModel>().isEraserMode;
//
//     return Container(
//       margin: const EdgeInsets.all(4.0),
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: isEraserSelected ? Colors.red : Colors.transparent,
//           width: 3.0,
//         ),
//       ),
//       child: IconButton(
//         icon: const Icon(Icons.highlight_remove),
//         onPressed: () {
//           context.read<DrawingModel>().toggleEraser();
//         },
//       ),
//     );
//   }
// }
//
// class DrawingModel extends ChangeNotifier {
//   final List<List<Offset>> _strokes = [];
//   final List<Color> _strokeColors = [];
//   double _strokeWidth = 4.0;
//   bool _isDrawingMode = true;
//   bool _isEraserMode = false;
//   Color _currentColor = Colors.black;
//
//   void startStroke(Offset point) {
//     _strokes.add([point]);
//     _strokeColors.add(_currentColor);
//     notifyListeners();
//   }
//
//   void addPoint(Offset point) {
//     if (_strokes.isEmpty || _strokes.last.isEmpty) {
//       _strokes.add([]);
//       _strokeColors.add(_currentColor);
//     }
//     _strokes.last.add(point);
//     notifyListeners();
//   }
//
//   void endStroke() {
//     if (_strokes.isNotEmpty && _strokes.last.isEmpty) {
//       _strokes.removeLast();
//       _strokeColors.removeLast();
//     }
//     notifyListeners();
//   }
//
//   void clear() {
//     _strokes.clear();
//     _strokeColors.clear();
//     notifyListeners();
//   }
//
//   void setColor(Color color) {
//     _currentColor = color;
//     _isEraserMode = false;
//     notifyListeners();
//   }
//
//   void changeStrokeWidth(double scaleFactor) {
//     double width = 4.0 * scaleFactor;
//     _strokeWidth = width;
//     notifyListeners();
//   }
//
//   void toggleEraser() {
//     _isEraserMode = !_isEraserMode;
//     if (_isEraserMode) {
//       _currentColor = Colors.white;
//     }
//     notifyListeners();
//   }
//
//   void toggleMode() {
//     _isDrawingMode = !_isDrawingMode;
//     notifyListeners();
//   }
//
//   bool get isDrawingMode => _isDrawingMode;
//
//   bool get isEraserMode => _isEraserMode;
//
//   Color get currentColor => _currentColor;
//
//   List<List<Offset>> get strokes => _strokes;
//
//   List<Color> get strokeColors => _strokeColors;
//
//   double get strokeWidth => _strokeWidth;
// }
//
// class DrawingPainter extends CustomPainter {
//   final DrawingModel model;
//
//   DrawingPainter(this.model);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     for (int i = 0; i < model.strokes.length; i++) {
//       final stroke = model.strokes[i];
//       final paint = Paint()
//         ..color = model.strokeColors[i]
//         ..strokeCap = StrokeCap.round
//         ..strokeWidth = model.strokeWidth;
//
//       for (int j = 0; j < stroke.length - 1; j++) {
//         canvas.drawLine(stroke[j], stroke[j + 1], paint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
