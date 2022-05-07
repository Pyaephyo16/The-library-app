// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volume_info_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VolumeInfoVOAdapter extends TypeAdapter<VolumeInfoVO> {
  @override
  final int typeId = 19;

  @override
  VolumeInfoVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VolumeInfoVO(
      title: fields[0] as String?,
      authors: (fields[1] as List?)?.cast<String>(),
      publisher: fields[2] as String?,
      publishedDate: fields[3] as String?,
      description: fields[4] as String?,
      industryIdentifiers: (fields[5] as List?)?.cast<IndustryIdentifierVO>(),
      readingModes: fields[6] as ReadingModesVO?,
      pageCount: fields[7] as int?,
      printType: fields[8] as String?,
      categories: (fields[9] as List?)?.cast<String>(),
      maturityRating: fields[10] as String?,
      allowAnonLogging: fields[11] as bool?,
      contentVersion: fields[12] as String?,
      panelizationSummary: fields[13] as PanelizationSummaryVO?,
      imageLinks: fields[14] as ImageLinksVO?,
      language: fields[15] as String?,
      previewLink: fields[16] as String?,
      infoLink: fields[17] as String?,
      canonicalVolumeLink: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, VolumeInfoVO obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.authors)
      ..writeByte(2)
      ..write(obj.publisher)
      ..writeByte(3)
      ..write(obj.publishedDate)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.industryIdentifiers)
      ..writeByte(6)
      ..write(obj.readingModes)
      ..writeByte(7)
      ..write(obj.pageCount)
      ..writeByte(8)
      ..write(obj.printType)
      ..writeByte(9)
      ..write(obj.categories)
      ..writeByte(10)
      ..write(obj.maturityRating)
      ..writeByte(11)
      ..write(obj.allowAnonLogging)
      ..writeByte(12)
      ..write(obj.contentVersion)
      ..writeByte(13)
      ..write(obj.panelizationSummary)
      ..writeByte(14)
      ..write(obj.imageLinks)
      ..writeByte(15)
      ..write(obj.language)
      ..writeByte(16)
      ..write(obj.previewLink)
      ..writeByte(17)
      ..write(obj.infoLink)
      ..writeByte(18)
      ..write(obj.canonicalVolumeLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VolumeInfoVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolumeInfoVO _$VolumeInfoVOFromJson(Map<String, dynamic> json) => VolumeInfoVO(
      title: json['title'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      publisher: json['publisher'] as String?,
      publishedDate: json['publishedDate'] as String?,
      description: json['description'] as String?,
      industryIdentifiers: (json['industryIdentifiers'] as List<dynamic>?)
          ?.map((e) => IndustryIdentifierVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      readingModes: json['readingModes'] == null
          ? null
          : ReadingModesVO.fromJson(
              json['readingModes'] as Map<String, dynamic>),
      pageCount: json['pageCount'] as int?,
      printType: json['printType'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      maturityRating: json['maturityRating'] as String?,
      allowAnonLogging: json['allowAnonLogging'] as bool?,
      contentVersion: json['contentVersion'] as String?,
      panelizationSummary: json['panelizationSummary'] == null
          ? null
          : PanelizationSummaryVO.fromJson(
              json['panelizationSummary'] as Map<String, dynamic>),
      imageLinks: json['imageLinks'] == null
          ? null
          : ImageLinksVO.fromJson(json['imageLinks'] as Map<String, dynamic>),
      language: json['language'] as String?,
      previewLink: json['previewLink'] as String?,
      infoLink: json['infoLink'] as String?,
      canonicalVolumeLink: json['canonicalVolumeLink'] as String?,
    );

Map<String, dynamic> _$VolumeInfoVOToJson(VolumeInfoVO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'publisher': instance.publisher,
      'publishedDate': instance.publishedDate,
      'description': instance.description,
      'industryIdentifiers': instance.industryIdentifiers,
      'readingModes': instance.readingModes,
      'pageCount': instance.pageCount,
      'printType': instance.printType,
      'categories': instance.categories,
      'maturityRating': instance.maturityRating,
      'allowAnonLogging': instance.allowAnonLogging,
      'contentVersion': instance.contentVersion,
      'panelizationSummary': instance.panelizationSummary,
      'imageLinks': instance.imageLinks,
      'language': instance.language,
      'previewLink': instance.previewLink,
      'infoLink': instance.infoLink,
      'canonicalVolumeLink': instance.canonicalVolumeLink,
    };
