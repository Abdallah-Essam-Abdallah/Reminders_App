import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 0)
class ReminderModel extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String description;
  @HiveField(2)
  late String date;
  @HiveField(3)
  late int id;

  ReminderModel(
      {required this.title,
      required this.description,
      required this.date,
      required this.id});
}
