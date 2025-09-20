import 'package:flutter/material.dart';
import 'package:news_app/screens/widgets/seach_news_bulider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController controller = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.text.isEmpty && searchQuery.isNotEmpty) {
        setState(() {
          searchQuery = '';
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _performSearch() {
    if (controller.text.trim().isNotEmpty) {
      setState(() {
        searchQuery = controller.text.trim();
      });
    }
  }

  void _clearSearch() {
    controller.clear();
    setState(() {
      searchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: controller,
            onSubmitted: (value) => _performSearch(),
            decoration: InputDecoration(
              hintText: 'Search for news...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              prefixIcon: Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(onPressed: _clearSearch, icon: Icon(Icons.clear))
                  : IconButton(
                      onPressed: _performSearch,
                      icon: Icon(Icons.search),
                    ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Expanded(
          child: searchQuery.isNotEmpty
              ? SearchNewsBulider(search: searchQuery)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search, size: 64, color: Colors.grey.shade400),
                      SizedBox(height: 16),
                      Text(
                        'Search for news',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Enter a keyword to find relevant articles',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}
