import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'book_list_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_LIST_VO,adapterName: "BookListVOAdapter")
class BookListVO {

  @JsonKey(name: "list_id")
  @HiveField(0)
  int? listId;

  @JsonKey(name: "list_name")
  @HiveField(1)
  String? listName;

  @JsonKey(name: "list_name_encoded")
  @HiveField(2)
  String? listNameEncoded;

  @JsonKey(name: "display_name")
  @HiveField(3)
  String? displayName;

  @JsonKey(name: "updated")
  @HiveField(4)
  String? updated;

  @JsonKey(name: "list_image")
  @HiveField(5)
  String? listImage;

  @JsonKey(name: "list_image_width")
  @HiveField(6)
  double? listImageWidth;

  @JsonKey(name: "list_image_height")
  @HiveField(7)
  double? listImageHeight;

  @JsonKey(name: "books")
  @HiveField(8)
  List<BookVO>? books;
  
  BookListVO({
    this.listId,
    this.listName,
    this.listNameEncoded,
    this.displayName,
    this.updated,
    this.listImage,
    this.listImageWidth,
    this.listImageHeight,
    this.books,
  });


  BookListVO.empty();

 

  factory BookListVO.fromJson(Map<String,dynamic> json) => _$BookListVOFromJson(json);

  Map<String,dynamic> toJson() => _$BookListVOToJson(this);



  @override
  String toString() {
    return 'BookListVO(listId: $listId, listName: $listName, listNameEncoded: $listNameEncoded, displayName: $displayName, updated: $updated, listImage: $listImage, listImageWidth: $listImageWidth, listImageHeight: $listImageHeight, books: $books)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookListVO &&
      other.listId == listId &&
      other.listName == listName &&
      other.listNameEncoded == listNameEncoded &&
      other.displayName == displayName &&
      other.updated == updated &&
      other.listImage == listImage &&
      other.listImageWidth == listImageWidth &&
      other.listImageHeight == listImageHeight &&
      listEquals(other.books, books);
  }

  @override
  int get hashCode {
    return listId.hashCode ^
      listName.hashCode ^
      listNameEncoded.hashCode ^
      displayName.hashCode ^
      updated.hashCode ^
      listImage.hashCode ^
      listImageWidth.hashCode ^
      listImageHeight.hashCode ^
      books.hashCode;
  }
}
