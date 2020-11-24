import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/car.dart';
//import '../controller/userhomepage_controller.dart';
import '../controller/searchpage_controller.dart';

class SearchPage extends StatefulWidget{

  final User user;
  final List<Car> carList;
  
  SearchPage(this.user,this.carList);

  @override
  State<StatefulWidget> createState() {
    return SearchPageState(user,carList);
  }

}

class SearchPageState extends State<SearchPage>{

  User user;
  SearchPageController controller;
  BuildContext context;
  List<Car> carList;
  List<int> deleteIndices;
  String searchValue;
   var items = List<Car>();

@override
  void initState() {
    items.addAll(carList);
    
    super.initState();
  }

  SearchPageState(this.user,this.carList){
    controller = SearchPageController(this);
  }

  void stateChanged(Function fn){
    setState(fn);
  }

  void filterSearchResults(String query) {
    List<Car> dummySearchList = List<Car>();
    dummySearchList.addAll(carList);
    if(query.isNotEmpty) {
      //print('Test checking****');
      List<Car> dummyListData = List<Car>();
      dummySearchList.forEach((item) {
        if(item.carName.contains(query) ) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
     } else {
      setState(() {
        items.clear();
        items.addAll(carList);
      });
    }
}

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
          onWillPop: (){return Future.value(true);},
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
                "Search Page",
                style: TextStyle(fontSize: 20.0 ,color: Colors.black),
              ),
            ],
          ),
        ),
        elevation: 4.0, 
        centerTitle: true,
        ),
        
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                //controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
              // TextFormField(
              //  // initialValue: user.password,
              // autocorrect: false,
              // obscureText: true,
              // decoration: InputDecoration(
              //   hintText: 'Enter Search',
              //   labelText: 'Enter Search'
              // ),
              // validator: controller.validateResult,
              // onSaved: controller.saveResult,
              // ),
              // FlatButton(
              //   child: Text('Submit'),
              //   onPressed: controller.searchValue,
              // ),
              Expanded(
                      child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context,int index){
                return Container(
                  padding: EdgeInsets.all(5.0),
                  color: deleteIndices != null && deleteIndices.contains(index) ?
                  Colors.cyan[200] : Colors.white,
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: items[index].imageUrl,
                      placeholder: (context,url) => CircularProgressIndicator(),
                      errorWidget: (context,url,error) => Icon(Icons.error_outline),
                    ),
                    title: Text(items[index].carName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(items[index].documentId),
                        Text(items[index].price.toString()),
                        Text(items[index].makeYear.toString()),
                      ],
                    ),
                    //onTap:()=> controller.onTap(index),
                    //onLongPress: () => controller.longPress(index),
                  ),
                );
              },
            ),
          ),
            ],
          )
          
        ),
      ),
    );
  }

}