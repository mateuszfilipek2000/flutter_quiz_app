import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedScoreInfo extends StatefulWidget {
  const AnimatedScoreInfo(
      {Key? key, required this.scored, required this.total, this.duration})
      : super(key: key);

  final int scored;
  final int total;
  final Duration? duration;

  @override
  State<AnimatedScoreInfo> createState() => _AnimatedScoreInfoState();
}

class _AnimatedScoreInfoState extends State<AnimatedScoreInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  late Animation<double> circleBackgroundProgress;
  late Animation<double> circleForegroundProgress;
  late Animation<double> scoreTextOpacity;

  @override
  void initState() {
    final scorePercent = widget.scored / widget.total * 100.0;

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    circleBackgroundProgress = Tween<double>(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
          parent: animationController, curve: const Interval(0, 0.4)),
    );
    circleForegroundProgress =
        Tween<double>(begin: 0.0, end: scorePercent).animate(
      CurvedAnimation(
          parent: animationController,
          curve: const Interval(0.2, 0.6, curve: Curves.easeInOut)),
    );

    scoreTextOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationController, curve: const Interval(0.4, 1.0)),
    );

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: AnimatedBuilder(
                  animation: scoreTextOpacity,
                  builder: (context, _) {
                    return ShaderMask(
                      shaderCallback: (rect) {
                        return RadialGradient(
                          radius: scoreTextOpacity.value * 5,
                          colors: const [
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                            Colors.transparent
                          ],
                        ).createShader(rect);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Congratulations, you've scored ${(widget.scored / widget.total * 100).round()}%",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          widget.duration != null
                              ? Text(
                                  "The quiz took you only " +
                                      widget.duration
                                          .toString()
                                          .split('.')
                                          .first
                                          .padLeft(8, "0"),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
            ),
            Flexible(
              flex: 1,
              child: Center(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedCircle(
                      animation: circleBackgroundProgress,
                      color: Colors.grey,
                    ),
                    AnimatedBuilder(
                        animation: scoreTextOpacity,
                        builder: (context, _) {
                          return Center(
                            child: Opacity(
                              opacity: scoreTextOpacity.value,
                              child: Text(
                                "${widget.scored}/${widget.total}",
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                              ),
                            ),
                          );
                        }),
                    AnimatedCircle(
                      animation: circleForegroundProgress,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCircle extends AnimatedWidget {
  const AnimatedCircle(
      {Key? key, required this.animation, this.color = Colors.blue})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AnimatedCirclePainter(animation.value, color: color),
    );
  }
}

class AnimatedCirclePainter extends CustomPainter {
  AnimatedCirclePainter(
    this.progressPercent, {
    this.color = Colors.blue,
    this.thickness = 20.0,
  });
  double progressPercent;
  final Color color;
  final double thickness;

  @override
  void paint(Canvas canvas, Size size) {
    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2.0, size.height / 2.0);

    final smallerDimension = min(size.width, size.height) - thickness;

    canvas.drawArc(
      Rect.fromCenter(
          center: center, width: smallerDimension, height: smallerDimension),
      -pi / 2.0,
      2 * pi * (progressPercent / 100.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(AnimatedCirclePainter oldDelegate) =>
      oldDelegate.progressPercent != progressPercent;
}
