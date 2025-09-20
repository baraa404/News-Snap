import 'package:flutter/material.dart';

class AnimatedTabSelector extends StatefulWidget {
  final List<IconData> icons;
  final Function(int) onTabSelected;
  final Color backgroundColor;
  final Color circleColor;
  final double containerRadius;
  final double circleSize;
  final double circleRadius;
  final double overallSize;
  final int initialSelectedIndex;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Duration animationDuration;

  const AnimatedTabSelector({
    super.key,
    required this.icons,
    required this.onTabSelected,
    this.backgroundColor = Colors.grey,
    this.circleColor = Colors.white,
    this.containerRadius = 25.0,
    this.circleSize = 40.0,
    this.circleRadius = 20.0,
    this.overallSize = 1.0,
    this.initialSelectedIndex = 0,
    this.selectedIconColor = Colors.black,
    this.unselectedIconColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedTabSelector> createState() => _AnimatedTabSelectorState();
}

class _AnimatedTabSelectorState extends State<AnimatedTabSelector>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;

    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _positionAnimation =
        Tween<double>(
          begin: _selectedIndex.toDouble(),
          end: _selectedIndex.toDouble(),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _positionAnimation =
            Tween<double>(
              begin: _selectedIndex.toDouble(),
              end: index.toDouble(),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            );
        _selectedIndex = index;
      });

      _animationController.forward(from: 0);
      widget.onTabSelected(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final scaledCircleSize = widget.circleSize * widget.overallSize;
    final scaledContainerRadius = widget.containerRadius * widget.overallSize;
    final scaledCircleRadius = widget.circleRadius * widget.overallSize;
    final scaledIconSize = 24.0 * widget.overallSize;

    final itemWidth = scaledCircleSize + 10; // Adding some padding
    final containerWidth = itemWidth * widget.icons.length;
    final containerHeight = scaledCircleSize + 10;

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(scaledContainerRadius),
      ),
      child: Stack(
        children: [
          // Animated circle indicator
          AnimatedBuilder(
            animation: _positionAnimation,
            builder: (context, child) {
              return Positioned(
                left: _positionAnimation.value * itemWidth + 5,
                top: 5,
                child: Container(
                  width: scaledCircleSize,
                  height: scaledCircleSize,
                  decoration: BoxDecoration(
                    color: widget.circleColor,
                    borderRadius: BorderRadius.circular(scaledCircleRadius),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4 * widget.overallSize,
                        offset: Offset(0, 2 * widget.overallSize),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Icon buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.icons.asMap().entries.map((entry) {
              int index = entry.key;
              IconData icon = entry.value;

              return GestureDetector(
                onTap: () => _selectTab(index),
                child: SizedBox(
                  width: itemWidth,
                  height: containerHeight,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        bool isSelected = _selectedIndex == index;
                        return Icon(
                          icon,
                          color: isSelected
                              ? widget.selectedIconColor
                              : widget.unselectedIconColor,
                          size: scaledIconSize,
                        );
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
