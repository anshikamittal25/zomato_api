import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_search/app_state.dart';
import 'package:restaurant_search/screens/search_page.dart';

void main() {
  runApp(Provider(
    create: (context) => AppState(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _title = 'Restaurant Finder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SearchPage(title: _title),
    );
  }
}
