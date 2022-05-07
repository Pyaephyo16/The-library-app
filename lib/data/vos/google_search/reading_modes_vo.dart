import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'reading_modes_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_READING_MODES_VO,adapterName: "ReadingModesAdapter")
class ReadingModesVO {

  @JsonKey(name: "text")
  @HiveField(0)
  bool? text;

  @JsonKey(name: "image")
  @HiveField(1)
  bool? image;

  ReadingModesVO({
    this.text,
    this.image,
  });

      factory ReadingModesVO.fromJson(Map<String,dynamic> json) => _$ReadingModesVOFromJson(json);

  Map<String,dynamic> toJson() => _$ReadingModesVOToJson(this);


  @override
  String toString() => 'ReadingModesVO(text: $text, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReadingModesVO &&
      other.text == text &&
      other.image == image;
  }

  @override
  int get hashCode => text.hashCode ^ image.hashCode;
}
