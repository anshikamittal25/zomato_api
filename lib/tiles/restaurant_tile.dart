import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_search/models/restaurant.dart';

Widget restaurantTile(Restaurant restaurant){
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    clipBehavior: Clip.antiAlias,
    child: Row(
      children: [
        Container(
          color: Colors.grey,
          height: 100,
          width: 100,
          child:  (restaurant.thumbnail!=null && restaurant.thumbnail!='') ? Image.network(restaurant.thumbnail,fit: BoxFit.cover,) : Icon(Icons.restaurant_sharp,size: 50,color: Colors.white,),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                SizedBox(height: 7,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    Text(restaurant.locality),
                  ],
                ),
                SizedBox(height: 7,),
                RatingBarIndicator(
                  rating: double.parse(restaurant.rating),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}