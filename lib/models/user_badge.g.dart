// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_badge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBadgeAdapter extends TypeAdapter<UserBadge> {
  @override
  final int typeId = 2;

  @override
  UserBadge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBadge(
      fields[0] as String?,
      fields[1] as String?,
      fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserBadge obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.whoId)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.earnedBadgeId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBadgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
