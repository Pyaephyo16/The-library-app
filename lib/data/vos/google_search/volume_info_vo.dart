import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/google_search/image_links_vo.dart';
import 'package:the_library_app/data/vos/google_search/industry_identifier_vo.dart';
import 'package:the_library_app/data/vos/google_search/panelization_summary_vo.dart';
import 'package:the_library_app/data/vos/google_search/reading_modes_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'volume_info_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_VOLUME_INFO_VO,adapterName: "VolumeInfoVOAdapter")
class VolumeInfoVO{

  @JsonKey(name: "title")
  @HiveField(0)
  String? title;

  @JsonKey(name: "authors")
  @HiveField(1)
  List<String>? authors;
  
  @JsonKey(name: "publisher")
  @HiveField(2)
  String? publisher;

  @JsonKey(name: "publishedDate")
  @HiveField(3)
  String? publishedDate;

  @JsonKey(name: "description")
  @HiveField(4)
  String? description;

  @JsonKey(name: "industryIdentifiers")
  @HiveField(5)
  List<IndustryIdentifierVO>? industryIdentifiers;

  @JsonKey(name: "readingModes")
  @HiveField(6)
  ReadingModesVO? readingModes;

  @JsonKey(name: "pageCount")
  @HiveField(7)
  int? pageCount;

  @JsonKey(name: "printType")
  @HiveField(8)
  String? printType;

  @JsonKey(name: "categories")
  @HiveField(9)
  List<String>? categories;

  @JsonKey(name: "maturityRating")
  @HiveField(10)
  String? maturityRating;

  @JsonKey(name: "allowAnonLogging")
  @HiveField(11)
  bool? allowAnonLogging;

  @JsonKey(name: "contentVersion")
  @HiveField(12)
  String? contentVersion;

  @JsonKey(name: "panelizationSummary")
  @HiveField(13)
  PanelizationSummaryVO? panelizationSummary;

  @JsonKey(name: "imageLinks")
  @HiveField(14)
  ImageLinksVO? imageLinks;

  @JsonKey(name: "language")
  @HiveField(15)
  String? language;

  @JsonKey(name: "previewLink")
  @HiveField(16)
  String? previewLink;

  @JsonKey(name: "infoLink")
  @HiveField(17)
  String? infoLink;

  @JsonKey(name: "canonicalVolumeLink")
  @HiveField(18)
  String? canonicalVolumeLink;
  
  VolumeInfoVO({
    this.title,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.readingModes,
    this.pageCount,
    this.printType,
    this.categories,
    this.maturityRating,
    this.allowAnonLogging,
    this.contentVersion,
    this.panelizationSummary,
    this.imageLinks,
    this.language,
    this.previewLink,
    this.infoLink,
    this.canonicalVolumeLink,
  });

    factory VolumeInfoVO.fromJson(Map<String,dynamic> json) => _$VolumeInfoVOFromJson(json);

  Map<String,dynamic> toJson() => _$VolumeInfoVOToJson(this);


  @override
  String toString() {
    return 'VolumeInfoVO(title: $title, authors: $authors, publisher: $publisher, publishedDate: $publishedDate, description: $description, industryIdentifiers: $industryIdentifiers, readingModes: $readingModes, pageCount: $pageCount, printType: $printType, categories: $categories, maturityRating: $maturityRating, allowAnonLogging: $allowAnonLogging, contentVersion: $contentVersion, panelizationSummary: $panelizationSummary, imageLinks: $imageLinks, language: $language, previewLink: $previewLink, infoLink: $infoLink, canonicalVolumeLink: $canonicalVolumeLink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is VolumeInfoVO &&
      other.title == title &&
      listEquals(other.authors, authors) &&
      other.publisher == publisher &&
      other.publishedDate == publishedDate &&
      other.description == description &&
      listEquals(other.industryIdentifiers, industryIdentifiers) &&
      other.readingModes == readingModes &&
      other.pageCount == pageCount &&
      other.printType == printType &&
      listEquals(other.categories, categories) &&
      other.maturityRating == maturityRating &&
      other.allowAnonLogging == allowAnonLogging &&
      other.contentVersion == contentVersion &&
      other.panelizationSummary == panelizationSummary &&
      other.imageLinks == imageLinks &&
      other.language == language &&
      other.previewLink == previewLink &&
      other.infoLink == infoLink &&
      other.canonicalVolumeLink == canonicalVolumeLink;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      authors.hashCode ^
      publisher.hashCode ^
      publishedDate.hashCode ^
      description.hashCode ^
      industryIdentifiers.hashCode ^
      readingModes.hashCode ^
      pageCount.hashCode ^
      printType.hashCode ^
      categories.hashCode ^
      maturityRating.hashCode ^
      allowAnonLogging.hashCode ^
      contentVersion.hashCode ^
      panelizationSummary.hashCode ^
      imageLinks.hashCode ^
      language.hashCode ^
      previewLink.hashCode ^
      infoLink.hashCode ^
      canonicalVolumeLink.hashCode;
  }
}
