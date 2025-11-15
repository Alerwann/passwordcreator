import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:password_robust_creator/l10n/app_localizations.dart';
import 'package:password_robust_creator/result_screen.dart';

class WaitingScreen extends StatefulWidget {
  final String password;
  final int numMin;
  final int numMaj;
  final int numNum;
  final int numCharSpe;
  final int numTotal;

  const WaitingScreen({
    super.key,
    required this.password,
    required this.numCharSpe,
    required this.numMaj,
    required this.numMin,
    required this.numNum,
    required this.numTotal,
  });

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  Timer? _timer;
  Timer? _navigationTimer;
  List<MatrixColumn> _columns = [];
  final String _chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()[]{}<>?/|\\';

  @override
  void initState() {
    super.initState();
    _initializeColumns();
    _startAnimation();
    _startNavigationTimer();
  }

  void _initializeColumns() {
    final random = Random();
    _columns = List.generate(15, (index) {
      return MatrixColumn(
        x: index * 30.0,
        speed: 2.0 + random.nextDouble() * 3.0,
        chars: _chars,
        length: 8 + random.nextInt(12),
      );
    });
  }

  void _startAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        for (var column in _columns) {
          column.update();
        }
      });
    });
  }

  void _startNavigationTimer() {
    _navigationTimer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            password: widget.password,
            numCharSpe: widget.numCharSpe,
            numMaj: widget.numMaj,
            numMin: widget.numMin,
            numNum: widget.numNum,
            numTotal: widget.numTotal,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: MatrixPainter(_columns)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Text(
                    AppLocalizations.of(context)!.generating,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MatrixColumn {
  double x;
  double y;
  double speed;
  final String chars;
  final int length;
  List<String> characters = [];
  final Random _random = Random();

  MatrixColumn({
    required this.x,
    required this.speed,
    required this.chars,
    required this.length,
  }) : y = -length * 20.0 {
    _generateCharacters();
  }

  void _generateCharacters() {
    characters = List.generate(
      length,
      (index) => chars[_random.nextInt(chars.length)],
    );
  }

  void update() {
    y += speed;

    if (y > 800) {
      y = -length * 20.0;
      _generateCharacters();
    }

    if (_random.nextDouble() > 0.9) {
      int index = _random.nextInt(length);
      characters[index] = chars[_random.nextInt(chars.length)];
    }
  }
}

class MatrixPainter extends CustomPainter {
  final List<MatrixColumn> columns;

  MatrixPainter(this.columns);

  @override
  void paint(Canvas canvas, Size size) {
    for (var column in columns) {
      _drawColumn(canvas, column);
    }
  }

  void _drawColumn(Canvas canvas, MatrixColumn column) {
    for (int i = 0; i < column.characters.length; i++) {
      double opacity = (column.length - i) / column.length;

      if (i == 0) {
        opacity = 1.0;
      }

      final textStyle = TextStyle(
        color: i == 0
            ? Colors.white
            : Colors.green.withValues(alpha: opacity * 0.8),
        fontSize: 16,
        fontFamily: 'monospace',
        fontWeight: i == 0 ? FontWeight.bold : FontWeight.normal,
      );

      final textSpan = TextSpan(text: column.characters[i], style: textStyle);

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      textPainter.paint(canvas, Offset(column.x, column.y + (i * 20)));
    }
  }

  @override
  bool shouldRepaint(MatrixPainter oldDelegate) => true;
}
