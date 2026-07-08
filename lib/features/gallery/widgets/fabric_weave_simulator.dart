import 'package:flutter/material.dart';
import 'dart:math' as math;

class FabricWeaveSimulator extends StatefulWidget {
  final Color warpColor;
  final Color weftColor;
  final VoidCallback? onDismiss;

  const FabricWeaveSimulator({
    super.key,
    required this.warpColor,
    required this.weftColor,
    this.onDismiss,
  });

  @override
  State<FabricWeaveSimulator> createState() => _FabricWeaveSimulatorState();
}

class _FabricWeaveSimulatorState extends State<FabricWeaveSimulator> with SingleTickerProviderStateMixin {
  Offset? _touchPoint;
  late AnimationController _springController;
  Offset _lastTouchPoint = Offset.zero;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _springController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _touchPoint = details.localPosition;
      _lastTouchPoint = details.localPosition;
      _springController.reset();
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    _springController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: widget.onDismiss,
      onPanUpdate: _handlePanUpdate,
      onPanEnd: _handlePanEnd,
      child: Container(
        color: Colors.black,
        child: CustomPaint(
          painter: WeavePainter(
            warpColor: widget.warpColor,
            weftColor: widget.weftColor,
            touchPoint: _touchPoint,
            lastTouchPoint: _lastTouchPoint,
            springProgress: _springController.value,
          ),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class WeavePainter extends CustomPainter {
  final Color warpColor;
  final Color weftColor;
  final Offset? touchPoint;
  final Offset lastTouchPoint;
  final double springProgress;

  WeavePainter({
    required this.warpColor,
    required this.weftColor,
    this.touchPoint,
    required this.lastTouchPoint,
    required this.springProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double threadSpacing = 16.0;
    const double threadThickness = 10.0;

    final double springEffect = Curves.elasticOut.transform(1.0 - springProgress);
    final Offset effectiveTouchPoint = touchPoint ?? lastTouchPoint;

    // Draw background texture
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.black);

    // Weave Logic: Grid of threads
    for (double x = 0; x < size.width + threadSpacing; x += threadSpacing) {
      for (double y = 0; y < size.height + threadSpacing; y += threadSpacing) {
        bool isWarpTop = ((x / threadSpacing).floor() + (y / threadSpacing).floor()) % 2 == 0;

        if (isWarpTop) {
          _drawWarpThread(canvas, x, y, threadSpacing, threadThickness, effectiveTouchPoint, springEffect);
          _drawWeftThread(canvas, x, y, threadSpacing, threadThickness, effectiveTouchPoint, springEffect);
        } else {
          _drawWeftThread(canvas, x, y, threadSpacing, threadThickness, effectiveTouchPoint, springEffect);
          _drawWarpThread(canvas, x, y, threadSpacing, threadThickness, effectiveTouchPoint, springEffect);
        }
      }
    }
  }

  void _drawWarpThread(Canvas canvas, double x, double y, double spacing, double thickness, Offset touch, double spring) {
    Offset pos = Offset(x, y);
    Offset displacedPos = _calculateDisplacement(pos, touch, spring);

    Rect rect = Rect.fromCenter(
      center: displacedPos,
      width: thickness * 0.8,
      height: spacing * 1.2,
    );

    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          warpColor.withOpacity(0.8),
          warpColor,
          warpColor.withOpacity(0.8),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);

    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), paint);

    // Highlight
    Paint highlight = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), highlight);
  }

  void _drawWeftThread(Canvas canvas, double x, double y, double spacing, double thickness, Offset touch, double spring) {
    Offset pos = Offset(x, y);
    Offset displacedPos = _calculateDisplacement(pos, touch, spring);

    Rect rect = Rect.fromCenter(
      center: displacedPos,
      width: spacing * 1.2,
      height: thickness * 0.8,
    );

    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          weftColor.withOpacity(0.8),
          weftColor,
          weftColor.withOpacity(0.8),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect);

    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), paint);

    // Highlight
    Paint highlight = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), highlight);
  }

  Offset _calculateDisplacement(Offset point, Offset touch, double spring) {
    double dist = (point - touch).distance;
    double radius = 100.0;
    if (dist < radius) {
      double power = (1.0 - (dist / radius)) * 15.0 * spring;
      Offset direction = (point - touch) / (dist == 0 ? 1 : dist);
      return point + direction * power;
    }
    return point;
  }

  @override
  bool shouldRepaint(covariant WeavePainter oldDelegate) => true;
}
