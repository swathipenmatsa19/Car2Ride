import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/car.dart';
import '../controller/userhomepage_controller.dart';

class UserHomePage extends StatefulWidget{

  final User user;
  final List<Car> carList;

  UserHomePage(this.user,this.carList);

  @override
  State<StatefulWidget> createState() {
    return UserHomePageState(user,carList);
  }

}

class UserHomePageState extends State<UserHomePage>{

  User user;
  UserHomePageController controller;
  BuildContext context;
  List<Car> carList;
  List<int> deleteIndices;
  int _cIndex = 0;

  UserHomePageState(this.user,this.carList){
    controller = UserHomePageController(this);
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
                "User Home",
                style: TextStyle(fontSize: 20.0 ,color: Colors.black),
              ),
            ],
          ),
        ),
        elevation: 4.0, 
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
              label: Text('Search'),
              icon: Icon(Icons.search),
              onPressed: controller.search,
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
                onTap: controller.profile,
              ),
              ListTile(
                leading: Icon(Icons.card_travel),
                title: Text('Past Rides'),
                onTap: (){},
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title: Text('Chat'),
                onTap: controller.onChat,
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: controller.signOut,
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: carList.length,
          itemBuilder: (BuildContext context,int index){
            return Container(
              padding: EdgeInsets.all(5.0),
              color: deleteIndices != null && deleteIndices.contains(index) ?
              Colors.cyan[200] : Colors.white,
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
                //onLongPress: () => controller.longPress(index),
              ),
            );
          },
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _cIndex,
        //   type: BottomNavigationBarType.shifting ,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.filter,color: Color.fromARGB(255, 0, 0, 0)),
        //       title: new Text('filter')
              
        //     )
        //   ],
        //   onTap: (_cIndex) => controller.filter(_cIndex),
        // ),
      ),
    );
  }

}