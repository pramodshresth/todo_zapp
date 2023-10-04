import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zapp_task/module/todo/cubit/todo_cubit.dart';
import 'package:zapp_task/module/todo/model/todo.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key, required this.todo, this.onChnaged});

  final Todo todo;
  final Function(bool?)? onChnaged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      // height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  checkColor: Colors.white,
                  value: todo.completed,
                  onChanged:onChnaged
                ),
              ),
            ),
            // SvgPicture.asset('assets/icons/checkbox.svg'),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                todo.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {
                  context.read<TodoCubit>().deleteTodo(todo.id);
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                )),

            // CustomKlikPopUp(
            //   onSelected: (value) {
            //     if (value == "2") {
            //       tc.todoController.text = todo;
            //       tc.selectedTime.value = TimeOfDay(hour: addedDate.hour, minute: addedDate.minute);
            //       openBottomSheet(
            //           context,
            //           id: id,
            //           todoModel: todoModel
            //       );
            //     }
            //   },
            //   onDeleteTap: () {
            //     tc.deleteTodo(id);
            //   },
            // ),
            // InkWell(
            //   onTap: () {
            //     klikPopUpMenu(
            //       context,
            //       onDeleteTap: () {
            //         tc.deleteTodo(id);
            //       },
            //     );
            //   },
            //   child: Icon(
            //     Icons.more_vert,
            //     size: 15,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
