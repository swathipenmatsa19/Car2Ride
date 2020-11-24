import 'package:bookreview/controller/myfirebase.dart';
import 'package:bookreview/model/review.dart';
import 'package:bookreview/view/mydialog.dart';
import 'package:bookreview/view/reviewhomepage.dart';
import 'package:bookreview/view/reviewpage.dart';
import 'package:flutter/material.dart';

class ReviewHomePageController {
  ReviewHomePageState state;
  ReviewHomePageController(this.state);
  

  void saveReview(String value) {
    state.reviewCopy.reviewName = value;
  }

  String validateReview(String value) {
    if (value == null || value.length < 5) {
      return 'Enter book review';
    }
    return null;
  }

  void getReviews() async{
    String value;
    state.car.documentId = value;
    List<Review> reviews;
    reviews =await MyFireBase.getReviews(value);
  }

  
  void addReview() async{
    Review b = await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ReviewPage(state.car,null),
    ));
    if(b != null){
      //new book stored in firebase
      state.reviewList.add(b);
    }else{
      //error occured in storing in Firebase
    }
  }


  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();
    state.reviewCopy.carid = state.car.documentId;
   // state.reviewCopy.lastUpdatedAt = DateTime.now();
    try {
      if (state.reviewCopy == null) {
        state.reviewCopy.documentId = await MyFireBase.addReview(state.reviewCopy);
      }
      // } else {
      //   await MyFirebase.updateReview(state.bookCopy);
      // }
      Navigator.pop(state.context, state.reviewCopy);
    } catch (e) {
      MyDialog.info(
          context: state.context,
          title: 'FireStore save error',
          message: 'firestore is unavilable now try again ',
          action: () {
            Navigator.pop(state.context);
            Navigator.pop(state.context, null);
          });
    }
  }
}

	
	
	
