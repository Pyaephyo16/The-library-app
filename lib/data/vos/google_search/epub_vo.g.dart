// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'epub_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EpubVOAdapter extends TypeAdapter<EpubVO> {
  @override
  final int typeId = 10;

  @override
  EpubVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EpubVO(
      isAvailable: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, EpubVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isAvailable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EpubVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpubVO _$EpubVOFromJson(Map<String, dynamic> json) => EpubVO(
      isAvailable: json['isAvailable'] as bool?,
    );

Map<String, dynamic> _$EpubVOToJson(EpubVO instance) => <String, dynamic>{
      'isAvailable': instance.isAvailable,
    };
