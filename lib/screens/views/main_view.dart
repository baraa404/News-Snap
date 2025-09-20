import 'package:flutter/material.dart';
import 'package:news_app/screens/views/home.view.dart';
import 'package:news_app/screens/views/search_view.dart';
import 'package:news_app/screens/widgets/drawer_widget.dart';
import 'package:news_app/widgets/animated_tab_selector.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;
  final List<Widget> pages = [HomeView(), SearchView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this to prevent overflow when keyboard appears
      resizeToAvoidBottomInset: false,
      //this to open the drawer
      endDrawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70,
          left: 16,
          right: 16,
          bottom: 30,
        ),
        child: Stack(
          children: [
            IndexedStack(index: currentIndex, children: pages),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedTabSelector(
                icons: [Icons.home, Icons.search],
                onTabSelected: (int selected) {
                  setState(() {
                    currentIndex = selected;
                  });
                },
                backgroundColor: Colors.grey.shade900,
                circleColor: Colors.white,
                overallSize: 1,
                circleSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
