import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:the_library_app/data/vos/overview/book_list_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'result_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_RESULT_VO,adapterName: "ResultVOAdapter")
class ResultVO {

  @JsonKey(name: "bestsellers_date")
  @HiveField(0)
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  @HiveField(1)
  String? publishedDate;

  @JsonKey(name: "published_date_description")
  @HiveField(2)
  String? publishedDateDescription;

  @JsonKey(name: "previous_published_date")
  @HiveField(3)
  String? previousPublishedDate;

  @JsonKey(name: "next_published_date")
  @HiveField(4)
  String? nextPublishedDate;

  @JsonKey(name: "lists")
  @HiveField(5)
  List<BookListVO>? lists;

  ResultVO.empty();

  ResultVO({
    this.bestsellersDate,
    this.publishedDate,
    this.publishedDateDescription,
    this.previousPublishedDate,
    this.nextPublishedDate,
    this.lists,
  });

     factory ResultVO.fromJson(Map<String,dynamic> json) => _$ResultVOFromJson(json);

    Map<String,dynamic> toJson() => _$ResultVOToJson(this);


  @override
  String toString() {
    return 'ResultVO(bestsellersDate: $bestsellersDate, publishedDate: $publishedDate, publishedDateDescription: $publishedDateDescription, previousPublishedDate: $previousPublishedDate, nextPublishedDate: $nextPublishedDate, lists: $lists)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ResultVO &&
      other.bestsellersDate == bestsellersDate &&
      other.publishedDate == publishedDate &&
      other.publishedDateDescription == publishedDateDescription &&
      other.previousPublishedDate == previousPublishedDate &&
      other.nextPublishedDate == nextPublishedDate &&
      listEquals(other.lists, lists);
  }

  @override
  int get hashCode {
    return bestsellersDate.hashCode ^
      publishedDate.hashCode ^
      publishedDateDescription.hashCode ^
      previousPublishedDate.hashCode ^
      nextPublishedDate.hashCode ^
      lists.hashCode;
  }
}
