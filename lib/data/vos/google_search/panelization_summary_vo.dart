import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'panelization_summary_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_PANELIZATION_SUMMARY_VO,adapterName: "PanelizationSummaryVOAdapter")
class PanelizationSummaryVO {

  @JsonKey(name: "containsEpubBubbles")
  @HiveField(0)
  bool? containsEpubBubbles;

  @JsonKey(name: "containsImageBubbles")
  @HiveField(1)
  bool? containsImageBubbles;

  PanelizationSummaryVO({
    this.containsEpubBubbles,
    this.containsImageBubbles,
  });

      factory PanelizationSummaryVO.fromJson(Map<String,dynamic> json) => _$PanelizationSummaryVOFromJson(json);

  Map<String,dynamic> toJson() => _$PanelizationSummaryVOToJson(this);


  @override
  String toString() => 'PanelizationSummaryVO(containsEpubBubbles: $containsEpubBubbles, containsImageBubbles: $containsImageBubbles)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PanelizationSummaryVO &&
      other.containsEpubBubbles == containsEpubBubbles &&
      other.containsImageBubbles == containsImageBubbles;
  }

  @override
  int get hashCode => containsEpubBubbles.hashCode ^ containsImageBubbles.hashCode;
}
