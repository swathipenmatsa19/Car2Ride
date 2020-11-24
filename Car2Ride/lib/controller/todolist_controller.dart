import '../view/todolist.dart';
import 'package:flutter/material.dart';

class ToDoListController{

 ToDoListState state;
 ToDoListController(this.state);

 List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
  // Only add the task if the user actually entered something
  if(task.length > 0) {
    state.setState(() => _todoItems.add(task));
  }
}

  

  void _removeTodoItem(int index) {
    state.setState(() => _todoItems.removeAt(index));
  }

  void _promptRemoveTodoItem(int index) {
  showDialog(
    context: state.context,
    builder: (BuildContext context) {
      return new AlertDialog(
        title: new Text('Mark "${_todoItems[index]}" as done?'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () => Navigator.of(context).pop()
          ),
          new FlatButton(
            child: new Text('MARK AS DONE'),
            onPressed: () {
              _removeTodoItem(index);
              Navigator.of(context).pop();
            }
          )
        ]
      );
    }
  );
}

 // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index],index);
        }
      },
    );
  }

  Widget _buildTodoItem(String todoText,int index) {
    return new ListTile(
      title: new Text(todoText),
      onTap: () => _promptRemoveTodoItem(index)
    );
  }

  Widget _pushAddTodoScreen() {
  // Push this page onto the stack
  Navigator.of(state.context).push(
    // MaterialPageRoute will automatically animate the screen entry, as well
    // as adding a back button to close it
    new MaterialPageRoute(
      builder: (context) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Add a new task')
          ),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              _addTodoItem(val);
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
              hintText: 'Enter something to do...',
              contentPadding: const EdgeInsets.all(16.0)
            ),
          )
        );
      }
    )
  );
}


}