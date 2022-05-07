// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_more_list_for_hive_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShowMoreListForHiveVOAdapter extends TypeAdapter<ShowMoreListForHiveVO> {
  @override
  final int typeId = 8;

  @override
  ShowMoreListForHiveVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShowMoreListForHiveVO(
      bookList: (fields[0] as List?)?.cast<BookVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, ShowMoreListForHiveVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.bookList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowMoreListForHiveVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowMoreListForHiveVO _$ShowMoreListForHiveVOFromJson(
        Map<String, dynamic> json) =>
    ShowMoreListForHiveVO(
      bookList: (json['bookList'] as List<dynamic>?)
          ?.map((e) => BookVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShowMoreListForHiveVOToJson(
        ShowMoreListForHiveVO instance) =>
    <String, dynamic>{
      'bookList': instance.bookList,
    };
