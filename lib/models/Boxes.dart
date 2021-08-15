import 'package:hive/hive.dart';
import 'package:yellow_class/models/hive.dart';


class Boxes {
  static Box<hiveModel> getModel() =>
      Hive.box<hiveModel>('hiveModel');
}