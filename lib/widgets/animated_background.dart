import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackgroundWithFallback extends StatefulWidget {
  const AnimatedBackgroundWithFallback({super.key});

  @override
  State<AnimatedBackgroundWithFallback> createState() => _AnimatedBackgroundWithFallbackState();
}

class _AnimatedBackgroundWithFallbackState extends State<AnimatedBackgroundWithFallback>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // Primary watermark URL (the one you requested)
  static const String primaryWatermarkUrl = 'https://i.postimg.cc/XXMGfwCV/Whats-App-Image-2025-08-07-at-16-12-18-0e0cfd95.jpg';
  // Fallback watermark URL (the working one)
  static const String fallbackWatermarkUrl = 'https://sjc.microlink.io/W3QL7GwIjp_H_scKhiJ2nRLZWOYFwgFYbc_-3OOWgS5fdEiI6jyDbUi2BSdRGIotsSOFzr4n0mkn8whCIB3b8w.jpeg';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildWatermarkImage() {
    return Image.network(
      primaryWatermarkUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        // Fallback to the working URL if primary fails
        return Image.network(
          fallbackWatermarkUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // If both fail, return a subtle pattern
            return Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.02),
                    Colors.transparent,
                  ],
                  stops: const [0.3, 1.0],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            // Base gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.lerp(
                      const Color(0xFF0F2027),
                      Colors.black,
                      (math.sin(_animation.value) + 1) / 2,
                    )!,
                    Color.lerp(
                      Colors.black,
                      Colors.black,
                      (math.cos(_animation.value) + 1) / 2,
                    )!,
                    Color.lerp(
                      const Color(0xFF0F2027),
                      const Color(0xFF203A43),
                      (math.sin(_animation.value + math.pi / 2) + 1) / 2,
                    )!,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Watermark background image with fallback
            Positioned.fill(
              child: Opacity(
                opacity: 0.08, // Subtle background watermark
                child: _buildWatermarkImage(),
              ),
            ),

            // Animated overlay
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.4 + (math.sin(_animation.value) * 0.1)),
                        Colors.transparent,
                        Colors.black.withOpacity(0.3 + (math.cos(_animation.value) * 0.1)),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                );
              },
            ),

            // Wave animation
            CustomPaint(
              painter: WavePainter(_animation.value),
              child: Container(),
            ),
          ],
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    final path = Path();
    final waveHeight = 25.0;
    final waveLength = size.width / 2;

    path.moveTo(0, size.height * 0.8);

    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height * 0.8 +
          waveHeight * math.sin((x / waveLength * 2 * math.pi) + animationValue);
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Second wave
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.01)
      ..style = PaintingStyle.fill;

    final path2 = Path();
    path2.moveTo(0, size.height * 0.9);

    for (double x = 0; x <= size.width; x += 1) {
      final y = size.height * 0.9 +
          waveHeight * 0.5 * math.sin((x / waveLength * 2 * math.pi) + animationValue * 1.5);
      path2.lineTo(x, y);
    }

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}