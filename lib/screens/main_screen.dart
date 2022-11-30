import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/database.dart';
import 'components/dialog_box.dart';
import 'components/side_menu.dart';
import 'components/todo_main_screen.dart';
import 'main_screen_final.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _myBox = Hive.box('myBox');
  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    //if this is the first time ever opening the app
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // checkbox ws tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  //create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
          controller: _controller,
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 7,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5F72BE), Color(0xFF9921E8)]),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 28),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, right: 16, bottom: 5),
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://imgs.search.brave.com/HWuv9maTqzHy8xy-_tHhOjvl_epLamGDX_wITpzn-VA/rs:fit:820:526:1/g:ce/aHR0cHM6Ly9pbWcu/ZmF2cG5nLmNvbS8y/NS8xLzE3L2F2YXRh/ci11c2VyLWNvbXB1/dGVyLWljb25zLXNv/ZnR3YXJlLWRldmVs/b3Blci1wbmctZmF2/cG5nLTdTYkZwTmVx/S3FoaFRycnJuSEZV/cWs2VTQuanBn"),
            ),
          )
        ],
      ),
      drawer: const SideMenu(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          setState(() {
            createNewTask();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Column(children: [

        Card(
          elevation: 7,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: const Text(
              'Create Your Projects',
              style: TextStyle(
                fontSize: 23,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (BuildContext context, int index) {
              return ToDoMainTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
