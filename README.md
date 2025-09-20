![News App Logo](assets/images/blackLogo.png)

# Flutter News App

A fast, minimal, and modern news reader built with Flutter and powered by NewsAPI.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
![Dart SDK](https://img.shields.io/badge/Dart-%5E3.8.1-0175C2?logo=dart&logoColor=white)
![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-success)
![License](https://img.shields.io/badge/License-MIT-informational)

## Overview

This app shows top headlines by category and supports full-text search across articles. It uses:

- dio for HTTP
- cached_network_image for image caching
- webview_flutter to open full articles
- Custom UI widgets for a smooth, animated experience

Dark theme is enabled by default.

## Features

- Browse top headlines by category (e.g., business, sports, tech)
- Search news by keyword
- Smooth image loading with caching
- In-app article viewing (WebView)
- Mobile-first with support for Android, iOS, Web, and Desktop

## Demo

![App Demo](showcase/video.gif)

## Screenshots

<p>
	<img alt="Home" src="showcase/screenshot1.png" width="30%" />
	<img alt="Categories" src="showcase/screenshot2.png" width="30%" />
	<img alt="Article" src="showcase/screenshot3.png" width="30%" />
  
</p>

## Tech Stack

- Flutter 3.x, Dart (SDK ^3.8.1)
- Packages: dio, cached_network_image, webview_flutter, url_launcher, google_fonts

## Architecture

- `lib/services/` — API services (NewsAPI integration via `NewsApiService`)
- `lib/modules/` — Data models (`ArticleModel`, `FullArticelsModel`)
- `lib/screens/` — UI screens and views
- `lib/widgets/` — Reusable components (e.g., animated tabs, swipeable stack)

Data flow:

1. `NewsApiService` fetches JSON using dio
2. Responses are parsed into models
3. Screens render lists/cards and open details in a WebView

## Project Structure

```
lib/
	main.dart
	modules/
		article.module.dart
	screens/
		views/
		widgets/
	services/
		news_api.service.dart
	widgets/
		animated_tab_selector.dart
		swipeable_stack.dart
assets/
	images/
```


## Acknowledgements

- News data from NewsAPI.org
- Flutter and the Dart team

