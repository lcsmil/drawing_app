import 'package:drawing_app/src/features/drawing/presentation/controller/drawing_controller.dart';
import 'package:drawing_app/src/features/drawing/presentation/screens/drawing_screen.dart';
import 'package:drawing_app/src/features/drawing/resources/drawing_color_tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DrawingApp());
}

class DrawingApp extends StatelessWidget {
  const DrawingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DrawingController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: DrawingColorTokens.white,
        ),
        home: const DrawingScreen(),
      ),
    );
  }
}
