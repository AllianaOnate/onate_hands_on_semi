
import 'package:onate_hands_on/repository.dart';
import 'package:onate_hands_on/todo.dart';

class TodoController{

  final Repository _repository;

  TodoController(this._repository);

  // GET TODO
  // ONATE
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  // EDIT TODO USING PUT 
  // ONATE
  Future<String> updatePutCompleted(Todo todo) async {
    return _repository.putCompleted(todo);
  }

  Future<String> deleteTodo(Todo todo) async {
    return _repository.deletedCompleted(todo);
  }

  Future<String> postTodo(Todo todo) async {
    return _repository.postCompleted(todo);
  }
}