// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class hiveModelAdapter extends TypeAdapter<hiveModel> {
  @override
  final int typeId = 0;

  @override
  hiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return hiveModel()
      ..movieName = fields[0] as String
      ..poster = fields[1] as String
      ..production = fields[2] as String
      ..watched = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, hiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.movieName)
      ..writeByte(1)
      ..write(obj.poster)
      ..writeByte(2)
      ..write(obj.production)
      ..writeByte(3)
      ..write(obj.watched);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is hiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
