import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zapp_task/module/todo/model/add_todo_model.dart';

import '../model/todo.dart';
import '../reposotory/todo_repository.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState()) {
    fetchTodos();
  }

  final todoRepo = TodoRepository();

  fetchTodos() async {
    try {
      emit(state.copyWith(loading: true));
      List<Todo> todosList = await todoRepo.fetchTodos();
      emit(state.copyWith(todos: todosList,loading: false));
    } catch (e) {
      debugPrint("$e");
    }
  }

  addTodo(AddTodoModel addTodoModel, BuildContext context) async {
    try {
      Todo todo = await todoRepo.addTodo(addTodoModel);
      final currentTodos = [...state.todos];
      currentTodos.add(todo);
      emit(state.copyWith(todos: currentTodos));
      Navigator.pop(context);
    } catch (e) {
      // throw e;
      debugPrint("$e");
    }
  }

  deleteTodo(String id) async {
    try {
      await todoRepo.deleteTodo(id).whenComplete(() {
        final currentTodos = [...state.todos];
        currentTodos.removeWhere((element) => element.id == id);
        emit(state.copyWith(todos: currentTodos));
      });
    } catch (e) {
      debugPrint("$e");
    }
  }

  updateTodo(String id, bool complete) async {
    try {
      final currentTodos = [...state.todos];
      int index = currentTodos.indexWhere((element) => element.id == id);
      currentTodos[index] = currentTodos[index].copyWith(
        completed: complete,
      );
      emit(state.copyWith(todos: currentTodos));
      await todoRepo.updateComplete(id,complete);

    } catch (e) {
      debugPrint("$e");
    }
  }
}

class TodoState {
  final List<Todo> todos;
  final bool loading;

  TodoState({this.todos = const [], this.loading = false});

  TodoState copyWith({
    final List<Todo>? todos,
    final bool? loading,
  }) {
    return TodoState(
      loading: loading ?? this.loading,
      todos: todos ?? this.todos,
    );
  }
}
