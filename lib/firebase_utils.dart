import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseUtils {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (snapshot, _) =>
                TaskModel.fromJson(snapshot.data()!),
            toFirestore: (taskModel, _) => taskModel.toJson(),
          );

  static Future<void> addTaskToFirestore(TaskModel task) {
    final tasksCollection = getTasksCollection();
    final doc = tasksCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFirestore() async {
    final tasksCollection = getTasksCollection();
    final querySnapshot = await tasksCollection.get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static void deleteTaskFromFirestore(String taskId) {}
}
