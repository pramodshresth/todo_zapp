import 'package:zapp_task/module/todo/model/add_todo_model.dart';
import 'package:zapp_task/module/todo/model/todo.dart';
import 'package:zapp_task/utils/query.dart';

import '../../../services/dio_client.dart';

class TodoRepository {
  final baseUrl = 'https://graphqlzero.almansi.me/api';

  Future<List<Todo>> fetchTodos() async {
    final response = await dioClient.postData(url: baseUrl, data: fetchTodoQuery);
    return (response["todos"]['data'] as List).map((e) => Todo.fromJson(e)).toList();
  }

  Future<Todo> addTodo(AddTodoModel addTodoModel) async {
    final response = await dioClient.postData(url: baseUrl, data: createTodoQuery(addTodoModel));
    return Todo.fromJson(response['createTodo']);
  }

  Future<void> deleteTodo(String id) async {
    final response = await dioClient.postData(url: baseUrl, data: deleteQuery(id));
    // return Todo.fromJson(response['createTodo']);
  }

  Future<void> updateComplete(String id, bool complete) async {
     await dioClient.postData(url: baseUrl, data: completeQuery(id,complete));
    // return Todo.fromJson(response['createTodo']);
    // return Todo.fromJson(response['updateTodo']);
  }
}
