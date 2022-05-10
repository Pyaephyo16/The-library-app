import 'package:hive/hive.dart';
import 'package:the_library_app/persistance/hive_constants.dart';

part 'chip_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_CHIP_VO,adapterName: "ChipVOAdapter")
class ChipVO {

  @HiveField(0)
  String? category;

  @HiveField(1)
  bool? isSelected;

  ChipVO.empty();

  ChipVO({
    this.category,
    this.isSelected,
  });


  @override
  String toString() => 'ChipVO(category: $category, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChipVO &&
      other.category == category &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode => category.hashCode ^ isSelected.hashCode;
}
