// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panelization_summary_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PanelizationSummaryVOAdapter extends TypeAdapter<PanelizationSummaryVO> {
  @override
  final int typeId = 13;

  @override
  PanelizationSummaryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PanelizationSummaryVO(
      containsEpubBubbles: fields[0] as bool?,
      containsImageBubbles: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, PanelizationSummaryVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.containsEpubBubbles)
      ..writeByte(1)
      ..write(obj.containsImageBubbles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanelizationSummaryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanelizationSummaryVO _$PanelizationSummaryVOFromJson(
        Map<String, dynamic> json) =>
    PanelizationSummaryVO(
      containsEpubBubbles: json['containsEpubBubbles'] as bool?,
      containsImageBubbles: json['containsImageBubbles'] as bool?,
    );

Map<String, dynamic> _$PanelizationSummaryVOToJson(
        PanelizationSummaryVO instance) =>
    <String, dynamic>{
      'containsEpubBubbles': instance.containsEpubBubbles,
      'containsImageBubbles': instance.containsImageBubbles,
    };
