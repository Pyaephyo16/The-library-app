// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'industry_identifier_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndustryIdentifierVOAdapter extends TypeAdapter<IndustryIdentifierVO> {
  @override
  final int typeId = 12;

  @override
  IndustryIdentifierVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndustryIdentifierVO(
      type: fields[0] as String?,
      identifier: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IndustryIdentifierVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.identifier);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndustryIdentifierVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndustryIdentifierVO _$IndustryIdentifierVOFromJson(
        Map<String, dynamic> json) =>
    IndustryIdentifierVO(
      type: json['type'] as String?,
      identifier: json['identifier'] as String?,
    );

Map<String, dynamic> _$IndustryIdentifierVOToJson(
        IndustryIdentifierVO instance) =>
    <String, dynamic>{
      'type': instance.type,
      'identifier': instance.identifier,
    };
