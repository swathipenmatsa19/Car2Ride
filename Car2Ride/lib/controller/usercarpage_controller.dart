import 'package:bookreview/controller/myfirebase.dart';
import 'package:bookreview/model/review.dart';
import 'package:bookreview/view/usercarpage.dart';
import 'package:bookreview/view/mydialog.dart';
import 'package:bookreview/view/reviewhomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCarPageController{
  UserCarPageState state;
  

  UserCarPageController(this.state);

  String validateImageUrl(String value){
    if(value == null || value.length < 5){
      return 'Enter image URL beginning with http';
    }
    return null;
  }

  void saveImageUrl(String value){
    state.carCopy.imageUrl = value;
  }

  String validateName(String value){
    if(value == null || value.length < 5){
      return 'Enter car name';
    }
    return null;
  }

  void saveName(String value){
    state.carCopy.carName = value;
  }

  String validatePrice(String value){
    if(value == null){
      return 'Enter car price';
    }
    try{
      int.parse(value);
    }catch(e){
      return 'Enter price in numbers';
    }
    return null;
  }

  void savePrice(String value){
    state.carCopy.price = int.parse(value);
  }

  String validateMakeyear(String value){
    if(value == null ){
      return 'Enter Make year';
    }
    try{
      int.parse(value);
    }catch(e){
      return 'Enter Make year in numbers';
    }
    return null;
  }

  void saveMakeyear(String value){
    state.carCopy.makeYear= int.parse(value);
  }

  // String validateSharedWith(String value){
  //   if(value == null || value.trim().isEmpty){
  //     return null; // no sharing
  //   }
  //   for(var email in value.split(',')){
  //     if(!(email.contains('.') && email.contains('@'))){
  //       return 'Enter comma(,) separated email list';
  //     }
  //     if(email.indexOf('@') != email.lastIndexOf('@')){
  //       return 'Enter comma(,) separated email list';
  //     }
  //   }
  //   return null;
  // }

  // void saveSharedWith(String value){
  //   if(value == null || value.trim().isEmpty){
  //     return;
  //   }
  //   state.carCopy.sharedWith = [];
  //   List<String> emailList = value.split(',');
  //   for(var email in emailList){
  //     state.carCopy.sharedWith.add(email.trim());
  //   }
  // }

  String validateBrand(String value){
    if(value == null || value.length < 2){
      return 'Enter brand(min 2 chars)';
    }
    return null;
  }

  void saveBrand(String value){
    state.carCopy.brand = value;
  }

  String validateColor(String value){
    if(value == null || value.length < 2){
      return 'Enter color(min 2 chars)';
    }
    return null;
  }

  void saveColor(String value){
    state.carCopy.color = value;
  }


  

   void reviewPage() async{

     String value = state.car.documentId;
     List<Review> reviewList;
     reviewList = await MyFireBase.getReviews(value);
     
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ReviewHomePage(state.car,reviewList),
      
    ));
  }

  void save() async{
    if(!state.formKey.currentState.validate()){
      return;
    }
    state.formKey.currentState.save();


    state.carCopy.createdBy = state.user.email;
    state.carCopy.lastUpdatedAt = DateTime.now();
    try{
      if(state.car == null){
        //add button
      state.carCopy.documentId = await MyFireBase.addBook(state.carCopy);
      }else{
        //from homepage to edit a book
        await MyFireBase.updateBook(state.carCopy);
      }
      Navigator.pop(state.context,state.carCopy);
    }catch(e){
      MyDialog.info(
        context: state.context,
        title: 'Firestore save error',
        message:'Firestore is unavailable now.Try again later',
        action: () {
          Navigator.pop(state.context);
          Navigator.pop(state.context,null);
        }
      );
    }
    
  }
}
	
