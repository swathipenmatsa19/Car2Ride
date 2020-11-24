import 'package:bookreview/controller/myfirebase.dart';
import 'package:flutter/material.dart';
import '../model/car.dart';
import '../view/homepage.dart';
import '../view/carpage.dart';
//import '../view/sharedbookpage.dart';
import '../view/timer.dart';
import '../view/frontpage.dart';
import '../view/todolist.dart';
import '../view/searchpage.dart';

class HomePageController{

  HomePageState state;

  HomePageController(this.state);

  void signOut(){
    MyFireBase.signOut();
    Navigator.pop(state.context); //to close the drawer at homepage
    //Navigator.pop(state.context); //to return to the front page
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => FrontPage(),
    ));
  }

  void todoList(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => ToDoList(),
    ));
  }

  void addButton() async{
    Car b = await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => CarPage(state.user,null),
    ));
    if(b != null){
      //new book stored in firebase
      state.carList.add(b);
    }else{
      //error occured in storing in Firebase
    }
  }

  void onTap(int index) async{
    if(state.deleteIndices == null){
      //navigate to bookpage
      Car b = await Navigator.push(state.context, MaterialPageRoute(
        builder: (context) => CarPage(state.user, state.carList[index])
      ));

      if(b != null){
        //updated book is stored in Firebase
        state.carList[index] = b;
      }
    }else{
      
      state.setState((){
        //add to delete list
      if(state.deleteIndices.contains(index)){
        //tapped again -> deselect
        state.deleteIndices.remove(index);
        if(state.deleteIndices.length == 0){
          //all deselected. delete mode quits
          state.deleteIndices = null;
        }
      }else{
        state.deleteIndices.add(index);
      }
      });
    }
  }

  void longPress(int index){
    if(state.deleteIndices == null){
      //begin delete mode
      state.stateChanged((){
        state.deleteIndices = <int>[index];
      });
    }
  }

  void deleteButton() async{

    //sort descending order of deletionindices
    state.deleteIndices.sort((n1,n2){
      if(n1 < n2) return 1;
      else if(n1 == n2) return 0;
      else return -1;
    });

    //deleteIndices: [a,b,c,d]
    for(var index in state.deleteIndices){
      try{
         await MyFireBase.deleteBook(state.carList[index]);
         state.carList.removeAt(index);
      }catch(e){
        print('BOOK DELETE ERROR:' + e.toString());
      }
    }

    state.stateChanged((){
      state.deleteIndices = null;
    });
  }

  // void sharedWithMeMenu() async{
  //   List<Car> books = await MyFireBase.getBooksSharedWithMe(state.user.email);
  //   print('# of books: ' + books.length.toString());
  //   for(var book in books){
  //     print(book.title);
  //   }
  //   // navigate to a new page for SharedBooks
  //   await Navigator.push(state.context, MaterialPageRoute(
  //     builder: (context) => SharedBooksPage(state.user,books),

  //   ));
  //   Navigator.pop(state.context);  //closes the drawer
  // }

  void timer() async{
    await Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => TimerApp(),
    ));
  }

  void search(){
    Navigator.push(state.context, MaterialPageRoute(
      builder: (context) => SearchPage(state.user,state.carList),
    ));
  }

}