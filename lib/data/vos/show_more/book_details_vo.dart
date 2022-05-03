import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'book_details_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_BOOK_DETAILS_VO,adapterName: "BookDetailsVOAdapter")
class BookDetailsVO {

  @JsonKey(name: "title")
  @HiveField(0)
  String? title;

  @JsonKey(name: "description")
  @HiveField(1)
  String? description;

  @JsonKey(name: "contributor")
  @HiveField(2)
  String? contributor;

  @JsonKey(name: "author")
  @HiveField(3)
  String? author;

  @JsonKey(name: "contributor_note")
  @HiveField(4)
  String? contributorNote;

  @JsonKey(name: "price")
  @HiveField(5)
  String? price;

  @JsonKey(name: "age_group")
  @HiveField(6)
  String? ageGroup;

  @JsonKey(name: "publisher")
  @HiveField(7)
  String? publisher;

  @JsonKey(name: "primary_isbn13")
  @HiveField(8)
  String? primaryIsbn13;

  @JsonKey(name: "primary_isbn10")
  @HiveField(9)
  String? primary_isbn10;

  @HiveField(10)
  String? time;


    BookDetailsVO.empty();

  BookDetailsVO({
    this.title,
    this.description,
    this.contributor,
    this.author,
    this.contributorNote,
    this.price,
    this.ageGroup,
    this.publisher,
    this.primaryIsbn13,
    this.primary_isbn10,
    this.time,
  });


   factory BookDetailsVO.fromJson(Map<String,dynamic> json) => _$BookDetailsVOFromJson(json);

  Map<String,dynamic> toJson() => _$BookDetailsVOToJson(this);

  @override
  String toString() {
    return 'BookDetailsVO(title: $title, description: $description, contributor: $contributor, author: $author, contributorNote: $contributorNote, price: $price, ageGroup: $ageGroup, publisher: $publisher, primaryIsbn13: $primaryIsbn13, primary_isbn10: $primary_isbn10, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookDetailsVO &&
      other.title == title &&
      other.description == description &&
      other.contributor == contributor &&
      other.author == author &&
      other.contributorNote == contributorNote &&
      other.price == price &&
      other.ageGroup == ageGroup &&
      other.publisher == publisher &&
      other.primaryIsbn13 == primaryIsbn13 &&
      other.primary_isbn10 == primary_isbn10 &&
      other.time == time;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      description.hashCode ^
      contributor.hashCode ^
      author.hashCode ^
      contributorNote.hashCode ^
      price.hashCode ^
      ageGroup.hashCode ^
      publisher.hashCode ^
      primaryIsbn13.hashCode ^
      primary_isbn10.hashCode ^
      time.hashCode;
  }
}
