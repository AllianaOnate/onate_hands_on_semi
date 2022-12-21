import 'package:flutter/material.dart';
import 'package:onate_hands_on/todo.dart';
import 'package:onate_hands_on/todo_controller.dart';
import 'package:onate_hands_on/todo_repository.dart';

class HomePage extends StatelessWidget {
  String input = "";

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
        centerTitle: true,
        backgroundColor: const Color(0xEEEE9BE4),
      ),
      backgroundColor: const Color(0xFFF5F0ED),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator()
              );
          }
          if (snapshot.hasError){
            return const Center(
              child: Text('error'),
            );
          }
          return buildBodyContent(snapshot, todoController);
        },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context, 
              builder: (BuildContext context){
                return AlertDialog(
                  title: const Text("Add more data"),
                  content: TextField(
                    onChanged: (String value){
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xccc24229)
                      ),
                      onPressed: () => Navigator.pop(context), 
                      child: const Text(
                        "Submit", 
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    )
                  ],
                );
              });
          },
          child: const Icon(
            Icons.add),
        ),
    );
  }

  SafeArea buildBodyContent(AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
          child: ListView.separated(
            itemBuilder: (context, index){
              var todo = snapshot.data?[index];
              return Card(
                elevation: 7,
                margin: const EdgeInsets.all(9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1, 
                      child: Text('${todo?.id}')
                    ),
                    Expanded(
                      flex: 3, 
                      child: Text('${todo?.title}'
                      )
                    ),
                    Expanded(
                      flex: 3, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: (){
                            todoController
                            .updatePatchCompleted(todo!)
                            .then((value){
                              ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  duration: 
                                    const Duration(milliseconds: 500),
                                  content: 
                                    Text('$value'),
                                ),
                              );
                            });
                          },
                          child: buildCallContainer(
                            'patch', 
                            const Color(0xEEE75480)
                          ),
                        ),
                        // PUT METHOD
                        // ONATE
                        InkWell(
                          onTap: (){
                            todoController.updatePutCompleted(todo!);
                          },
                          child: buildCallContainer(
                            'put', 
                            const Color(0xFFFFA45B)
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            todoController
                              .deleteTodo(todo!).then((value){
                              ScaffoldMessenger.of(context)
                              .showSnackBar(
                                SnackBar(
                                  duration: 
                                    const Duration(milliseconds: 500),
                                  content: 
                                    Text('$value'),
                                ),
                              );
                              });
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )
                        ),
                      ],
                    ),
                  ),
                  ],
                ),
              );
            }, 
            separatorBuilder: (context, index){
              return const Divider(
                thickness: 0.10,
                height: 0.6,
              );
            }, 
            itemCount: snapshot.data?.length ?? 0),
        );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
                        width: 40.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Center(
                          child: Text('$title')
                        ),
                      );
  }
}