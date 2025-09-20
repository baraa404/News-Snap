import 'package:dio/dio.dart';
import '../modules/article.module.dart';

class NewsApiService {
  final Dio dio = Dio();

  Future<List<ArticleModel>> getNews({required String category}) async {
    try {
      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?category=$category&apiKey=77daf689b8924628b9f96b200033cf9d',
      );
      FullArticelsModel articels = FullArticelsModel.fromJson(response.data);
      return articels.articles;
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

  Future<List<ArticleModel>> getSearchNews({required String search}) async {
    try {
      Response response = await dio.get(
        'https://newsapi.org/v2/everything?q=$search&apiKey=77daf689b8924628b9f96b200033cf9d',
      );
      FullArticelsModel articels = FullArticelsModel.fromJson(response.data);
      return articels.articles;
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }
}
