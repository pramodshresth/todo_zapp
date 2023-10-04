import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zapp_task/module/todo/page/add_todo_page.dart';

import '../cubit/todo_cubit.dart';
import '../widget/todo_card.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zapp Todo"),
      ),
      body: Column(
        children: [
          BlocBuilder<TodoCubit, TodoState>(
            builder: (context, todoState) {
              final todos = todoState.todos;
              if(todoState.loading){
                return const Expanded(child: Center(child: CircularProgressIndicator(),));
              }
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final todo = todoState.todos[index];
                      return TodoCard(
                        todo: todo,
                        onChnaged: (value) {
                          context.read<TodoCubit>().updateTodo(todo.id, value!);
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: todos.length,
                  ),
                ),
              );
            },
          ),
          Center(
            child: ElevatedButton(
              child: const Text('Add Todo'),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTodoPage(),
                    ));
                // context.read<TodoCubit>().addTodo(AddTodoModel(title: "Manila", completed: false));
              },
            ),
          ),
        ],
      ),
    );
  }
}
