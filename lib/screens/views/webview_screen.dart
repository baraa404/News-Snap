import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.url, this.title});

  final String url;
  final String? title;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() => _progress = progress);
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigations. Customize if you need to restrict domains.
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _openInBrowser() async {
    final uri = Uri.tryParse(widget.url);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title?.isNotEmpty == true ? widget.title! : 'Article';

    return PopScope(
      // Intercept back to support WebView history and Android predictive back.
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // Route already popped.
        if (await _controller.canGoBack()) {
          await _controller.goBack();
          return; // Stay on this route.
        }
        if (context.mounted) Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
          actions: [
            IconButton(
              tooltip: 'Refresh',
              onPressed: () => _controller.reload(),
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              tooltip: 'Open in browser',
              onPressed: _openInBrowser,
              icon: const Icon(Icons.open_in_browser),
            ),
          ],
          bottom: _progress < 100
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(3),
                  child: LinearProgressIndicator(
                    value: _progress / 100,
                    minHeight: 3,
                  ),
                )
              : null,
        ),
        body: SafeArea(child: WebViewWidget(controller: _controller)),
      ),
    );
  }
}

// Notes:
// - Ensure article URLs use HTTPS for iOS ATS. For HTTP, set NSAppTransportSecurity exceptions.
// - Android: INTERNET permission is required (usually already present). If not, add it to AndroidManifest.xml.
// - On Web, this widget falls back to the web implementation of webview_flutter.
