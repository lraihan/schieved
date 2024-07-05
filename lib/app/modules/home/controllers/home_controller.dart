import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schieved/app/data/models/tag_model.dart';
import 'package:schieved/app/data/models/task_model.dart';
import 'package:schieved/app/data/service/auth_service.dart';
import 'package:schieved/app/data/service/stream_service.dart';
import 'package:schieved/app/data/service/tag_service.dart';
import 'package:schieved/app/data/service/task_service.dart';
import 'package:schieved/app/data/shared/shared_variables.dart';
import 'package:weekly_date_picker/datetime_apis.dart';

class HomeController extends GetxController {
  StreamService streamService = StreamService();
  AuthService authService = AuthService();
  TaskService taskService = TaskService();
  TagService tagService = TagService();

  final PageController weekController = PageController(initialPage: 520);

  final RxList<Task> taskList = RxList<Task>([]);
  final RxList<Task> todayTask = RxList<Task>([]);
  final RxList<Task> highPrioTask = RxList<Task>([]);
  final RxList<Task> overdueTask = RxList<Task>([]);
  final RxList<Task> completedTask = RxList<Task>([]);

  final RxList<Tag> tagList = RxList<Tag>([]);

  final RxInt totalTask = 0.obs;
  final RxInt totalOverdueTask = 0.obs;

  @override
  void onInit() async {
    await tagService.fetchTags(tagList);
    WidgetsFlutterBinding.ensureInitialized();
    countTask();
    super.onInit();
  }

  Future<bool> signInWithGoogle() async {
    return await authService.signInWithGoogle();
  }

  Future<bool> signOut() async {
    return await authService.signOut();
  }

  void countTask() {
    totalTask.value = (taskList.where((x) => x.date.isSameDateAs(todayDate.value))).toList().length;
    totalOverdueTask.value = (taskList.where((x) =>
        x.status == 'open' &&
        DateTime(x.date.year, x.date.month, x.date.day)
            .isBefore(DateTime(todayDate.value.year, todayDate.value.month, todayDate.value.day)))).toList().length;
  }

  Future<void> filterTask(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) async {
    try {
      if (snapshot.hasData) {
        taskList.value = snapshot.data!.docs.map((doc) {
          return Task.fromFirestore(doc);
        }).toList();

        //filter high priority
        highPrioTask.value = (taskList
            .where((x) => x.priority == 'high' && x.status == 'open' && x.date.isSameDateAs(todayDate.value))).toList();
        highPrioTask.sort((a, b) => (b.status).compareTo(a.status));

        //filter normal priority
        todayTask.value = (taskList.where(
            (x) => x.priority == 'normal' && x.status == 'open' && x.date.isSameDateAs(todayDate.value))).toList();
        todayTask.sort((a, b) => (b.status).compareTo(a.status));
        if (todayTask.length > 3) {
          todayTask.value = todayTask.sublist(0, 3);
        }

        //filter overdue task
        overdueTask.value = (taskList.where((x) =>
            x.status == 'open' &&
            DateTime(x.date.year, x.date.month, x.date.day)
                .isBefore(DateTime(todayDate.value.year, todayDate.value.month, todayDate.value.day)))).toList();
        if (overdueTask.length > 3) {
          overdueTask.value = overdueTask.sublist(0, 3);
        }

        //filter completed task
        completedTask.value =
            taskList.where((x) => x.date.isSameDateAs(todayDate.value) && x.status == 'done').toList();

        countTask();

        print('high prio : ${highPrioTask.length}');
        print('overdue : ${overdueTask.length}');
        print('today : ${todayTask.length}');
        print('all total : ${taskList.length}');
      }
    } catch (e) {
      debugPrint('error filterTask : ${e.toString()}');
    }
  }

  Future<bool> changeTaskStatus(Task task) async {
    return await taskService.taskChangeStatus(task.id, task.status);
  }
}
