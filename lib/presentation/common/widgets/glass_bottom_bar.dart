import 'dart:ui';
import 'package:flutter/material.dart';

class GlassBottomBarItem {
  final IconData icon;
  final String label;
  const GlassBottomBarItem({required this.icon, required this.label});
}

class GlassBottomBar extends StatelessWidget {
  final List<GlassBottomBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double height;
  final double cornerRadius;
  final double blur;
  final double backgroundOpacity;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const GlassBottomBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 68,
    this.cornerRadius = 28,
    this.blur = 22,
    this.backgroundOpacity = 0.14,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final glassColor = (isDark ? Colors.white : Colors.white).withOpacity(backgroundOpacity);
    final activeColor = isDark ? cs.secondary : cs.primary;
    final inactiveColor = isDark ? Colors.white70 : Colors.black54;
    return SafeArea(
      bottom: true,
      top: false,
      left: false,
      right: false,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: margin,
          child: IntrinsicWidth(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: glassColor,
                    borderRadius: BorderRadius.circular(cornerRadius),
                    border: Border.all(
                      color: Colors.white.withOpacity(isDark ? 0.12 : 0.28),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.40 : 0.18),
                        blurRadius: 28,
                        spreadRadius: 2,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: padding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(items.length, (i) {
                        final selected = i == currentIndex;
                        return _BarItem(
                          icon: items[i].icon,
                          label: items[i].label,
                          selected: selected,
                          activeColor: activeColor,
                          inactiveColor: inactiveColor,
                          onTap: () => onTap(i),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color activeColor;
  final Color inactiveColor;

  const _BarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  __BarItemState createState() => __BarItemState();
}

class __BarItemState extends State<_BarItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.9), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.15), weight: 50),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    if (widget.selected) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant _BarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      if (widget.selected) {
        _controller.forward(from: 0.0);
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.selected ? widget.activeColor : widget.inactiveColor;
    final fontWeight = widget.selected ? FontWeight.w900 : FontWeight.w700;
    final shadow = widget.selected
        ? [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 2),
              blurRadius: 2,
            )
          ]
        : null;

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        width: 68,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: widget.selected ? color.withOpacity(0.13) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.icon,
                color: color,
                size: 26,
                shadows: widget.selected
                    ? [
                        Shadow(
                          color: color.withOpacity(0.44),
                          blurRadius: 7,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : null,
              ),
            ),
            const SizedBox(height: 5),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              curve: Curves.ease,
              style: TextStyle(
                color: color,
                fontWeight: fontWeight,
                fontSize: 14,
                letterSpacing: 0.3,
                height: 1.15,
                shadows: shadow,
              ),
              child: Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}