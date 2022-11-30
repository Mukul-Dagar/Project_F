import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../data/database1.dart';
import 'components/dialog_box.dart';
import 'components/side_menu.dart';
import 'components/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('myBox');
  ToDoDataBaseF db = ToDoDataBaseF();

  @override
  void initState() {
    //if this is the first time ever opening the app
    if (_myBox.get("TODOLISTSUB")==null) {
      db.createInitialData();
    }
    else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

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

  void deleteTask (int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
      Colors.white,
      appBar: AppBar(
        title: const Text('Assign SubTasks'),
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
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
