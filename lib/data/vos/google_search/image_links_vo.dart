import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'image_links_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_IMAGE_LINKS_VO,adapterName: "ImageLinksVOAdapter")
class ImageLinksVO {

  @JsonKey(name: "smallThumbnail")
  @HiveField(0)
  String? smallThumbnail;

  @JsonKey(name: "thumbnail")
  @HiveField(1)
  String? thumbnail;

  ImageLinksVO({
    this.smallThumbnail,
    this.thumbnail,
  });

   factory ImageLinksVO.fromJson(Map<String,dynamic> json) => _$ImageLinksVOFromJson(json);

  Map<String,dynamic> toJson() => _$ImageLinksVOToJson(this);


  @override
  String toString() => 'ImageLinksVO(smallThumbnail: $smallThumbnail, thumbnail: $thumbnail)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImageLinksVO &&
      other.smallThumbnail == smallThumbnail &&
      other.thumbnail == thumbnail;
  }

  @override
  int get hashCode => smallThumbnail.hashCode ^ thumbnail.hashCode;
}
