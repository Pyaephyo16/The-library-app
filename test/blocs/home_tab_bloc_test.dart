
import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/home_tab_bloc.dart';

import '../mock_data/mock_data.dart';
import '../models/book_model_impl_mock.dart';

void main(){
  
  group("Home tab Bloc test",(){

      HomeTabBloc? homeBloc;

      setUp((){
        homeBloc = HomeTabBloc(bmodel: BookModelImplMock());
      });


  test("Overview books from database test",(){
    expect(
      homeBloc?.results,
       resultMockForTest(),
       );
     expect(
       homeBloc?.bookLists?.contains(bookListTitleAndSerialMock().first),
        true,
        ); 
  });


  test("get user tap book show in carousel list test",(){
    expect(
      homeBloc?.listForCarousel,
       bookListForCarouselMockForTest()
       );
  });


  });

}