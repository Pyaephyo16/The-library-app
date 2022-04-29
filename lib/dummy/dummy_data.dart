import 'package:flutter/material.dart';

import 'package:the_library_app/pages/tabs/library_tab.dart';
import 'package:the_library_app/view_items/book_name_and_info_view.dart';
import 'package:the_library_app/widgets/book_view_for_carousel.dart';

List<Widget> bookListForCarousel = [
  BookViewForCarousel(
    image: "https://assets.alexandria.raywenderlich.com/books/flta/images/5707c4c6bbbdb94a269e25213689e5f22219aa9b2e583072ce85af94a4e3bbfe/w594.png",
    isSample: false,
  ),
  BookViewForCarousel(
    image: "https://cdn.pastemagazine.com/www/system/images/photo_albums/best-book-covers-july-2019/large/bbcjuly19verynice.jpg?1384968217",
    isSample: true,
  ),
  BookViewForCarousel(
    image: "https://i.pinimg.com/originals/35/66/dc/3566dc24c327c144d18dffbac7145d28.jpg",
    isSample: true,
  ),
  BookViewForCarousel(
    image: "https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1608224251l/56321056._SX318_.jpg",
    isSample: false,
  ),
  BookViewForCarousel(
    image: "https://images-na.ssl-images-amazon.com/images/I/81kN9wPZv7L.jpg",
    isSample: false,
  ),
  BookViewForCarousel(
    image: "https://m.media-amazon.com/images/I/41gr3r3FSWL.jpg",
    isSample: true,
  ),
];

List<ChipVO> chipData = [
  ChipVO(title: "Not Started",),
   ChipVO(title: "In Progress",),
    ChipVO(title: "Downloaded",),
     ChipVO(title: "Not Downloaded",),
      ChipVO(title: "Ebooks",),
       ChipVO(title: "Horror",),
  ];

class ChipVO {
    String? title;
    bool? isSelected;

  ChipVO({required this.title,this.isSelected = false});


  @override
  String toString() => 'ChipVO(title: $title, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ChipVO &&
      other.title == title &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode => title.hashCode ^ isSelected.hashCode;
  }

  
  List<ShelfVO> shelfs = [
    ShelfVO(
      title: "My shelf1",
      content: "3 books",
      isSelected: false,
    ),
    ShelfVO(
      title: "My shelf2",
      content: "5 books",
      isSelected: false,
    ),
  ];

class ShelfVO {

  String? title;
  String? content;
  bool? isSelected;
  ShelfVO({
   required this.title,
   required this.content,
   required this.isSelected,
  });

  @override
  String toString() => 'ShelfVO(title: $title, content: $content, isSelected: $isSelected)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ShelfVO &&
      other.title == title &&
      other.content == content &&
      other.isSelected == isSelected;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ isSelected.hashCode;
}

class BookVO {
  String? title;
  String? content;
  
  BookVO({
   required this.title,
   required this.content,
  });

  @override
  String toString() => 'BookVO(title: $title, content: $content)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BookVO &&
      other.title == title &&
      other.content == content;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode;
}

List<BookVO> bookDummy = [
  BookVO(
    title: "a book",
    content: "About a book",
  ),
  BookVO(
    title: "b book",
    content: "About b book",
  ),
  BookVO(
    title: "c book",
    content: "About c book",
  ),
  BookVO(
    title: "d book",
    content: "About d book",
  ),
  BookVO(
    title: "e book",
    content: "About e book",
  ),
  BookVO(
    title: "f book",
    content: "About f book",
  ),
  BookVO(
    title: "g book",
    content: "About g book",
  ),
  BookVO(
    title: "h book",
    content: "About h book",
  ),
  BookVO(
    title: "i book",
    content: "About i book",
  ),
  BookVO(
    title: "j book",
    content: "About j book",
  ),
  BookVO(
    title: "k book",
    content: "About k book",
  ),
  BookVO(
    title: "l book",
    content: "About l book",
  ),
  BookVO(
    title: "m book",
    content: "About m book",
  ),
  BookVO(
    title: "n book",
    content: "About n book",
  ),
];

// List<Widget> rebounceTestData = [

//   BookNameAndInfoView(
//     isSheet: true,
//      title: "",
//       content: content,
//        isInShelf: false,
//        ),

// ];



