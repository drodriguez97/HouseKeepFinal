import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

@HiveType(typeId: 0)

class Task extends HiveObject {
  Task({required this.id, required this.name, required this.createdAt, required this.isCompleted});

  
  factory Task.create({required String name, required String roomNum, DateTime? createdAt }) =>
  Task(id: Uuid().v1(),
           name: name, 
           createdAt: createdAt ?? DateTime.now(),
           isCompleted: false);

  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool isCompleted;

}
