import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_library_app/blocs/add_to_shelf_bloc.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/data/vos/shelf_vo.dart';
import 'package:the_library_app/pages/Views/shelves_view.dart';
import 'package:the_library_app/resources/colors.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';

class AddToShelfPage extends StatelessWidget {

  final BookVO userSelectBook;

  AddToShelfPage({
    required this.userSelectBook,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddToShelfBloc>.value(
      value: AddToShelfBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
          },
           icon: Icon(Icons.chevron_left,size: MARGIN_MEDIUM_4,color: CREATE_BUTTON_COLOR,),
           ),
           title: Text(ADD_TO_SHELF_TEXT,
            style: TextStyle(
              fontSize: TEXT_MEDIUM_2,
              color: Colors.black,
            ),
           ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Selector<AddToShelfBloc,List<ShelfVO>>(
            selector: (context,bloc) => bloc.shelfs ?? [],
            shouldRebuild: (previous,next) => previous != next,
            builder: (context,shelfs,child) =>
             ListView.separated(
               separatorBuilder: (context,index) => SizedBox(height: MARGIN_SMALL_1,),
              itemCount: shelfs.length,
              itemBuilder: (context,index){
                print("shelf check ============> ${shelfs.length}");
                return ShelfView(
                  key: Key("AddToShelf$index"),
                  isInAddToShelf: true,
                  image: (shelfs[index].books?.length != 0) ? shelfs[index].books?.first.bookImage ?? shelfs[index].books?.first.searchResult?.volumeInfo?.imageLinks?.thumbnail ?? IMAGE_CONSTANT_ONLINE : IMAGE_CONSTANT_ONLINE,
                  index: index,
                   goToShelf: (index){
                      AddToShelfBloc bloc = Provider.of(context,listen: false);
                  bloc.saveToShelf(index, userSelectBook).then((value){
                    Navigator.pop(context,true);
                    Navigator.pop(context);
                  });
                   },
                    title: shelfs[index].shelfName ?? "",
                     book: shelfs[index].books?.length ?? 0,
                     );
              }
              ),
          ),
        ),
      ),
    );
  }
}