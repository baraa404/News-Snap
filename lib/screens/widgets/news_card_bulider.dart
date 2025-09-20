import 'package:flutter/material.dart';
import 'package:news_app/modules/article.module.dart';
import 'package:news_app/screens/widgets/news_card.dart';
import 'package:news_app/services/news_api.service.dart';
import 'package:news_app/widgets/swipeable_stack.dart';

class NewsCardBulider extends StatefulWidget {
  const NewsCardBulider({super.key, required this.category});
  final String category;
  @override
  State<NewsCardBulider> createState() => _NewsCardBuliderState();
}

class _NewsCardBuliderState extends State<NewsCardBulider> {
  // here i made a var of type futrue list of article model

  late final Future<List<ArticleModel>> future;

  @override
  void initState() {
    super.initState();
    // get the news from the api service and assign it to the future var
    future = NewsApiService().getNews(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: future,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            width: 320,
            height: 480,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red.shade600,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Failed to load news',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please check your connection\nand try again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.red.shade600),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        // if we have data and the data is not empty
        //then return the news cards list
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return NewsCardsList(articles: snapshot.data!);
        }

        // No data case
        return Container(
          width: 320,
          height: 480,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.article_outlined,
                  size: 48,
                  color: Colors.grey.shade600,
                ),
                SizedBox(height: 16),
                Text(
                  'No news available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// thi is for the list of news cards
class NewsCardsList extends StatelessWidget {
  final List<ArticleModel> articles;
  const NewsCardsList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 480,
      child: SwipeableStack(
        children: [for (var article in articles) NewsCard(article: article)],
      ),
    );
  }
}
