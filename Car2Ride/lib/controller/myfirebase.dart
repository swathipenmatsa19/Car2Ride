import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.dart';
import '../model/car.dart';
import '../model/review.dart';

class MyFireBase{

  static Future<String> createAccount({String email, String password}) async{
    AuthResult auth  = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return auth.user.uid;
  }

  static void createProfile(User user) async{
    await Firestore.instance.collection(User.PROFILE_COLLECTION)
               .document(user.uid)
               .setData(user.serialize());
  }

  static Future<String> login({String email,String password}) async{
    AuthResult auth = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return auth.user.uid;
  }

  static Future<User> readProfile(String uid) async{
    DocumentSnapshot doc = await Firestore.instance.collection(User.PROFILE_COLLECTION)
         .document(uid).get();
    return User.deserialiize(doc.data);
  }

  static void signOut(){
    FirebaseAuth.instance.signOut();
  }

  static Future<String> addBook(Car car) async {
    DocumentReference ref = await Firestore.instance.collection(Car.CARSSCOLLECTION)
                            .add(car.serialize());
    return ref.documentID;
  }

  static Future<List<Car>> getBooks() async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection(Car.CARSSCOLLECTION)
          //.where(Car.CREATEDBY, isEqualTo: email )
          .getDocuments();
    var carList = <Car>[];
    if(querySnapshot == null || querySnapshot.documents.length == 0){
      return carList;
    }
    for(DocumentSnapshot doc in querySnapshot.documents){
      carList.add(Car.deserialize(doc.data,doc.documentID));
    }
    return carList;
  }

  // static Future<List<Car>> getResults(String value) async{
  //   QuerySnapshot querySnapshot = await Firestore.instance.collection(Car.CARSSCOLLECTION)
  //         .where(Car.BRAND, isEqualTo: value )
  //         .getDocuments();
  //   var carList = <Car>[];
  //   if(querySnapshot == null || querySnapshot.documents.length == 0){
  //     return carList;
  //   }
  //   for(DocumentSnapshot doc in querySnapshot.documents){
  //     carList.add(Car.deserialize(doc.data,doc.documentID));
  //   }
  //   return carList;
  // }

  static Future<void> updateBook(Car car) async{
    await Firestore.instance.collection(Car.CARSSCOLLECTION)
             .document(car.documentId)
             .setData(car.serialize());
  }

  static Future<void> deleteBook(Car car) async{
    await Firestore.instance.collection(Car.CARSSCOLLECTION)
               .document(car.documentId).delete();
  }

  // static Future<List<Car>> getBooksSharedWithMe(String email) async{
  //   try{
  //     QuerySnapshot querySnapshot = await Firestore.instance.collection(Car.CARSSCOLLECTION)
  //                                .where(Car.SHAREDWITH,arrayContains:email)
  //                               . orderBy(Car.CREATEDBY)
  //                               .orderBy(Car.LASTUPDATEDAT)
  //                               .getDocuments();
  //     var car = <Car>[];
  //     if(querySnapshot == null || querySnapshot.documents.length == 0){
  //       return car;
  //     }
  //     for(DocumentSnapshot doc in querySnapshot.documents){
  //       car.add(Car.deserialize(doc.data, doc.documentID));
  //     }
  //     return car;
  //   }catch(e){
  //     throw e;
  //   }
  // }

  static Future<String> resetPassword(String email) async{
     await FirebaseAuth.instance.sendPasswordResetEmail(email:email);
    
  }

  static Future<void> updateUser(User user) async {
  await Firestore.instance.collection(User.PROFILE_COLLECTION)
  .document(user.uid)
  .setData(user.serialize());
}

static Future<List<Review>> getReviews(String value) async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection(Review.REVIEWSCOLLECTION)
          .where(Review.CARID, isEqualTo: value )
          .getDocuments();
    var reviewList = <Review>[];
    if(querySnapshot == null || querySnapshot.documents.length == 0){
      return reviewList;
    }

    for(DocumentSnapshot doc in querySnapshot.documents){
      reviewList.add(Review.deserialize(doc.data,doc.documentID));
    }
    return reviewList;
  }

  static Future<String> addReview(Review review) async {
    DocumentReference ref = await Firestore.instance.collection(Review.REVIEWSCOLLECTION)
                            .add(review.serialize());
    return ref.documentID;
  }

}