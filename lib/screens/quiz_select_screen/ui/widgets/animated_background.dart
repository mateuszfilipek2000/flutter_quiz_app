import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key, required this.maxHeightFraction})
      : super(key: key);

  final double maxHeightFraction;

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  late Animation<double> textOpacityAnimation;
  late Animation<double> circleRotationAnimation;
  late Animation<double> circlePositionAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();

    animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedWaves(
      animation: animation,
      width: width,
      maxHeightFraction: widget.maxHeightFraction,
    );
  }
}

class AnimatedWaves extends AnimatedWidget {
  const AnimatedWaves({
    Key? key,
    required this.animation,
    required this.width,
    required this.maxHeightFraction,
  }) : super(key: key, listenable: animation);

  final Animation<double> animation;
  final double width;
  final double maxHeightFraction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: WaveClipper(maxHeightFraction, animation.value,
              offsetPercent: 0.2),
          child: Container(
            color: const Color(0xFFFFDDE5),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(maxHeightFraction - 0.05, animation.value * -1),
          child: Container(
            color: const Color(0xFFEE4266),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(maxHeightFraction - 0.1, animation.value,
              offsetPercent: 0.2),
          child: Container(
            color: const Color(0xFFFFB8C8),
          ),
        ),
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  WaveClipper(this.heightFraction, this.animationValue,
      {this.offsetPercent = 0});

  double heightFraction;
  double animationValue;
  double offsetPercent;

  @override
  Path getClip(Size size) {
    var width = size.width;
    var height = size.height;

    var waveHeight = height - (height * heightFraction);

    // var percentOfHeight = height / 100;
    // var percentOfWidth = width / 100;

    Path path = Path()
      ..moveTo(width, waveHeight)
      ..lineTo(width, height)
      ..lineTo(0, height)
      ..lineTo(0, waveHeight);

    for (int x = 0; x <= width; x++) {
      // current width fraction (0-1)
      var xPos = x / width * 2 * pi;
      var currentWidthShift =
          (animationValue * 2 * pi) + (width * offsetPercent);

      // currentWidthShift *= speed;
      path.lineTo(
          x.toDouble(), waveHeight + sin(2 * pi + xPos + currentWidthShift) * 50
          // waveHeight +
          //     sin(((size.width * offsetPercent + x) / size.width * 4 * pi) +
          //             ((speed * animationValue) * 2 * pi)) *
          //         30,
          );
    }

    // Path path = Path()
    //   ..moveTo(width + widthShift, waveHeight)
    //   ..lineTo(width + widthShift, height)
    //   ..lineTo(0, height)
    //   ..lineTo(0, waveHeight)
    //   ..cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, width + widthShift, waveHeight)
    //   ..close();
    return path..close();
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      heightFraction != oldClipper.heightFraction ||
      animationValue != oldClipper.animationValue;
}
