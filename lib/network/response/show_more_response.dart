import 'package:json_annotation/json_annotation.dart';

import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/show_more/show_more_result_vo.dart';

part 'show_more_response.g.dart';

@JsonSerializable()
class ShowMoreResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyright;

  @JsonKey(name: "num_results")
  int? numResults;

  @JsonKey(name: "last_modified")
  String? lastModified;

  @JsonKey(name: "results")
  List<BookVO>? result;

  ShowMoreResponse({
    this.status,
    this.copyright,
    this.numResults,
    this.lastModified,
    this.result,
  });

    factory ShowMoreResponse.fromJson(Map<String,dynamic> json) => _$ShowMoreResponseFromJson(json);

    Map<String,dynamic> toJson()=> _$ShowMoreResponseToJson(this);

}
