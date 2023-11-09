import 'package:flutter/material.dart';
import 'package:todoapp/constatnt/colors.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/widgets/ToDoItem.dart';

class home extends StatefulWidget {
  home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final todoList = ToDo.todoList();
  final _toDoControllers = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: theBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 0,
                  ),
                  searchBox(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 8),
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 20),
                            child: const Text(
                              "All ToDos",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: theBlack,
                              ),
                            ),
                          ),
                          for (ToDo todo in _foundToDo.reversed)
                            ToDoItem(
                              toDo: todo,
                              onDeleteItem: _dleteItem,
                              onToDoChanged: _handleToDoChange,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _toDoControllers,
                        decoration: InputDecoration(
                          hintText: "Add new item",
                          border: InputBorder.none,
                        ),
                      ),
                    )),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: ElevatedButton(
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 40),
                        ),
                        onPressed: () {
                          _addItem(_toDoControllers.text);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: theBlue, minimumSize: Size(60, 60)),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _dleteItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addItem(String toDo) {
    setState(() {
      if (!toDo.isEmpty) {
        todoList.add(ToDo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: toDo));
      }
    });
    _toDoControllers.clear();
  }

  void _runSearch(String key) {
    List<ToDo> result = [];
    if (key.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where((item) =>
              item.todoText!.toLowerCase().contains(key.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }

  Padding searchBox() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 236, 236),
            borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            onChanged: (value) => _runSearch(value),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: theBlack,
                ),
                prefixIconConstraints: BoxConstraints(
                  maxHeight: 20,
                  maxWidth: 20,
                ),
                border: InputBorder.none,
                hintText: "Search"),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: theBGColor,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: theBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRect(child: Image.asset('assets/2.png')),
        )
      ]),
    );
  }
}
