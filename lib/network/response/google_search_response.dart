import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/google_search/search_result_vo.dart';

part 'google_search_response.g.dart';

@JsonSerializable()
class GoogleSearchResponse {

  @JsonKey(name: "kind")
  String? kind;

  @JsonKey(name: "totalItems")
  int? totalItems;

  @JsonKey(name: "items")
  List<SearchResultVO>? items;

  GoogleSearchResponse({
    this.kind,
    this.totalItems,
    this.items,
  });

      factory GoogleSearchResponse.fromJson(Map<String,dynamic> json) => _$GoogleSearchResponseFromJson(json);

  Map<String,dynamic> toJson() => _$GoogleSearchResponseToJson(this);

}
