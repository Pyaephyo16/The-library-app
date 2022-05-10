// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chip_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChipVOAdapter extends TypeAdapter<ChipVO> {
  @override
  final int typeId = 20;

  @override
  ChipVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChipVO(
      category: fields[0] as String?,
      isSelected: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ChipVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChipVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
