import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../model/todo_model.dart';

class User_input extends StatelessWidget {
  final textController = TextEditingController();
  final Function insertFunction;
  User_input({required this.insertFunction, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
      color: Colors.blueGrey,
      child: Row(
        children: [
          Expanded(child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black45),
              borderRadius: BorderRadius.circular(5),
            ),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Add a new Todo',
                border: InputBorder.none
              ),
            ),)),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: (){
              var myTodo = Todo(
                title: textController.text,
                creationDate: DateTime.now(),
                isChecked: false, id: null,
              );
              insertFunction(myTodo);
            },
            child: Container(
              color: Colors.teal,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              child: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }
}
