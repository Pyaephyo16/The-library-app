import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/show_more_bloc.dart';

import '../mock_data/mock_data.dart';
import '../models/book_model_impl_mock.dart';

void main(){

 group("Show more bloc test",(){

    ShowMoreBloc? smBloc;

  setUp((){
    smBloc = ShowMoreBloc(0, resultMockForTest(),model: BookModelImplMock());
  });


  test("Show More Book Database check",(){
    expect(
      smBloc?.showMoreBooks,
       showMoreMockForTest(),
       );
  });

   test("Show More Book for next offest Database check",(){
     smBloc?.clickForMoreViewNextPage();
     Future.delayed(Duration(seconds: 3));
    expect(
      smBloc?.showMoreBooks,
       showMoreMockForTest(),
       );
  });

 });


}