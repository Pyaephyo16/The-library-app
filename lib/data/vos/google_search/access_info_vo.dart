import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/google_search/epub_vo.dart';
import 'package:the_library_app/data/vos/google_search/pdf_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'access_info_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ACCESS_INFO_VO,adapterName: "AccessInfoVOAdapter")
class AccessInfoVO {

  @JsonKey(name: "country")
  @HiveField(0)
  String? country;

  @JsonKey(name: "viewability")
  @HiveField(1)
  String? viewability;

  @JsonKey(name: "embeddable")
  @HiveField(2)
  bool? embeddable;

  @JsonKey(name: "publicDomain")
  @HiveField(3)
  bool? publicDomain;

  @JsonKey(name: "textToSpeechPermission")
  @HiveField(4)
  String? textToSpeechPermission;

  @JsonKey(name: "epub")
  @HiveField(5)
  EpubVO? epub;

  @JsonKey(name: "pdf")
  @HiveField(6)
  PdfVO? pdf;

  @JsonKey(name: "webReaderLink")
  @HiveField(7)
  String? webReaderLink;

  @JsonKey(name: "accessViewStatus")
  @HiveField(8)
  String? accessViewStatus;

  @JsonKey(name: "quoteSharingAllowed")
  @HiveField(9)
  bool? quoteSharingAllowed;

  AccessInfoVO({
    this.country,
    this.viewability,
    this.embeddable,
    this.publicDomain,
    this.textToSpeechPermission,
    this.epub,
    this.pdf,
    this.webReaderLink,
    this.accessViewStatus,
    this.quoteSharingAllowed,
  });

   factory AccessInfoVO.fromJson(Map<String,dynamic> json) => _$AccessInfoVOFromJson(json);

  Map<String,dynamic> toJson() => _$AccessInfoVOToJson(this);

  @override
  String toString() {
    return 'AccessInfoVO(country: $country, viewability: $viewability, embeddable: $embeddable, publicDomain: $publicDomain, textToSpeechPermission: $textToSpeechPermission, epub: $epub, pdf: $pdf, webReaderLink: $webReaderLink, accessViewStatus: $accessViewStatus, quoteSharingAllowed: $quoteSharingAllowed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AccessInfoVO &&
      other.country == country &&
      other.viewability == viewability &&
      other.embeddable == embeddable &&
      other.publicDomain == publicDomain &&
      other.textToSpeechPermission == textToSpeechPermission &&
      other.epub == epub &&
      other.pdf == pdf &&
      other.webReaderLink == webReaderLink &&
      other.accessViewStatus == accessViewStatus &&
      other.quoteSharingAllowed == quoteSharingAllowed;
  }

  @override
  int get hashCode {
    return country.hashCode ^
      viewability.hashCode ^
      embeddable.hashCode ^
      publicDomain.hashCode ^
      textToSpeechPermission.hashCode ^
      epub.hashCode ^
      pdf.hashCode ^
      webReaderLink.hashCode ^
      accessViewStatus.hashCode ^
      quoteSharingAllowed.hashCode;
  }
}
