import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController taskController = TextEditingController();

  void addTask(String task) {
    if (task.isNotEmpty) {
      setState(() {
        tasks.add({"title": task, "completed": false});
      });
      taskController.clear();
    }
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6CFFF),
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF7D69A3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.pets, size: 40, color: Colors.white), 
                  SizedBox(width: 10),
                  Text(
                    'To-Do List',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              TextField(
                controller: taskController,
                decoration: InputDecoration(
                  hintText: "Add a task...",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onSubmitted: addTask,
              ),
              SizedBox(height: 10),

              if (tasks.isNotEmpty)
                Container(
                  height: 250,
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Checkbox(
                              value: tasks[index]['completed'],
                              onChanged: (value) => toggleTask(index),
                            ),
                            Expanded(
                              child: Text(
                                tasks[index]['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: tasks[index]['completed']
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () => deleteTask(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              if (tasks.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("No tasks yet!", style: TextStyle(color: Colors.white)),
                ),

              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.star, color: Colors.orangeAccent, size: 24),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
