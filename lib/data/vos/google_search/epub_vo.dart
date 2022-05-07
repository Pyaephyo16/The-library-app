import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'epub_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_EPUB_VO,adapterName: "EpubVOAdapter")
class EpubVO {

  @JsonKey(name: "isAvailable")
  @HiveField(0)
  bool? isAvailable;

  EpubVO({
    this.isAvailable,
  });

   factory EpubVO.fromJson(Map<String,dynamic> json) => _$EpubVOFromJson(json);

  Map<String,dynamic> toJson() => _$EpubVOToJson(this);

  @override
  String toString() => 'EpubVO(isAvailable: $isAvailable)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EpubVO &&
      other.isAvailable == isAvailable;
  }

  @override
  int get hashCode => isAvailable.hashCode;
}
