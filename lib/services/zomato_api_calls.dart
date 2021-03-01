import 'package:dio/dio.dart';
import 'package:restaurant_search/models/search_options.dart';

Dio dio = Dio(BaseOptions(
  baseUrl: 'https://developers.zomato.com/api/v2.1/',
  headers: {'user-key': '505272870e7baedae710c4dd5e403d80'},
));

Future<List> getRestaurants(String q, SearchOptions _searchOptions) async {
  List restaurants = [];

  try {
    final res = await dio.get('search', queryParameters: {
      'q': q,
      ...(_searchOptions != null ? _searchOptions.toJson() : {}),
    });
    restaurants = res.data['restaurants'];
    //print(restaurants);
  } catch (e) {
    print(e.toString());
  }
  return restaurants;
}

Future<List> getCategories() async {
  List categories = [];

  try {
    final res = await dio.get('categories');
    categories = res.data['categories'];
    //print(categories);
  } catch (e) {
    print(e.toString());
  }

  return categories;
}
