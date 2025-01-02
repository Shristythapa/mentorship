// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionHiveModelAdapter extends TypeAdapter<SessionHiveModel> {
  @override
  final int typeId = 0;

  @override
  SessionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SessionHiveModel(
      sessionId: fields[0] as String?,
      mentorId: fields[1] as String,
      mentorEmail: fields[2] as String,
      mentorName: fields[3] as String,
      title: fields[4] as String,
      description: fields[5] as String,
      date: fields[6] as DateTime,
      startTime: fields[7] as String,
      endTime: fields[8] as String,
      isOngoing: fields[9] as bool,
      noOfAttendesSigned: fields[11] as int?,
      attendesSigned: (fields[10] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, String>())
          ?.toList(),
      maxNumberOfAttendesTaking: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SessionHiveModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.sessionId)
      ..writeByte(1)
      ..write(obj.mentorId)
      ..writeByte(2)
      ..write(obj.mentorEmail)
      ..writeByte(3)
      ..write(obj.mentorName)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.date)
      ..writeByte(7)
      ..write(obj.startTime)
      ..writeByte(8)
      ..write(obj.endTime)
      ..writeByte(9)
      ..write(obj.isOngoing)
      ..writeByte(10)
      ..write(obj.attendesSigned)
      ..writeByte(11)
      ..write(obj.noOfAttendesSigned)
      ..writeByte(12)
      ..write(obj.maxNumberOfAttendesTaking);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
