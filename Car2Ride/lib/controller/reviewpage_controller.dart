import 'package:bookreview/controller/myfirebase.dart';
import 'package:bookreview/view/mydialog.dart';
import 'package:bookreview/view/reviewpage.dart';
import 'package:flutter/material.dart';
//import '../view/bookpage.dart';

class ReviewPageController {
  ReviewPageState state;
  ReviewPageController(this.state);
  String validateReview(String value) {
    if (value == null ) {
      return 'Enter review';
    }
    return null;
  }

  void saveReview(String value) {
    state.reviewCopy.carid = state.car.documentId;
    state.reviewCopy.reviewName = value;
  }

  

  void save() async {
    if (!state.formKey.currentState.validate()) {
      return;
    }
    state.formKey.currentState.save();
    //state.bookCopy.createdBy = state.user.email;
    //state.bookCopy.lastUpdatedAt = DateTime.now();
    try {
     if (state.review == null) {
        state.reviewCopy.documentId = await MyFireBase.addReview(state.reviewCopy);
      } 
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

	
	
	
