import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Todo {
  String name;
  bool isComplete;
  
  Todo({
    required this.name,
    this.isComplete = false
  });
}

class TodoItem extends StatefulWidget 
{
  final Todo todo;

  TodoItem({required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
   @override
   Widget build(BuildContext context)
   {
    return ListTile(
      title: Text(widget.todo.name),
      leading: Checkbox(
        value: widget.todo.isComplete,
        onChanged: (value)
        {
          widget.todo.isComplete = value!;
        },
        ),
    );
  }
  
}

//prueba

class TodoItemImg extends StatefulWidget 
{
  final Todo todo;

  TodoItemImg({required this.todo});

  @override
  _TodoItemImgState createState() => _TodoItemImgState();
}

class _TodoItemImgState extends State<TodoItem> {
   @override
  Widget build(BuildContext context) {
    var title = 'Web Images';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Image.network('https://picsum.photos/250?image=9'),
      ),
    );
  }
  
}




//prueba fin

class TodoList extends StatelessWidget {
  final List<Todo> todos;
    
  TodoList({required this.todos});

  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoItem(todo: todos[index]);
        
      },
    );
  }
}

class AddTodo extends StatefulWidget{
  final Function(String) onAdd;

  AddTodo({required this.onAdd});

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Expanded(child: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Escriba la tarea a realizar.'),
        ),
        ),
        ElevatedButton(
          onPressed: (){
            widget.onAdd(_controller.text);
            _controller.clear();
          },
          child: Text('Nueva tarea.'), 
          )
      ],
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  List<Todo> todos = [
    Todo(name: 'Toyota'),
    Todo(name: 'Lexus'),
    Todo(name: 'Honda'),
    Todo(name: 'Acura')
  ];

   @override
  Widget build(BuildContext context){
    return MaterialApp
    (
      home: Scaffold
      (
        appBar: AppBar(title: Text('To-do List') ),
        body: Column(
          children: [
            Expanded(child: TodoList(todos: todos,),
            ),
            AddTodo(
              onAdd: (name){
                setState(() {
                  todos.add(Todo(name: name));
                });
              })
          ]),
      ),
    );
  }
}