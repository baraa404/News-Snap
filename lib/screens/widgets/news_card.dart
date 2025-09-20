import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/article.module.dart';
import 'package:news_app/screens/views/webview_screen.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel article;

  const NewsCard({super.key, required this.article});

  static const List<Color> colors = [
    Color(0xFFFFEBEE), // Light pink
    Color(0xFFF3E5F5), // Light lavender
    Color(0xFFE3F2FD), // Light blue
    Color(0xFFE0F2F1), // Light teal
    Color(0xFFF1F8E9), // Light green
    Color(0xFFFFF3E0), // Light peach
  ];

  @override
  Widget build(BuildContext context) {
    // Use article title hash for consistent color selection
    final Color selectedColor =
        colors[(article.title?.hashCode ?? 0).abs() % colors.length];

    return Container(
      width: 300,
      height: 480,
      decoration: BoxDecoration(
        color: selectedColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20.0,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title ?? "No Title",
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 7),

            Text(
              article.description ?? "No Description",
              style: const TextStyle(fontSize: 16, color: Colors.black),
              overflow: TextOverflow.ellipsis,
              maxLines: 6,
            ),
            SizedBox(height: 5),
            Text(
              'Source: ${article.source?.name}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: article.urlToImage ?? '',
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final String? url = article.url;
                  if (url == null || url.isEmpty) return;
                  if (!context.mounted) return;
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => WebViewScreen(
                        url: url,
                        title: article.title ?? 'Article',
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.open_in_new, size: 18),
                label: Text(
                  'Continue Reading',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
