import 'package:restaurant_search/models/search_options.dart';

import 'data/options_data.dart';

class AppState {
  final SearchOptions searchOptions = SearchOptions(
    location: location[0],
    sort: sort[0],
    order: order[0],
    count: count,
  );
}
