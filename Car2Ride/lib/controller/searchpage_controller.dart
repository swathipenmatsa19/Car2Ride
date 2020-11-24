import '../view/searchpage.dart';
import '../model/car.dart';
import '../controller/myfirebase.dart';

class SearchPageController{
  SearchPageState state;
    List<Car> carList;
  List<int> deleteIndices;
  String searchValue;
   var items = List<Car>();

  SearchPageController(this.state);

  String validateResult(String test){
    if(test == null || test.length < 3){
      return 'Enter proper brand';
    }
    return null;
  }

  void saveResult(String test){
    state.searchValue = test;
  }

  void filterSearchResults(String query) {
    List<Car> dummySearchList = List<Car>();
    dummySearchList.addAll(carList);
    if(query.isNotEmpty) {
      //print('Test checking****');
      List<Car> dummyListData = List<Car>();
      dummySearchList.forEach((item) {
        if(item.carName.contains(query)) {
          dummyListData.add(item);
        }
      });
      state.setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
     } else {
      state.setState(() {
        items.clear();
        items.addAll(carList);
      });
    }
}


  // void searchValue() async{
  //   if(!state.formKey.currentState.validate()){
  //     return;
  //   }

  //   state.formKey.currentState.save();
  //   List<Car> carList;
  // try{
    
  //   carList = await MyFireBase.getResults(state.searchValue);
  // }catch(e){
  //   carList = <Car>[];
  // }
  // }
}