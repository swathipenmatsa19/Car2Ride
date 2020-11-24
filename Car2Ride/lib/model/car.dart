import 'package:flutter/material.dart';

class Car{
  String documentId;  //firestore doc id
  String carName;
  String color;
  int makeYear;
  String imageUrl;
  String brand;
  int price;
  //String review;
  String createdBy;
  DateTime lastUpdatedAt;  //created or revised
  //List<dynamic> sharedWith;

  Car({
    this.carName,
    this.color,
    this.makeYear,
    this.imageUrl,
    this.brand,
    this.price,
    //this.review,
    this.createdBy,
    this.lastUpdatedAt,
    //this.sharedWith,
  });

  Car.empty(){
    this.carName = '';
    this.color = '';
    this.makeYear = 1990;
    this.imageUrl = '';
    this.brand = '';
    this.price = 0;
    this.createdBy = '';

    //this.sharedWith = <dynamic>[];
  }

  Car.clone(Car b){
    this.documentId = b.documentId;
    this.carName = b.carName;
    this.color = b.color;
    this.makeYear = b.makeYear;
    //this.review = b.review;
    this.brand = b.brand;
    this.price = b.price;
    this.imageUrl = b.imageUrl;
    this.lastUpdatedAt = b.lastUpdatedAt;
    this.createdBy = b.createdBy;
    //this.sharedWith = <dynamic>[]..addAll(b.sharedWith);  //deep copy
  }

  Map<String,dynamic> serialize(){
    return <String,dynamic>{
      CARNAME:carName,
      COLOR:color,
      MAKEYEAR:makeYear,
      IMAGEURL:imageUrl,
      BRAND:brand,
      PRICE:price,
      CREATEDBY:createdBy,
      LASTUPDATEDAT:lastUpdatedAt,
      //SHAREDWITH:sharedWith,
    };
  }

  static Car deserialize(Map<String,dynamic>data,String docId){
    var car= Car(
      carName: data[Car.CARNAME],
      color: data[Car.COLOR],
      makeYear:data[Car.MAKEYEAR],
      imageUrl: data[Car.IMAGEURL],
      brand: data[Car.BRAND],
      price: data[Car.PRICE],
      createdBy: data[Car.CREATEDBY],
      //sharedWith: data[Car.SHAREDWITH],
    );
    if(data[Car.LASTUPDATEDAT] != null){
      car.lastUpdatedAt = DateTime.fromMicrosecondsSinceEpoch(
        data[Car.LASTUPDATEDAT].millisecondsSinceEpoch
      );
      car.documentId = docId;
      return car;

    }
  }

  //static const BOOKSCOLLECTION = 'books';
  static const CARSSCOLLECTION = 'cars';
  static const CARNAME = 'carName';
  static const COLOR = 'color';
  static const MAKEYEAR = 'makeYear';
  static const IMAGEURL = 'imageUrl';
  static const BRAND = 'brand';
  static const PRICE = 'price';
  static const CREATEDBY = 'createdBy';
  static const LASTUPDATEDAT = 'lastUpdatedAt';
  //static const SHAREDWITH = 'sharedWith';


}