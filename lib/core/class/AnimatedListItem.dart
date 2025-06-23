import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedListItem extends StatefulWidget {
  final Widget child;

  const AnimatedListItem({super.key, required this.child});

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_isVisible && info.visibleFraction > 0.1) {
      _isVisible = true;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: _onVisibilityChanged,
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _controller,
          child: widget.child,
        ),
      ),
    );
  }
}
