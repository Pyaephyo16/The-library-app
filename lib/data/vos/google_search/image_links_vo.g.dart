// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_links_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageLinksVOAdapter extends TypeAdapter<ImageLinksVO> {
  @override
  final int typeId = 11;

  @override
  ImageLinksVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageLinksVO(
      smallThumbnail: fields[0] as String?,
      thumbnail: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageLinksVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.smallThumbnail)
      ..writeByte(1)
      ..write(obj.thumbnail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageLinksVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageLinksVO _$ImageLinksVOFromJson(Map<String, dynamic> json) => ImageLinksVO(
      smallThumbnail: json['smallThumbnail'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$ImageLinksVOToJson(ImageLinksVO instance) =>
    <String, dynamic>{
      'smallThumbnail': instance.smallThumbnail,
      'thumbnail': instance.thumbnail,
    };
