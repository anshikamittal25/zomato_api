class Restaurant {
  String name;
  String id;
  String address;
  String locality;
  String thumbnail;
  String rating;
  String reviews;

  Restaurant(
      {this.address,
      this.name,
      this.reviews,
      this.rating,
      this.id,
      this.locality,
      this.thumbnail});

  factory Restaurant.fromJson(Map json) {
    return Restaurant(
        name: json['restaurant']['name'],
        id: json['restaurant']['id'],
        address: json['restaurant']['location']['address'],
        locality: json['restaurant']['location']['locality'],
        rating:
            json['restaurant']['user_rating']['aggregate_rating'].toString(),
        reviews: json['restaurant']['all_reviews_count'].toString(),
        thumbnail: json['restaurant']['featured_image'] ??
            json['restaurant']['thumb']);
  }
}
