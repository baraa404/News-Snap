import 'package:flutter/material.dart';

class SwipeableStack extends StatefulWidget {
  final List<Widget> children;
  final Duration animationDuration;
  final double rotationAngle;
  final Offset stackOffset;

  const SwipeableStack({
    super.key,
    required this.children,
    this.animationDuration = const Duration(milliseconds: 300),
    this.rotationAngle = 0.11, // Default rotation for background card
    this.stackOffset = const Offset(
      60,
      25,
    ), // Default offset for background card
  });

  @override
  State<SwipeableStack> createState() => _SwipeableStackState();
}

class _SwipeableStackState extends State<SwipeableStack>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  int currentIndex = 0;
  int nextIndex = 1;
  double _dragOffset = 0.0;
  double _throwVelocity = 0.0;
  bool _isDragging = false;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    nextIndex = (currentIndex + 1) % widget.children.length;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSwipe(double velocity) {
    if (_isAnimating) return;

    setState(() {
      _isDragging = false;
      _isAnimating = true;
      _throwVelocity = velocity;
    });

    _animationController.forward().then((_) {
      setState(() {
        currentIndex = nextIndex;
        nextIndex = (currentIndex + 1) % widget.children.length;
        _isAnimating = false;
        _dragOffset = 0.0;
        _throwVelocity = 0.0;
      });
      _animationController.reset();
    });
  }

  Widget _buildCard(int index, {bool isBackground = false}) {
    final child = widget.children[index % widget.children.length];

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double offsetX = 0.0;
        double offsetY = 0.0;
        double opacity = 1.0;
        double scale = 1.0;
        double rotation = 0.0;

        if (isBackground) {
          // Background card animation - moves from background to front
          if (_isAnimating) {
            // Animate from background position to front position
            offsetX = widget.stackOffset.dx * (1 - _animation.value);
            offsetY = widget.stackOffset.dy * (1 - _animation.value);
            rotation = widget.rotationAngle * (1 - _animation.value);
            scale = 0.95 + (_animation.value * 0.05);
          } else {
            // Static background position
            offsetX = widget.stackOffset.dx;
            offsetY = widget.stackOffset.dy;
            rotation = widget.rotationAngle;
            scale = 0.95;
          }
        } else {
          // Foreground card animation
          if (_isDragging) {
            offsetX = _dragOffset;
            opacity = 1.0 - (_dragOffset.abs() / 300).clamp(0.0, 0.7);
          } else if (_isAnimating) {
            // Continue throwing motion from where drag ended
            double throwDistance =
                _dragOffset + (_throwVelocity * _animation.value);
            offsetX = throwDistance;
            opacity = 1.0 - _animation.value;
            scale = 1.0 - (_animation.value * 0.1);
          }
        }

        return Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(
              scale: scale,
              child: Opacity(opacity: opacity, child: child),
            ),
          ),
        );
      },
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.children.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onPanStart: (details) {
        if (!_isAnimating) {
          _isDragging = true;
        }
      },
      onPanUpdate: (details) {
        if (_isDragging && !_isAnimating) {
          setState(() {
            _dragOffset += details.delta.dx;
          });
        }
      },
      onPanEnd: (details) {
        if (_isDragging && !_isAnimating) {
          if (_dragOffset.abs() > 100 ||
              details.velocity.pixelsPerSecond.dx.abs() > 500) {
            // Pass the velocity to continue the throwing motion
            _onSwipe(details.velocity.pixelsPerSecond.dx / 4);
          } else {
            setState(() {
              _dragOffset = 0.0;
              _isDragging = false;
            });
          }
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background card (next card)
          _buildCard(nextIndex, isBackground: true),
          // Foreground card (current card)
          _buildCard(currentIndex, isBackground: false),
        ],
      ),
    );
  }
}
