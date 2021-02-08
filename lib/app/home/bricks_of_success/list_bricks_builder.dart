import 'package:flutter/material.dart';
import 'package:lifestack/app/home/jobs/empty_content.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListBrickBuilder<T> extends StatefulWidget {
  const ListBrickBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  _ListBrickBuilderState<T> createState() => _ListBrickBuilderState<T>();
}

class _ListBrickBuilderState<T> extends State<ListBrickBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      print(widget.snapshot.data[0]);
      final List<T> items = widget.snapshot.data;
      if (items.isNotEmpty) {
        print(items);
        return _buildList(items);
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

  Widget _buildList(List<T> items) {
    final myBricks = items.asMap();
    print(myBricks[0]);

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 4.1,
          crossAxisCount: 4,
          mainAxisSpacing: 0,
          crossAxisSpacing: 1),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return widget.itemBuilder(context, items[index]);
        },
    );
  }
}


// Column(children: <Widget>[
      
//       Text(myBricks[0].toString())

//     ]);}}










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