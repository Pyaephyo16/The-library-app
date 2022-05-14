import 'package:flutter_test/flutter_test.dart';
import 'package:the_library_app/blocs/search_page_bloc.dart';

import '../mock_data/mock_data.dart';
import '../models/book_model_impl_mock.dart';

void main(){

  group("Search page bloc test",(){

    SearchPageBloc? searchBloc;

    setUp((){
        searchBloc = SearchPageBloc(model: BookModelImplMock());
    });

  test("search book test",()async{
   await searchBloc?.searchFun("Beginning Flutter", false);
   Future.delayed(Duration(seconds: 4));
    expect(
      searchBloc?.filterList,
       [searBookMock()],
       );
  });

  });

}