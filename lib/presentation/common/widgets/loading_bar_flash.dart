import 'package:flutter/material.dart';

class LoadingBarFlash extends StatefulWidget {
  final Duration duration;

  const LoadingBarFlash({super.key, this.duration = const Duration(milliseconds: 520)});

  @override
  State<LoadingBarFlash> createState() => _LoadingBarFlashState();
}

class _LoadingBarFlashState extends State<LoadingBarFlash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration)
        ..forward();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topCenter,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: _controller.value,
              child: Container(
                height: 4.5,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(9)),
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0.13),
                      color.withOpacity(0.7),
                      color.withOpacity(0.9),
                      color,
                      color.withOpacity(0.7),
                      color.withOpacity(0.13),
                    ],
                    stops: const [0, 0.12, 0.33, 0.75, 0.98, 1],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.24),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
