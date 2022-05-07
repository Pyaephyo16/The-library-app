import 'package:flutter/material.dart';
import 'package:the_library_app/data/vos/overview/book_vo.dart';
import 'package:the_library_app/resources/constants.dart';
import 'package:the_library_app/resources/dimens.dart';
import 'package:the_library_app/view_items/book_view.dart';

class ShowMoreBookSection extends StatefulWidget {
  
  final int itemCount;
  final int numResult;
  final Function() moreBooksFun;
  final IndexedWidgetBuilder itemBuilder;

  ShowMoreBookSection({
    required this.itemCount,
    required this.numResult,
    required this.moreBooksFun,
    required this.itemBuilder,
  });

  @override
  State<ShowMoreBookSection> createState() => _ShowMoreBookSectionState();
}

class _ShowMoreBookSectionState extends State<ShowMoreBookSection> {

  var scrollController = ScrollController();

    @override
  void initState() {
      scrollController.addListener(() {
          if(scrollController.position.atEdge){
              if(scrollController.position.pixels == 0){

              }else{
                    widget.moreBooksFun();
              }
          }
      });
    super.initState();
  }

   

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
                controller: scrollController,
                //shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                itemCount: widget.itemCount,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                ),
                 itemBuilder: widget.itemBuilder,
                 );
  }
}