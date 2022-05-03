import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'isbns_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_ISBNS_VO,adapterName: "IsbnsVOAdapter")
class IsbnsVO {

  @JsonKey(name: "isbn10")
  @HiveField(0)
  String? isbn10;

  @JsonKey(name: "isbn13")
  @HiveField(1)
  String? isbn13;

  IsbnsVO({
    this.isbn10,
    this.isbn13,
  });

  factory IsbnsVO.fromJson(Map<String,dynamic> json) => _$IsbnsVOFromJson(json);

  Map<String,dynamic> toJson() => _$IsbnsVOToJson(this);


  @override
  String toString() => 'IsbnsVO(isbn10: $isbn10, isbn13: $isbn13)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is IsbnsVO &&
      other.isbn10 == isbn10 &&
      other.isbn13 == isbn13;
  }

  @override
  int get hashCode => isbn10.hashCode ^ isbn13.hashCode;
}
