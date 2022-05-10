import 'package:flutter/material.dart';

import 'package:the_library_app/pages/tabs/library_tab.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/widgets/book_view_for_carousel.dart';


List<String> bookListCarouselImage = [
 "https://assets.alexandria.raywenderlich.com/books/flta/images/5707c4c6bbbdb94a269e25213689e5f22219aa9b2e583072ce85af94a4e3bbfe/w594.png",
  "https://cdn.pastemagazine.com/www/system/images/photo_albums/best-book-covers-july-2019/large/bbcjuly19verynice.jpg?1384968217",
  "https://i.pinimg.com/originals/35/66/dc/3566dc24c327c144d18dffbac7145d28.jpg",
  "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1608224251l/56321056._SX318_.jpg",
  "https://images-na.ssl-images-amazon.com/images/I/81kN9wPZv7L.jpg",
  "https://m.media-amazon.com/images/I/41gr3r3FSWL.jpg",
];

List<Widget> bookListForCarousel = [
  BookViewForCarousel(
    image: "https://assets.alexandria.raywenderlich.com/books/flta/images/5707c4c6bbbdb94a269e25213689e5f22219aa9b2e583072ce85af94a4e3bbfe/w594.png",
    isSample: false,
    menuFun: (){},
  ),
  BookViewForCarousel(
    image: "https://cdn.pastemagazine.com/www/system/images/photo_albums/best-book-covers-july-2019/large/bbcjuly19verynice.jpg?1384968217",
    isSample: true,
    menuFun: (){},
  ),
  BookViewForCarousel(
    image: "https://i.pinimg.com/originals/35/66/dc/3566dc24c327c144d18dffbac7145d28.jpg",
    isSample: true,
    menuFun: (){},
  ),
  BookViewForCarousel(
    image: "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1608224251l/56321056._SX318_.jpg",
    isSample: false,
    menuFun: (){},
  ),
  BookViewForCarousel(
    image: "https://images-na.ssl-images-amazon.com/images/I/81kN9wPZv7L.jpg",
    isSample: false,
    menuFun: (){},
  ),
  BookViewForCarousel(
    image: "https://m.media-amazon.com/images/I/41gr3r3FSWL.jpg",
    isSample: true,
    menuFun: (){},
  ),
];

// List<ChipVO> chipData = [
//   ChipVO(title: "Not Started",),
//    ChipVO(title: "In Progress",),
//     ChipVO(title: "Downloaded",),
//      ChipVO(title: "Not Downloaded",),
//       ChipVO(title: "Ebooks",),
//        ChipVO(title: "Horror",),
//   ];

// class ChipVO {
//     String? title;
//     bool? isSelected;

//   ChipVO({required this.title,this.isSelected = false});


//   @override
//   String toString() => 'ChipVO(title: $title, isSelected: $isSelected)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is ChipVO &&
//       other.title == title &&
//       other.isSelected == isSelected;
//   }

//   @override
//   int get hashCode => title.hashCode ^ isSelected.hashCode;
//   }

  
  // List<ShelfVO> shelfs = [
  //   ShelfVO(
  //     title: "My shelf1",
  //     content: "3 books",
  //     isSelected: false,
  //   ),
  //   ShelfVO(
  //     title: "My shelf2",
  //     content: "5 books",
  //     isSelected: false,
  //   ),
  // ];

// class ShelfVO {

//   String? title;
//   String? content;
//   bool? isSelected;
//   ShelfVO({
//    required this.title,
//    required this.content,
//    required this.isSelected,
//   });

//   @override
//   String toString() => 'ShelfVO(title: $title, content: $content, isSelected: $isSelected)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
  
//     return other is ShelfVO &&
//       other.title == title &&
//       other.content == content &&
//       other.isSelected == isSelected;
//   }

//   @override
//   int get hashCode => title.hashCode ^ content.hashCode ^ isSelected.hashCode;
// }

class BookTestVO {
  String? title;
  String? content;
  
  BookTestVO({
   required this.title,
   required this.content,
  });

  @override
  String toString() => 'BookVO(title: $title, content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookTestVO &&
      other.title == title &&
      other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;
}

List<BookTestVO> bookDummy = [
  BookTestVO(
    title: "a book",
    content: "About a book",
  ),
  BookTestVO(
    title: "b book",
    content: "About b book",
  ),
  BookTestVO(
    title: "c book",
    content: "About c book",
  ),
  BookTestVO(
    title: "d book",
    content: "About d book",
  ),
  BookTestVO(
    title: "e book",
    content: "About e book",
  ),
  BookTestVO(
    title: "f book",
    content: "About f book",
  ),
  BookTestVO(
    title: "g book",
    content: "About g book",
  ),
  BookTestVO(
    title: "h book",
    content: "About h book",
  ),
  BookTestVO(
    title: "i book",
    content: "About i book",
  ),
  BookTestVO(
    title: "j book",
    content: "About j book",
  ),
  BookTestVO(
    title: "k book",
    content: "About k book",
  ),
  BookTestVO(
    title: "l book",
    content: "About l book",
  ),
  BookTestVO(
    title: "m book",
    content: "About m book",
  ),
  BookTestVO(
    title: "n book",
    content: "About n book",
  ),
  BookTestVO(
    title: "a1 book",
    content: "About a book",
  ),
  BookTestVO(
    title: "b1 book",
    content: "About b book",
  ),
  BookTestVO(
    title: "c1 book",
    content: "About c book",
  ),
  BookTestVO(
    title: "d1 book",
    content: "About d book",
  ),
  BookTestVO(
    title: "e1 book",
    content: "About e book",
  ),
  BookTestVO(
    title: "f1 book",
    content: "About f book",
  ),
  BookTestVO(
    title: "g1 book",
    content: "About g book",
  ),
  BookTestVO(
    title: "h1 book",
    content: "About h book",
  ),
  BookTestVO(
    title: "i1 book",
    content: "About i book",
  ),
  BookTestVO(
    title: "j1 book",
    content: "About j book",
  ),
  BookTestVO(
    title: "k1 book",
    content: "About k book",
  ),
  BookTestVO(
    title: "l1 book",
    content: "About l book",
  ),
  BookTestVO(
    title: "m1 book",
    content: "About m book",
  ),
  BookTestVO(
    title: "n1 book",
    content: "About n book",
  ),
  BookTestVO(
    title: "a3 book",
    content: "About a book",
  ),
  BookTestVO(
    title: "b3 book",
    content: "About b book",
  ),
  BookTestVO(
    title: "c3 book",
    content: "About c book",
  ),
  BookTestVO(
    title: "d3 book",
    content: "About d book",
  ),
  BookTestVO(
    title: "e3 book",
    content: "About e book",
  ),
  BookTestVO(
    title: "f3 book",
    content: "About f book",
  ),
  BookTestVO(
    title: "g3 book",
    content: "About g book",
  ),
  BookTestVO(
    title: "h3 book",
    content: "About h book",
  ),
  BookTestVO(
    title: "i3 book",
    content: "About i book",
  ),
  BookTestVO(
    title: "j3 book",
    content: "About j book",
  ),
  BookTestVO(
    title: "k3 book",
    content: "About k book",
  ),
  BookTestVO(
    title: "l3 book",
    content: "About l book",
  ),
  BookTestVO(
    title: "m3 book",
    content: "About m book",
  ),
  BookTestVO(
    title: "a4 book",
    content: "About a4 book",
  ),
  BookTestVO(
    title: "a5 book",
    content: "About a5 book",
  ),
  BookTestVO(
    title: "a6 book",
    content: "About a6 book",
  ),
  BookTestVO(
    title: "a7 book",
    content: "About a7 book",
  ),
];


// import "package:collection/collection.dart";

// main(List<String> args) {
//   var data = [
//     {"title": 'Avengers', "release_date": '10/01/2019'},
//     {"title": 'Creed', "release_date": '10/01/2019'},
//     {"title": 'Jumanji', "release_date": '30/10/2019'},
//   ];


//   var newMap = groupBy(data, (Map obj) => obj['release_date']);

//   print(newMap);
//   var temp = DateTime.now().toUtc();
//   var d1 = DateTime.utc(temp.year,temp.month,temp.day);
//   var d2 = DateTime.utc(2018,10,25);     //you can add today's date here
//   if(d2.compareTo(d1)==0){
//     print('true');
//   }else{
//     print('false');
//   }
// }



