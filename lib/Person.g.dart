// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 0;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      fName: fields[0] as String?,
      lName: fields[1] as String?,
      address: fields[2] as String?,
      gender: fields[3] as String?,
      techStack: (fields[4] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.fName)
      ..writeByte(1)
      ..write(obj.lName)
      ..writeByte(2)
      ..write(obj.address)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.techStack);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
