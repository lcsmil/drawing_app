import 'package:drawing_app/src/features/drawing/resources/drawing_color_tokens.dart';
import 'package:flutter/material.dart';

class DrawingController extends ChangeNotifier {
  final List<List<Offset>> _strokes = [];
  final List<Color> _strokeColors = [];
  double _strokeWidth = 4.0;
  bool _isDrawingMode = true;
  bool _isEraserMode = false;
  Color _currentColor = Colors.black;

  void startStroke(Offset point) {
    _strokes.add([point]);
    _strokeColors.add(_currentColor);
    notifyListeners();
  }

  void addPoint(Offset point) {
    if (_strokes.isEmpty || _strokes.last.isEmpty) {
      _strokes.add([]);
      _strokeColors.add(_currentColor);
    }
    _strokes.last.add(point);
    notifyListeners();
  }

  void endStroke() {
    if (_strokes.isNotEmpty && _strokes.last.isEmpty) {
      _strokes.removeLast();
      _strokeColors.removeLast();
    }
    notifyListeners();
  }

  void clear() {
    _strokes.clear();
    _strokeColors.clear();
    notifyListeners();
  }

  void setColor(Color color) {
    _currentColor = color;
    _isEraserMode = false;
    notifyListeners();
  }

  void changeStrokeWidth(double scaleFactor) {
    double width = 4.0 * scaleFactor;
    _strokeWidth = width;
    notifyListeners();
  }

  void toggleEraser() {
    _isEraserMode = !_isEraserMode;
    if (_isEraserMode) {
      _currentColor = DrawingColorTokens.white;
    }
    notifyListeners();
  }

  void toggleMode() {
    _isDrawingMode = !_isDrawingMode;
    notifyListeners();
  }

  bool get isDrawingMode => _isDrawingMode;

  bool get isEraserMode => _isEraserMode;

  Color get currentColor => _currentColor;

  List<List<Offset>> get strokes => _strokes;

  List<Color> get strokeColors => _strokeColors;

  double get strokeWidth => _strokeWidth;
}
