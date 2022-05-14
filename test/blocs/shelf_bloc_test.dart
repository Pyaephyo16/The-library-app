import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/shelf_bloc.dart';

import '../mock_data/mock_data.dart';
import '../models/book_model_impl_mock.dart';

void main(){

  group("Shelf Bloc test",(){

      ShelfBloc? sBloc;

      setUp((){
        sBloc = ShelfBloc(0,model: BookModelImplMock());
      });

    
    test("Get all shelfs test",(){
      expect(
        sBloc?.shelfs?.contains(shelfListMockForTest().first),
         true,
         );
      expect(
        sBloc?.chips?.first.category,
         "Combined Print and E-Book Fiction",
         );
    });

    
  test("carousel book sort by test",(){
    sBloc?.chooseSort(1, 0);
    expect(
      sBloc?.booksInShelf?.first,
       shelfListMockForTest().first.books?.first,
       );
  });


  test("Tap chip action test",(){
    sBloc?.TapFunction(0, 0);
    expect(
      sBloc?.booksInShelf,
      shelfListMockForTest().first.books,
       );
  });

    test("Tap cancel all chips action test",(){
    sBloc?.TapFunction(null, 0);
    expect(
      sBloc?.booksInShelf,
      shelfListMockForTest().first.books,
       );
  });

  });

}