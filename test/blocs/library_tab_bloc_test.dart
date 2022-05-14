import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/library_tab_bloc.dart';

import '../mock_data/mock_data.dart';
import '../models/book_model_impl_mock.dart';

void main(){

  group("Library tab bloc test",(){

    LibraryTabBloc? libBloc;

    setUp((){
      libBloc = LibraryTabBloc(model: BookModelImplMock());
    });


    test("get user tap book from database test",(){
      expect(
        libBloc?.listForCarousel?.contains(bookListForCarouselMockForTest().first),
         true,
         );
      expect(
        libBloc?.chips?.first.category,
         "Combined Print and E-Book Fiction",
         );
    });


    test("get all shelfs from database test",(){
      expect(
        libBloc?.shelfs,
         shelfListMockForTest()
         );
    });

        test("carousel books sort by test",(){
          libBloc?.chooseSort(1);
          expect(
            libBloc?.listForCarousel?.first,
             bookListForCarouselMockForTest().first,
             );
        });


    test("User Tap chip action test",(){
      libBloc?.TapFunction(0);
      expect(
        libBloc?.listForCarousel?.first,
        bookListForCarouselMockForTest().first
         );
    });

     test("User cancel all chip action test",(){
      libBloc?.TapFunction(null);
      expect(
        libBloc?.listForCarousel,
       bookListForCarouselMockForTest(),
         );
    });

  });

}