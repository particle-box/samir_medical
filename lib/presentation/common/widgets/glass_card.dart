import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final double blur;
  final double opacity;
  final Color? tint;
  final GestureTapCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 16,
    this.blur = 18,
    this.opacity = 0.12,
    this.tint,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _pressed = false;

  void _handleHighlightChanged(bool pressed) {
    if (_pressed != pressed) {
      setState(() {
        _pressed = pressed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = AnimatedScale(
      scale: _pressed ? 0.97 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: widget.padding,
            decoration: BoxDecoration(
              color: (widget.tint ?? Colors.white).withOpacity(widget.opacity),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(color: Colors.white.withOpacity(0.20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_pressed ? 0.04 : 0.13),
                  blurRadius: _pressed ? 8 : 24,
                  spreadRadius: 0,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
    Widget wrapMargin(Widget child) {
      if (widget.margin == null) return child;
      return Container(margin: widget.margin, child: child);
    }

    if (widget.onTap != null) {
      return wrapMargin(
        InkWell(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap: widget.onTap,
          onHighlightChanged: _handleHighlightChanged,
          child: card,
        ),
      );
    }
    return wrapMargin(card);
  }
}
