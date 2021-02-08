import 'package:flutter/material.dart';
import 'package:lifestack/app/home/jobs/empty_content.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class GridItemsBuilder<T> extends StatefulWidget {
  const GridItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  _GridItemsBuilderState<T> createState() => _GridItemsBuilderState<T>();
}

class _GridItemsBuilderState<T> extends State<GridItemsBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasData) {
      final List<T> items = widget.snapshot.data;
      if (items.isNotEmpty) {
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
    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            key: UniqueKey(),
              columnCount: 2,
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget.itemBuilder(context, items[index]),),));
        },
      ),
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