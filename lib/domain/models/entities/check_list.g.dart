// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckListAdapter extends TypeAdapter<CheckList> {
  @override
  final int typeId = 1;

  @override
  CheckList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckList(
      title: fields[0] as String,
      isCompleted: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CheckList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
