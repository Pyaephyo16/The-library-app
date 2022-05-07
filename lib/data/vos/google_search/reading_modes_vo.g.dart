// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reading_modes_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReadingModesAdapter extends TypeAdapter<ReadingModesVO> {
  @override
  final int typeId = 15;

  @override
  ReadingModesVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReadingModesVO(
      text: fields[0] as bool?,
      image: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ReadingModesVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReadingModesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadingModesVO _$ReadingModesVOFromJson(Map<String, dynamic> json) =>
    ReadingModesVO(
      text: json['text'] as bool?,
      image: json['image'] as bool?,
    );

Map<String, dynamic> _$ReadingModesVOToJson(ReadingModesVO instance) =>
    <String, dynamic>{
      'text': instance.text,
      'image': instance.image,
    };
