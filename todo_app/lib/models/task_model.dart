// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

//veritabanınına taskı eklemek için belirli annotionlar gerekli

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createAt;

  @HiveField(3)
  bool isComplated;
  Task({
    required this.id,
    required this.name,
    required this.createAt,
    required this.isComplated,
  });

  factory Task.create({required String name, required DateTime createAt}) {
    return Task(
        id: const Uuid().v1(),
        name: name,
        createAt: createAt,
        isComplated: false);
  }
}
