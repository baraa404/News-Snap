import 'package:flutter/material.dart';
import 'package:news_app/screens/widgets/catagory_tab.dart';
import 'package:news_app/screens/widgets/cusom_app_bar.dart';
import 'package:news_app/screens/widgets/news_card_bulider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          CusomAppBar(),
          SizedBox(height: 30),
          CategoryTabBar(),
          SizedBox(height: 20),
          Flexible(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                NewsCardBulider(category: 'general'),
                NewsCardBulider(category: 'health'),
                NewsCardBulider(category: 'sports'),
                NewsCardBulider(category: 'business'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
