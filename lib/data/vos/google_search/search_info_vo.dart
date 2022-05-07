import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'search_info_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SEARCH_INFO_VO,adapterName: "SearchInfoVOAdapter")
class SearchInfoVO {

  @JsonKey(name: "textSnippet")
  @HiveField(0)
  String? textSnippet;

  SearchInfoVO({
    this.textSnippet,
  });

    factory SearchInfoVO.fromJson(Map<String,dynamic> json) => _$SearchInfoVOFromJson(json);

  Map<String,dynamic> toJson() => _$SearchInfoVOToJson(this);



  @override
  String toString() => 'SearchInfoVO(textSnippet: $textSnippet)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SearchInfoVO &&
      other.textSnippet == textSnippet;
  }

  @override
  int get hashCode => textSnippet.hashCode;
}
