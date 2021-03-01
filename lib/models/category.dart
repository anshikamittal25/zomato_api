class Category{
  int id;
  String name;

  Category({this.id,this.name});

  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
      id: json['categories']['id'],
      name: json['categories']['name'],
    );
  }

}