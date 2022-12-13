import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoList',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TodoList'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> todos = <String>[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController todoController = TextEditingController();
  String text = '';

  void addItemToList(){
    setState(() {
      todos.insert(0,todoController.text);
      todoController.clear();
    });
  }

  void removeItemAtIndex(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
          child: Column(
          children:[
            Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter todo',
                  ),
                  controller: todoController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addItemToList();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index){
                return InkWell(
                  onTap:(){
                    showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter new text'
                          ),
                          onChanged: (value){
                            setState(() {
                              text = value;
                            });
                          },
                        ),
                        ElevatedButton(onPressed: () {
                          setState(() {
                            todos[index] = text;
                          });
                          Navigator.pop(context);
                        },
                            child: Text('Apply'))
                      ],
                    ),
                    );
                  },
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.all(2),
                    color: Color(0xBDC9C9BB),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(15,0,0,0),
                              child: Text('${todos[index]}', style: TextStyle(fontWeight: FontWeight.bold),),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 30,
                          child: IconButton(
                            padding: EdgeInsets.fromLTRB(0,0,20,0),
                            constraints: BoxConstraints(),
                            onPressed: (){
                              setState(() {
                                 todos.removeAt(index);
                              });
                            }, icon: Icon(Icons.delete),
                          ),
                        )
                      ],
                    //child: Text('${todos[index]}',
                    //style: TextStyle(fontSize: 20),
                  )
                    )

                  );

              }
            ),
          ),
      ],
      ),
      ),
    );
  }
}


