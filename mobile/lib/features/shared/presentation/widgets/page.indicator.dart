import 'package:flutter/material.dart';
import 'package:shared_utils/shared_utils.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color color;
  final Color activeColor;

  const PageIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    required this.color,
    required this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: context.width * 0.1,
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index == currentIndex ? activeColor : color,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ).centered().bottom(12);
}
