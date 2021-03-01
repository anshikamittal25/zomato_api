import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_search/app_state.dart';
import 'package:restaurant_search/data/options_data.dart';
import 'package:restaurant_search/models/category.dart';
import 'package:restaurant_search/services/zomato_api_calls.dart';

class FiltersPage extends StatefulWidget {

  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {

  List<Category> _categories;

  @override
  void initState() {
    getCategories().then((value) {
      setState(() {
        _categories = value.map((e) => Category.fromJson(e)).toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state=Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        //title: Consumer<String>(builder: (_,state,__)=>Text('Filter $state'),),
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
                      bool isSelected = state.searchOptions.categories
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
                              state.searchOptions.categories
                                  .add(_categories[index].id);
                            });
                          } else {
                            setState(() {
                              state.searchOptions.categories
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
              value: state.searchOptions.location,
              items: location.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  state.searchOptions.location = value;
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
            for (int i = 0; i < order.length; i++)
              RadioListTile(
                title: Text(order[i]),
                value: order[i],
                groupValue: state.searchOptions.order,
                onChanged: (selection) {
                  setState(() {
                    state.searchOptions.order = selection;
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
              children: sort.map<ChoiceChip>((sort) {
                return ChoiceChip(
                  label: Text(sort),
                  selected: state.searchOptions.sort == sort,
                  onSelected: (selected) {
                    if (selected)
                      setState(() {
                        state.searchOptions.sort = sort;
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
                value: state.searchOptions.count ?? 5,
                label: state.searchOptions.count.round().toString(),
                divisions: 3,
                min: 5,
                max: count,
                onChanged: (value) {
                  setState(() {
                    state.searchOptions.count = value;
                  });
                }),
            /*SizedBox(
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
                    Navigator.pop(context, state.searchOptions);
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
            )*/
          ],
        ),
      ),
    );
  }
}
