// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PdfVOAdapter extends TypeAdapter<PdfVO> {
  @override
  final int typeId = 14;

  @override
  PdfVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PdfVO(
      isAvailable: fields[0] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PdfVO obj) {
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
      other is PdfVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdfVO _$PdfVOFromJson(Map<String, dynamic> json) => PdfVO(
      isAvailable: json['isAvailable'] as bool?,
    );

Map<String, dynamic> _$PdfVOToJson(PdfVO instance) => <String, dynamic>{
      'isAvailable': instance.isAvailable,
    };
