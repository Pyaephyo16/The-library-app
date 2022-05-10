import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'shelf_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_SHELF_VO,adapterName: "ShelfVOAdapter")
class ShelfVO {

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? shelfName;

  @HiveField(2)
  List<BookVO>? books = [];

  ShelfVO.empty();

  ShelfVO({
    this.id,
    this.shelfName,
    this.books,
  });
  

  @override
  String toString() => 'ShelfVO(id: $id, shelfName: $shelfName, books: $books)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShelfVO &&
      other.id == id &&
      other.shelfName == shelfName &&
      listEquals(other.books, books);
  }

  @override
  int get hashCode => id.hashCode ^ shelfName.hashCode ^ books.hashCode;
}
