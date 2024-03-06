import 'package:hive/hive.dart';
import 'package:todo_app/models/task_model.dart';

abstract class LocalStorage {
  //görev eklemek için
  Future<void> addTask({required Task task});
  //geriye task döndürme durumu için
  Future<Task?> getTask({required String id});
  Future<List<Task>> getAllTask();
  Future<bool> deleteTask(
      {required Task
          task}); //sildiyse true değer göndermesi için bool değer geriye döndürür
  Future<Task> updateTask({required Task task});
}

class HiveLocalStorage extends LocalStorage {
  late Box<Task> _taskBox;

  HiveLocalStorage() {
    _taskBox = Hive.box("tasks");
  }

  @override
  Future<void> addTask({required Task task}) async {
    await _taskBox.put(task.id, task);
  }

  @override
  Future<bool> deleteTask({required Task task}) async {
    await task
        .delete(); //hive objelerinden türediği için kısayol olarak kullanılabilir
    // _taskBox.delete(task.id);
    return true;
  }

  @override
  Future<List<Task>> getAllTask() async {
    List<Task> _allTask = <Task>[];
    //veritabanında tüm verileri okuma
    _allTask = _taskBox.values.toList();
    if (_allTask.isNotEmpty) {
      //sort metodu iki metodu birbiri ile kıyaslar
      _allTask.sort((Task a, Task b) => b.createAt.compareTo(a
          .createAt)); //tarihine göre bir önceki ile bir sonrakini kıyaslayacak.en son ekleneni listenin en başına koyacak
    }
    return _allTask;
  }

  @override
  Future<Task?> getTask({required String id}) async {
    if (_taskBox.containsKey(id)) {
      //eğer box bu id yi içeriyorsa
      return _taskBox.get(id);
    } else {
      return null;
    }
  }

  @override
  Future<Task> updateTask({required Task task}) async {
    await task.save(); //ilgili değişikliği kaydet
    return task;
  }
}
