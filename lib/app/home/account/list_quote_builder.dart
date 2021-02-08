import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lifestack/app/home/jobs/empty_content.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListQuoteBuilder<T> extends StatefulWidget {
  const ListQuoteBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  _ListQuoteBuilderState<T> createState() => _ListQuoteBuilderState<T>();
}

class _ListQuoteBuilderState<T> extends State<ListQuoteBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      final List<T> items = widget.snapshot.data;
      if (items.isNotEmpty) {
        return _buildCarousel2(items);
      } else {
        return EmptyContent();
      }
    } else if (widget.snapshot.hasError) {
      return EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      );
    }
    return Center(child: CircularProgressIndicator());
  }

  // Widget _buildCarousel(List<T> items) {
  //   return CarouselSlider.builder(
  //       options: CarouselOptions(),
  //       itemCount: items.length,
  //       itemBuilder: (BuildContext context, int itemIndex) {
  //         return widget.itemBuilder(context, items[itemIndex]);
  //       });}

    Widget _buildCarousel2(List<T> items) {
      int _current = 0;
      return Column(children: <Widget>[
        CarouselSlider.builder(
            options: CarouselOptions(
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
                print(_current);
                print(index);
              }
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return widget.itemBuilder(context, items[itemIndex]);
            }),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.map((news) {
              int index = items.indexOf(news);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
                ),
              );
            }).toList(),
          ),
      ]
      );
    }
  }


//   Widget _buildAnimatedList(List<T> items, job) {
//     return AnimatedList(
//       key: Key('job-${job.id}'),
//       initialItemCount: items.length + 2,
//       itemBuilder: (context, index, animation) {
//         return widget.itemBuilder(context, items[index - 1]);
//       },
//     );
//   }
// }

// AnimatedList(
//                 controller: _scrollController,
//                 key: _listKey,
//                 initialItemCount: phrases.length,
//                 itemBuilder: (_, index, animation) {
//                   return ScaleTransition(
//                     scale: animation.drive(
//                       CurveTween(curve: Curves.easeOut),
//                     ),
//                     child: PhraseListItem(
//                       phraseModel: phrases.phrases[index],
//                       undoPressed: _addItemToList,
//                       index: index,
//                       onDismissed: (direction, index) {
//                         _removeItemFromList(index);
//                       },
//                     ),
//                   );
//                 },
//               );
