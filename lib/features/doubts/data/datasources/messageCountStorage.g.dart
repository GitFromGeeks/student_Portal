// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messageCountStorage.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageCountStorageAdapter extends TypeAdapter<MessageCountStorage> {
  @override
  final int typeId = 1;

  @override
  MessageCountStorage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MessageCountStorage(
      lastCheck: fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MessageCountStorage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lastCheck);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageCountStorageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
