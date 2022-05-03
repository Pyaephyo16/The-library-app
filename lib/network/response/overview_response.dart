import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/overview/result_vo.dart';

part 'overview_response.g.dart';

@JsonSerializable()
class OverViewResponse {

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "copyright")
  String? copyRight;

  @JsonKey(name: "num_results")
  double? numResults;

  @JsonKey(name: "results")
  ResultVO? results;

  OverViewResponse({
    this.status,
    this.copyRight,
    this.numResults,
    this.results,
  });

     factory OverViewResponse.fromJson(Map<String,dynamic> json) => _$OverViewResponseFromJson(json);

    Map<String,dynamic> toJson() => _$OverViewResponseToJson(this);

}
