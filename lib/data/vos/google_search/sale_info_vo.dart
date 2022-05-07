import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'sale_info_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SALE_INFO_VO,adapterName: "SaleInfoVOAdapter")
class SaleInfoVO {

  @JsonKey(name: "country")
  @HiveField(0)
  String? country;

  @JsonKey(name: "saleability")
  @HiveField(1)
  String? saleability;

  @JsonKey(name: "isEbook")
  @HiveField(2)
  bool? isEbook;

  SaleInfoVO({
    this.country,
    this.saleability,
    this.isEbook,
  });

  factory SaleInfoVO.fromJson(Map<String,dynamic> json) => _$SaleInfoVOFromJson(json);

  Map<String,dynamic> toJson() => _$SaleInfoVOToJson(this);


  @override
  String toString() => 'SaleInfoVO(country: $country, saleability: $saleability, isEbook: $isEbook)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SaleInfoVO &&
      other.country == country &&
      other.saleability == saleability &&
      other.isEbook == isEbook;
  }

  @override
  int get hashCode => country.hashCode ^ saleability.hashCode ^ isEbook.hashCode;
}
