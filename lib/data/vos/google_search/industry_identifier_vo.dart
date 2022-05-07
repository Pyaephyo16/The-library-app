import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'industry_identifier_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_INDUSTRY_IDENTIFIER_VO,adapterName: "IndustryIdentifierVOAdapter")
class IndustryIdentifierVO {

  @JsonKey(name: "type")
  @HiveField(0)
  String? type;

  @JsonKey(name: "identifier")
  @HiveField(1)
  String? identifier;
  
  IndustryIdentifierVO({
    this.type,
    this.identifier,
  });

    factory IndustryIdentifierVO.fromJson(Map<String,dynamic> json) => _$IndustryIdentifierVOFromJson(json);

  Map<String,dynamic> toJson() => _$IndustryIdentifierVOToJson(this);

  @override
  String toString() => 'IndustryIdentifierVO(type: $type, identifier: $identifier)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is IndustryIdentifierVO &&
      other.type == type &&
      other.identifier == identifier;
  }

  @override
  int get hashCode => type.hashCode ^ identifier.hashCode;
}
