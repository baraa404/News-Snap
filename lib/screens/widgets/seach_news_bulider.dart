import 'package:flutter/material.dart';
import 'package:news_app/modules/article.module.dart';
import 'package:news_app/screens/widgets/news_card_bulider.dart';
import 'package:news_app/services/news_api.service.dart';

class SearchNewsBulider extends StatefulWidget {
  const SearchNewsBulider({super.key, required this.search});
  final String search;
  @override
  State<SearchNewsBulider> createState() => _SearchNewsBuliderState();
}

class _SearchNewsBuliderState extends State<SearchNewsBulider> {
  // here i made a var of type futrue list of article model
  late Future<List<ArticleModel>> future;

  @override
  void initState() {
    super.initState();
    // get the news from the api service and assign it to the future var
    future = NewsApiService().getSearchNews(search: widget.search);
  }

  @override
  void didUpdateWidget(SearchNewsBulider oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Rebuild the future if the search query changed
    if (oldWidget.search != widget.search) {
      future = NewsApiService().getSearchNews(search: widget.search);
    }
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
                    'Failed to load search results',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.red.shade600),
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
          // Debug print
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
                Icon(Icons.search_off, size: 48, color: Colors.grey.shade600),
                SizedBox(height: 16),
                Text(
                  'No results found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Try searching for different keywords',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                SizedBox(height: 4),
                Text(
                  'Search term: "${widget.search}"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
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
