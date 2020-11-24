import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/car.dart';
import '../controller/homepage_controller.dart';

class HomePage extends StatefulWidget{

  final User user;
  final List<Car> carList;

  HomePage(this.user,this.carList);

  @override
  State<StatefulWidget> createState() {
    return HomePageState(user,carList);
  }

}

class HomePageState extends State<HomePage>{

  User user;
  HomePageController controller;
  BuildContext context;
  List<Car> carList;
  List<int> deleteIndices;


  HomePageState(this.user,this.carList){
    controller = HomePageController(this);
  }

  void stateChanged(Function fn){
    setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
          onWillPop: (){return Future.value(false);},
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                "Admin Home",
                style: TextStyle(fontSize: 20.0 ,color: Colors.black),
              ),
            ],
          ),
        ),
        elevation: 4.0, 
        centerTitle: true,
          actions: deleteIndices == null ? <Widget>[
            FlatButton.icon(
              label: Text('Search'),
              icon: Icon(Icons.search),
              onPressed: controller.search,
            ),
          ]
          :<Widget>[
            FlatButton.icon(
              label: Text('Delete'),
              icon: Icon(Icons.delete),
              onPressed: controller.deleteButton,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(user.displayName),
                accountEmail: Text(user.email),
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Profile'),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.check),
                title: Text('ToDoList'),
                onTap: controller.todoList,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: controller.signOut,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: controller.addButton,
        ),
        body: ListView.builder(
          itemCount: carList.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
              padding: EdgeInsets.all(5.0),
              color: deleteIndices != null && deleteIndices.contains(index) ?
              Colors.cyan[200] : Colors.white,
              child: Card(
                elevation: 40.0,
                
                child: ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: carList[index].imageUrl,
                    placeholder: (context,url) => CircularProgressIndicator(),
                    errorWidget: (context,url,error) => Icon(Icons.error_outline),
                  ),
                  title: Text(carList[index].carName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(carList[index].documentId),
                      Text(carList[index].price.toString()),
                      Text(carList[index].makeYear.toString()),
                    ],
                  ),
                  onTap:()=> controller.onTap(index),
                  onLongPress: () => controller.longPress(index),
                ),
              ),
              
            );
          },
        ),
      ),
    );
  }

}