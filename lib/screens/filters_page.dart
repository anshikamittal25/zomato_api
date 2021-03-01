import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_search/models/category.dart';
import 'package:restaurant_search/models/search_options.dart';
import 'package:restaurant_search/services/zomato_api_calls.dart';

class FiltersPage extends StatefulWidget {
  final location = ['city', 'subzone', 'zone', 'landmark', 'metro', 'group'];
  final order = ['asc', 'desc'];
  final sort = ['cost', 'rating'];
  final double count = 20;

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  SearchOptions _searchOptions;
  List<Category> _categories;

  @override
  void initState() {
    getCategories().then((value) {
      setState(() {
        _categories = value.map((e) => Category.fromJson(e)).toList();
      });
    });
    _searchOptions = SearchOptions(
        location: widget.location[0],
        sort: widget.sort[0],
        order: widget.order[0],
        count: widget.count);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text(
              'Categories:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            _categories != null
                ? Wrap(
                    spacing: 10,
                    children:
                        List<Widget>.generate(_categories.length, (index) {
                      bool isSelected = _searchOptions.categories
                          .contains(_categories[index].id);
                      return FilterChip(
                        selectedColor: Theme.of(context).accentColor,
                        selected: isSelected,
                        checkmarkColor: Colors.white,
                        label: Text(_categories[index].name),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: (isSelected)
                                ? Colors.white70
                                : Theme.of(context).textTheme.bodyText1.color),
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              _searchOptions.categories
                                  .add(_categories[index].id);
                            });
                          } else {
                            setState(() {
                              _searchOptions.categories
                                  .remove(_categories[index].id);
                            });
                          }
                        },
                      );
                    }),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Location Type',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            DropdownButton<String>(
              isExpanded: true,
              value: _searchOptions.location,
              items: widget.location.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _searchOptions.location = value;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Order By:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            for (int i = 0; i < widget.order.length; i++)
              RadioListTile(
                title: Text(widget.order[i]),
                value: widget.order[i],
                groupValue: _searchOptions.order,
                onChanged: (selection) {
                  setState(() {
                    _searchOptions.order = selection;
                  });
                },
              ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Sort By:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Wrap(
              spacing: 10,
              children: widget.sort.map<ChoiceChip>((sort) {
                return ChoiceChip(
                  label: Text(sort),
                  selected: _searchOptions.sort == sort,
                  onSelected: (selected) {
                    if (selected)
                      setState(() {
                        _searchOptions.sort = sort;
                      });
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '# of results to show:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Slider(
                value: _searchOptions.count ?? 5,
                label: _searchOptions.count.round().toString(),
                divisions: 3,
                min: 5,
                max: widget.count,
                onChanged: (value) {
                  setState(() {
                    _searchOptions.count = value;
                  });
                }),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, _searchOptions);
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Apply',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
