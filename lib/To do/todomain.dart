import 'package:dementia_app/To%20do/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

const String todoBoxName = "todo";

Start() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox<TodoModel>(todoBoxName);
  runApp(todoApp());
}

class todoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum TodoFilter { ALL, COMPLETED, INCOMPLETED }

class _MyHomePageState extends State<MyHomePage> {
  late Box<TodoModel> todoBox;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  TodoFilter filter = TodoFilter.ALL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBox = Hive.box(todoBoxName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Save your Tasks here..."),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value.compareTo("All") == 0) {
                setState(() {
                  filter = TodoFilter.ALL;
                });
              } else if (value.compareTo("Completed") == 0) {
                setState(() {
                  filter = TodoFilter.COMPLETED;
                });
              } else {
                setState(() {
                  filter = TodoFilter.INCOMPLETED;
                });
              }
            },
            itemBuilder: (BuildContext context) {
              return ["All", "Completed", "Incompleted"].map((option) {
                return PopupMenuItem(value: option, child: Text(option));
              }).toList();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          ValueListenableBuilder(
              valueListenable: todoBox.listenable(),
              builder: (context, Box<TodoModel> todos, _) {
                List<int> keys;

                if (filter == TodoFilter.ALL) {
                  keys = todos.keys.cast<int>().toList();
                } else if (filter == TodoFilter.COMPLETED) {
                  keys = todos.keys
                      .cast<int>()
                      .where((key) => todos.get(key)!.isCompleted)
                      .toList();
                } else {
                  keys = todos.keys
                      .cast<int>()
                      .where((key) => !todos.get(key)!.isCompleted)
                      .toList();
                }

                return ListView.separated(
                  itemBuilder: (_, index) {
                    final int key = keys[index];
                    final TodoModel? todo = todos.get(key);

                    return ListTile(
                      title: Text(
                        todo!.title,
                        style: TextStyle(fontSize: 24),
                      ),
                      subtitle: Text(
                        todo.detail,
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: Text("$key"),
                      trailing: Icon(
                        Icons.check,
                        color: todo.isCompleted ? Colors.green : Colors.red,
                      ),
                      onTap: () {
                        showDialog(
                          builder: (context) => Dialog(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        TodoModel mTodo = TodoModel(
                                            title: todo.title,
                                            detail: todo.detail,
                                            isCompleted: true);
                                        todoBox.put(key, mTodo);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Mark as Completed"))
                                ],
                              ),
                            ),
                          ),
                          context: context,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: keys.length,
                  shrinkWrap: true,
                );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            builder: (context) => Dialog(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "Title"),
                      controller: titleController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(hintText: "Detail"),
                      controller: detailController,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextButton(
                        onPressed: () {
                          final String title = titleController.text;
                          final String detail = detailController.text;

                          TodoModel todo = TodoModel(
                              title: title, detail: detail, isCompleted: false);
                          todoBox.add(todo);
                          Navigator.pop(context);
                        },
                        child: Text("Add Todo"))
                  ],
                ),
              ),
            ),
            context: context,
          );
        },
      ),
    );
  }
}
