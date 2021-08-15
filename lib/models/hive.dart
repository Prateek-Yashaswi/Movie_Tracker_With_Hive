import 'package:hive/hive.dart';
//generated model class adapter
part 'hive.g.dart';

@HiveType(typeId: 0)
class hiveModel extends HiveObject{
  @HiveField(0)
  late String movieName;

  @HiveField(1)
  late String poster;

  @HiveField(2)
  late String production;

  @HiveField(3)
  late bool watched;
}