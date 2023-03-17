import 'package:hive/hive.dart';
part 'historyitem.g.dart';

@HiveType(typeId: 0)
class HistoryItem extends HiveObject {
  @HiveField(0)
  late String expression;

  @HiveField(1)
  late String result;

  HistoryItem({required this.expression, required this.result});

  Map<String, dynamic> toMap() {
    return {'expression': expression, 'result': result};
  }

  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      expression: map['expression'] as String,
      result: map['result'] as String,
    );
  }
}






