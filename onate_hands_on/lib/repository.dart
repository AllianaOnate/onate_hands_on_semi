import 'package:onate_hands_on/todo.dart';

abstract class Repository{
  
  Future<List<Todo>> getTodoList();

  Future<String> patchCompleted(Todo todo);

  Future<String> putCompleted(Todo todo);

  Future<String> deletedCompleted(Todo todo);

  Future<String> postCompleted(Todo todo);

}
