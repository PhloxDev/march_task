// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_sprint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSprintAdapter extends TypeAdapter<UserSprint> {
  @override
  final int typeId = 3;

  @override
  UserSprint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSprint(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserSprint obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.sprintId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSprintAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
