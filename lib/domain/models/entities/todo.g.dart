// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoAdapter extends TypeAdapter<Todo> {
  @override
  final int typeId = 0;

  @override
  Todo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Todo(
      id: fields[0] as String,
      title: fields[1] as String,
      dueDate: fields[2] as DateTime,
      progress: fields[4] as int,
      priority: fields[3] as PriorityCategory?,
    );
  }

  @override
  void write(BinaryWriter writer, Todo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.priority)
      ..writeByte(4)
      ..write(obj.progress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
      progress: (json['progress'] as num).toInt(),
      priority:
          $enumDecodeNullable(_$PriorityCategoryEnumMap, json['priority']),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'due_date': instance.dueDate.toIso8601String(),
      'priority': _$PriorityCategoryEnumMap[instance.priority],
      'progress': instance.progress,
    };

const _$PriorityCategoryEnumMap = {
  PriorityCategory.HIGH: 'HIGH',
  PriorityCategory.NORMAL: 'NORMAL',
  PriorityCategory.LOW: 'LOW',
};
