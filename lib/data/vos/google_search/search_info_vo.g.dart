// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_info_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchInfoVOAdapter extends TypeAdapter<SearchInfoVO> {
  @override
  final int typeId = 17;

  @override
  SearchInfoVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchInfoVO(
      textSnippet: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SearchInfoVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.textSnippet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchInfoVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchInfoVO _$SearchInfoVOFromJson(Map<String, dynamic> json) => SearchInfoVO(
      textSnippet: json['textSnippet'] as String?,
    );

Map<String, dynamic> _$SearchInfoVOToJson(SearchInfoVO instance) =>
    <String, dynamic>{
      'textSnippet': instance.textSnippet,
    };
