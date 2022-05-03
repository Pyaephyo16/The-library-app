import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/data/vos/show_more/book_details_vo.dart';
import 'package:the_library_app/data/vos/show_more/isbns_vo.dart';
import 'package:the_library_app/data/vos/show_more/reviews_vo.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'show_more_result_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SHOW_MORE_RESULT_VO,adapterName: "ShowMoreResultVOAdapter")
class ShowMoreResultVO {

  @JsonKey(name: "list_name")
  @HiveField(0)
  String? listName;

  @JsonKey(name: "display_name")
  @HiveField(1)
  String? displayName;
  
  @JsonKey(name: "bestsellers_date")
  @HiveField(2)
  String? bestsellersDate;

  @JsonKey(name: "published_date")
  @HiveField(3)
  String? publishedDate;

  @JsonKey(name: "rank")
  @HiveField(4)
  int? rank;

  @JsonKey(name: "rank_last_week")
  @HiveField(5)
  int? rankLastWeek;

  @JsonKey(name: "weeks_on_list")
  @HiveField(6)
  int? weeksOnList;

  @JsonKey(name: "asterisk")
  @HiveField(7)
  int? asterisk;

  @JsonKey(name: "dagger")
  @HiveField(8)
  int? dagger;

  @JsonKey(name: "amazon_product_url")
  @HiveField(9)
  String? amazonProductUrl;

  @JsonKey(name: "isbns")
  @HiveField(10)
  List<IsbnsVO>? isbns;

  @JsonKey(name: "book_details")
  @HiveField(11)
  List<BookDetailsVO>? bookDetails;

  @JsonKey(name: "reviews")
  @HiveField(12)
  List<ReviewsVO>? reviews;
  
  ShowMoreResultVO.empty();

  ShowMoreResultVO({
    this.listName,
    this.displayName,
    this.bestsellersDate,
    this.publishedDate,
    this.rank,
    this.rankLastWeek,
    this.weeksOnList,
    this.asterisk,
    this.dagger,
    this.amazonProductUrl,
    this.isbns,
    this.bookDetails,
    this.reviews,
  });


    factory ShowMoreResultVO.fromJson(Map<String,dynamic> json) => _$ShowMoreResultVOFromJson(json);

  Map<String,dynamic> toJson() => _$ShowMoreResultVOToJson(this);

  @override
  String toString() {
    return 'ShowMoreResultVO(listName: $listName, displayName: $displayName, bestsellersDate: $bestsellersDate, publishedDate: $publishedDate, rank: $rank, rankLastWeek: $rankLastWeek, weeksOnList: $weeksOnList, asterisk: $asterisk, dagger: $dagger, amazonProductUrl: $amazonProductUrl, isbns: $isbns, bookDetails: $bookDetails, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShowMoreResultVO &&
      other.listName == listName &&
      other.displayName == displayName &&
      other.bestsellersDate == bestsellersDate &&
      other.publishedDate == publishedDate &&
      other.rank == rank &&
      other.rankLastWeek == rankLastWeek &&
      other.weeksOnList == weeksOnList &&
      other.asterisk == asterisk &&
      other.dagger == dagger &&
      other.amazonProductUrl == amazonProductUrl &&
      listEquals(other.isbns, isbns) &&
      listEquals(other.bookDetails, bookDetails) &&
      listEquals(other.reviews, reviews);
  }

  @override
  int get hashCode {
    return listName.hashCode ^
      displayName.hashCode ^
      bestsellersDate.hashCode ^
      publishedDate.hashCode ^
      rank.hashCode ^
      rankLastWeek.hashCode ^
      weeksOnList.hashCode ^
      asterisk.hashCode ^
      dagger.hashCode ^
      amazonProductUrl.hashCode ^
      isbns.hashCode ^
      bookDetails.hashCode ^
      reviews.hashCode;
  }
}
