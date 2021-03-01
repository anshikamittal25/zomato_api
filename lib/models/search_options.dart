class SearchOptions{
  List<int> categories = [];
  String location;
  String sort;
  String order;
  double count;

  SearchOptions({this.count,this.location,this.order,this.sort});

  Map<String,dynamic> toJson()=>{
    'location':location,
    'sort':sort,
    'order': order,
    'count':count,
    'category':categories.join(','),
  };

}