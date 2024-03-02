import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseUtils.deleteTaskFromFirestore(task.id)
                    .timeout(const Duration(milliseconds: 500), onTimeout: () {
                  Provider.of<TasksProvider>(context, listen: false).getTasks();
                }).catchError(
                  (_) => Fluttertoast.showToast(
                    msg: "Something went wrong!",
                    toastLength: Toast.LENGTH_SHORT,
                  ),
                );
              },
              backgroundColor: AppTheme.redColor,
              foregroundColor: AppTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppTheme.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 62,
                color: Theme.of(context).primaryColor,
                margin: const EdgeInsetsDirectional.only(end: 8),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    task.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 34,
                width: 69,
                child: Image.asset('assets/images/check_icon.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
