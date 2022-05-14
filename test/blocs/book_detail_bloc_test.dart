import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/book_detail_bloc.dart';

import '../mock_data/mock_data.dart';
import '../models/book_model_impl_mock.dart';

void main(){

 group("Book Detail Bloc test",(){
    BookDetailBloc? detailBloc;

  setUp((){
    detailBloc = BookDetailBloc(putBookToCarouselDatabase(),model: BookModelImplMock());
  });

  test("Book Detail test",(){
    expect(
      detailBloc?.detailsInfo,
       putBookToCarouselDatabase(),
       );
  });


  test("Similar books test", ()async{
    detailBloc?.tapForDetail(searBookMock());
    Future.delayed(Duration(seconds: 5));
    expect(
      detailBloc?.similarBooks?.first,
       searBookMock(),
       );
  });
 });

}