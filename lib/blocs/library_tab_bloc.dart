import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:the_library_app/data/models/book_model.dart';
import 'package:the_library_app/data/models/book_model_impl.dart';
import 'package:the_library_app/data/vos/chip_vo.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/dummy/dummy_data.dart';
import 'package:the_library_app/persistance/abstraction_layer/book_list_for_carousel_dao.dart';
import 'package:the_library_app/persistance/daos/book_list_for_carousel_dao_impl.dart';

class LibraryTabBloc extends ChangeNotifier{

  BookModel bookModel = BookModelImpl();
   BookListForCarouselDao mBookListCarousel = BookListForCarouselDaoImpl();

int gpValue = 1;
int sortStyle = 1;
int libTabIndex = 0;


  List<String> currentBox = [];       
  List<ChipVO> temp = [];
  List<String> test = [];



 List<BookVO>? listForCarousel;
 List<ChipVO>? chips;
 List<ShelfVO>? shelfs;


 LibraryTabBloc({BookModel? model}){

   if(model != null){
     bookModel = model;
   }

          ///get List For Carousel
        bookModel.getUserTapBookDatabase().listen((event) {
          listForCarousel = event;
          listForCarousel?.sort(((a, b) => a.time!.compareTo(b.time ?? "") ));
          
   listForCarousel?.forEach((element){
              test.add(element.categoryForOverView ?? element.listName ?? element.searchResult?.volumeInfo?.categories?.first ?? "");
          }); 
          temp.clear();
          test.toSet().toList().forEach((testData) {
                temp.add(
                ChipVO(
                  category: testData,
                  isSelected: false,
                )
              );
              });
        chips = temp;
        notifyListeners();
      }).onError((error){
        print("User Tap Book list section database error");
      });


      ///get Shelfs From Database
      bookModel.getAllShelfsDatabase().listen((event) {
        shelfs = event;
        print("shelf check in library tab ===============> ${shelfs}");
        notifyListeners();
      }).onError((error){
        print("get all shelf database error ===========> ${error}");
      });

 }
 
  // void deleteAllShelfsDatabase(){
  //   bookModel.deleteAllShelfsDatabase();
  // }

   libChooseTab(int index){
      libTabIndex = index;
      notifyListeners();
  }


  Future<int> chooseSort(int value){
    gpValue = value;
    notifyListeners();
    if(gpValue == 1){
      if(listForCarousel != null){
        listForCarousel?.sort(((a, b) => a.time!.compareTo(b.time ?? "") ));
      notifyListeners();
      }
    }else if(gpValue == 2){
      if(listForCarousel != null){
        listForCarousel?.sort(((a, b) => (a.author ?? a.bookDetails?.first.author ?? a.searchResult?.volumeInfo?.authors?.first)!.compareTo(b.author ?? b.bookDetails?.first.author ?? b.searchResult?.volumeInfo?.authors?.first ?? "")));
      notifyListeners();
      }
    }else if(gpValue == 3){
     if(listForCarousel != null){
        listForCarousel?.sort(((a, b) => (a.title ?? a.bookDetails?.first.title ?? a.searchResult?.volumeInfo?.title)!.compareTo(b.title ?? b.bookDetails?.first.title ?? b.searchResult?.volumeInfo?.title ?? "")));
      notifyListeners();
     }
    }
    print("gp value after insert ===========> $gpValue");
    return Future.value(gpValue);
  }



    Future<int> listOrGridSort(int value){
    sortStyle = value;
    notifyListeners();
    print("gp value after insert ===========> $sortStyle");
    return Future.value(sortStyle);
  }



  TapFunction(int? i){
      
    List<ChipVO> data = chips?.mapIndexed((index,e){
      if(i == null){
        currentBox.clear();
        e.isSelected = false;
      }else if(index == i && e.isSelected == false){
         e.isSelected = true;
           currentBox.add(e.category ?? "");
       }else if(index == i && e.isSelected == true){
         e.isSelected = false;
         currentBox.remove(e.category);
         notifyListeners();
       }
       return e;
     }).toList() ?? [];

     data.sort(((a, b) => a.isSelected == true ? -1 : 1));
     chips = data;
     
     List<BookVO> testing = bookModel.getSelectedBook(currentBox);
     listForCarousel = testing;
     if(currentBox.isEmpty || currentBox.length == 0){
        bookModel.getUserTapBookDatabase().listen((event) {
          listForCarousel = event;
        });
      }
     notifyListeners();
  }

}