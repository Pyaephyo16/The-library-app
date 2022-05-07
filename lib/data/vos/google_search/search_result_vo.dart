import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/google_search/access_info_vo.dart';
import 'package:the_library_app/data/vos/google_search/sale_info_vo.dart';
import 'package:the_library_app/data/vos/google_search/search_info_vo.dart';
import 'package:the_library_app/data/vos/google_search/volume_info_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'search_result_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SEARCH_RESULT_VO,adapterName: "SearchResultVOAdapter")
class SearchResultVO {

  @JsonKey(name: "kind")
  @HiveField(0)
  String? kind;

  @JsonKey(name: "id")
  @HiveField(1)
  String? id;

  @JsonKey(name: "etag")
  @HiveField(2)
  String? etag;

  @JsonKey(name: "selfLink")
  @HiveField(3)
  String? selfLink;

  @JsonKey(name: "volumeInfo")
  @HiveField(4)
  VolumeInfoVO? volumeInfo;

  @JsonKey(name: "saleInfo")
  @HiveField(5)
  SaleInfoVO? saleInfo;

  @JsonKey(name: "accessInfo")
  @HiveField(6)
  AccessInfoVO? accessInfo;

  @JsonKey(name: "searchInfo")
  @HiveField(7)
  SearchInfoVO? searchInfo;

  SearchResultVO({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  });

      factory SearchResultVO.fromJson(Map<String,dynamic> json) => _$SearchResultVOFromJson(json);

  Map<String,dynamic> toJson() => _$SearchResultVOToJson(this);


  @override
  String toString() {
    return 'SearchResultVO(kind: $kind, id: $id, etag: $etag, selfLink: $selfLink, volumeInfo: $volumeInfo, saleInfo: $saleInfo, accessInfo: $accessInfo, searchInfo: $searchInfo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SearchResultVO &&
      other.kind == kind &&
      other.id == id &&
      other.etag == etag &&
      other.selfLink == selfLink &&
      other.volumeInfo == volumeInfo &&
      other.saleInfo == saleInfo &&
      other.accessInfo == accessInfo &&
      other.searchInfo == searchInfo;
  }

  @override
  int get hashCode {
    return kind.hashCode ^
      id.hashCode ^
      etag.hashCode ^
      selfLink.hashCode ^
      volumeInfo.hashCode ^
      saleInfo.hashCode ^
      accessInfo.hashCode ^
      searchInfo.hashCode;
  }
}
