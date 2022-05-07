import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

  part 'show_more_list_for_hive_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SHOW_MORE_LIST_FOR_HIVE_VO,adapterName: "ShowMoreListForHiveVOAdapter")
class ShowMoreListForHiveVO {

  @HiveField(0)
  List<BookVO>? bookList;

    ShowMoreListForHiveVO.empty();

  ShowMoreListForHiveVO({
    this.bookList,
  });

  factory ShowMoreListForHiveVO.fromJson(Map<String,dynamic> json) => _$ShowMoreListForHiveVOFromJson(json);

  Map<String,dynamic> toJson() => _$ShowMoreListForHiveVOToJson(this);

  @override
  String toString() => 'ShowMoreListForHiveVO(bookList: $bookList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShowMoreListForHiveVO &&
      listEquals(other.bookList, bookList);
  }

  @override
  int get hashCode => bookList.hashCode;
}
