import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'reviews_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_REVIEWS_VO,adapterName: "ReviewsVOAdapter")
class ReviewsVO {

  @JsonKey(name: "book_review_link")
  @HiveField(0)
  String? bookReviewLink;

  @JsonKey(name: "first_chapter_link")
  @HiveField(1)
  String? firstChapterLink;

  @JsonKey(name: "sunday_review_link")
  @HiveField(2)
  String? sundayReviewLink;

  @JsonKey(name: "article_chapter_link")
  @HiveField(3)
  String? articleChapterLink;
  
  ReviewsVO({
    this.bookReviewLink,
    this.firstChapterLink,
    this.sundayReviewLink,
    this.articleChapterLink,
  });

  factory ReviewsVO.fromJson(Map<String,dynamic> json) => _$ReviewsVOFromJson(json);

  Map<String,dynamic> toJson() => _$ReviewsVOToJson(this);


  @override
  String toString() {
    return 'ReviewsVO(bookReviewLink: $bookReviewLink, firstChapterLink: $firstChapterLink, sundayReviewLink: $sundayReviewLink, articleChapterLink: $articleChapterLink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ReviewsVO &&
      other.bookReviewLink == bookReviewLink &&
      other.firstChapterLink == firstChapterLink &&
      other.sundayReviewLink == sundayReviewLink &&
      other.articleChapterLink == articleChapterLink;
  }

  @override
  int get hashCode {
    return bookReviewLink.hashCode ^
      firstChapterLink.hashCode ^
      sundayReviewLink.hashCode ^
      articleChapterLink.hashCode;
  }
}
