import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/default_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Add New Task',
              style: textTheme.bodyMedium?.copyWith(color: AppTheme.blackColor),
            ),
            DefaultTextFormField(
              controller: titleController,
              hintText: 'Enter task title',
            ),
            const SizedBox(height: 16),
            DefaultTextFormField(
              controller: descriptionController,
              hintText: 'Enter task description',
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'Selected Date',
                style: textTheme.bodyLarge,
              ),
            ),
            InkWell(
              onTap: () async {
                final dateTime = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: DateTime.now(),
                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                );
                if (dateTime != null) selectedDate = dateTime;
              },
              child: Text(
                dateFormat.format(DateTime.now()),
                style: textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 20),
            DefaultElevatedButton(
              label: 'Add',
              onPressed: addTask,
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {}
}
