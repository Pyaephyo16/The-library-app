import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:the_library_app/dummy/dummy_data.dart';

class HomePageBloc extends ChangeNotifier{

int currentIndex = 0;
int tabIndex = 0;
int libTabIndex = 0;
int gpValue = 1;
int sortStyle = 1;
List<ChipVO> chips = chipData;

  libChooseTab(int index){
      libTabIndex = index;
      notifyListeners();
  }

  userChooseTab(int index){
      currentIndex = index;
      notifyListeners();
  }

  userChooseBookTypeIndex(int index){
    tabIndex = index;
    notifyListeners();
  }

   Future<int> chooseSort(int value){
    print("radio data ==================> $value");
    gpValue = value;
    notifyListeners();
    print("gp value after insert ===========> $gpValue");
    return Future.value(gpValue);
  }

     Future<int> listOrGridSort(int value){
    print("radio data ==================> $value");
    sortStyle = value;
    notifyListeners();
    print("gp value after insert ===========> $sortStyle");
    return Future.value(sortStyle);
  }

   TapFunction(int? i){
    List<ChipVO> data = chipData.mapIndexed((index,e){
       e.isSelected = false;
       if(index == i){
         e.isSelected = true;
         notifyListeners();
       }
       return e;
     }).toList();
     chips = data;
     notifyListeners();
     print("Chip Data ============> ${chips}");
  }




}