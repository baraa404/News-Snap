import 'package:flutter/material.dart';

class CategoryTabBar extends StatelessWidget {
  const CategoryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      splashBorderRadius: BorderRadius.circular(20),
      labelColor: Colors.white,
      indicatorColor: Colors.transparent,
      dividerColor: Colors.transparent,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),

      tabs: [
        Tab(text: "Trending"),
        Tab(text: "Health"),
        Tab(text: "Sports"),
        Tab(text: "Business"),
      ],
    );
  }
}
