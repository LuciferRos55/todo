import 'package:flutter/material.dart';
import 'package:todo/model/db_model.dart';
import '../model/todo_model.dart';
import '../widgets/user_input.dart';
import '../widgets/todo_list.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var db = DatabaseConnect();
  
  void addItem(Todo todo) async{
    await db.insertTodo(todo);
    setState(() {});
  }
  void deleteItem(Todo todo) async{
    await db.deleteTodo(todo);
    setState(() {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          title: const Text('18127069 - Todo app'),
      ),
      body: Column(
        children: [
          Todolist(insertFunction: addItem, deleteFunction: deleteItem,),
          User_input(insertFunction: addItem,),
        ],
      )
    );
  }
}
