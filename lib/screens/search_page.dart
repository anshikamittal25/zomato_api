import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_search/models/restaurant.dart';
import 'package:restaurant_search/services/zomato_api_calls.dart';
import 'package:restaurant_search/tiles/restaurant_tile.dart';
import 'package:restaurant_search/models/search_options.dart';
import 'package:zomato_client/model/categories.dart';
import 'package:zomato_client/model/cities.dart';
import 'package:zomato_client/model/collections.dart';
import 'package:zomato_client/model/cuisines.dart';
import 'package:zomato_client/zomato_client.dart';

import 'filters_page.dart';

class SearchPage extends StatefulWidget {
  final String title;
  SearchPage({this.title, Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();
  bool isSearched;
  SearchOptions _searchOptions;

  @override
  initState() {
    isSearched = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              children: [
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        autofocus: true,
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search for a restaurant',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isSearched = true;
                        // hide keyboard after search icon is pressed
                        FocusManager.instance.primaryFocus.unfocus();
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.filter_list_alt,
                  ),
                  onPressed: () async {
                    _searchOptions = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FiltersPage()));
                  },
                ),
              ],
            ),
            if (!isSearched)
              Expanded(
                child: Center(
                  child: Icon(
                    Icons.search,
                    size: MediaQuery.of(context).size.width / 2,
                    color: Colors.grey[350],
                  ),
                ),
              )
            else
              Expanded(
                child: FutureBuilder(
                  future: getRestaurants(_searchController.text,_searchOptions),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Something went wrong!'));
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return (snapshot.data.length == 0)
                          ? Center(
                              child: Text('No restaurants found!'),
                            )
                          : ListView(
                              children: snapshot.data.map<Widget>((json) {
                                final restaurant = Restaurant.fromJson(json);
                                return restaurantTile(restaurant);
                              }).toList(),
                            );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
