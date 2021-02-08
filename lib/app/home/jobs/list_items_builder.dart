import 'package:flutter/material.dart';
import 'package:lifestack/app/home/jobs/empty_content.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatefulWidget {
  const ListItemsBuilder({
    Key key,
    @required this.snapshot,
    @required this.itemBuilder,
  }) : super(key: key);
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  _ListItemsBuilderState<T> createState() => _ListItemsBuilderState<T>();
}

class _ListItemsBuilderState<T> extends State<ListItemsBuilder<T>> {
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
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length + 2,
        separatorBuilder: (context, index) => Divider(height: 0.5),
        itemBuilder: (context, index) {
          if (index == 0 || index == items.length + 1) {
            return Container();
          }
          return widget.itemBuilder(context, items[index - 1]);
        },
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