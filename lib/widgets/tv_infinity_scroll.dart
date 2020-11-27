library tv_infinity_scroll;

import 'package:flutter/widgets.dart';
import 'package:sticky_infinite_list/sticky_infinite_list.dart';

class TVInfiniteListView extends StatefulWidget {
  /// Builder callback. It should return [InfiniteListItem] instance.
  ///
  /// This function is called during [SliverChildBuilderDelegate]
  final Widget Function(BuildContext, int, bool) itemBuilder;

  /// See: [ScrollView.controller]
  final TVInfiniteScrollController controller;

  /// List direction
  ///
  /// By default [InfiniteListDirection.single]
  ///
  /// If [InfiniteListDirection.multi] is passed - will
  /// render infinite list in both directions
  final InfiniteListDirection direction;

  /// Proxy property for [ScrollView.reverse]
  ///
  /// Package doesn't support it yet.
  ///
  /// But as temporary solution similar result can be achieved
  /// with some config combination, described in README.md
  final bool reverse = false;

  /// Proxy property for [ScrollView.anchor]
  final double anchor;

  /// Proxy property for [RenderViewportBase.cacheExtent]
  final double cacheExtent;

  /// Scroll direction
  ///
  /// Can be vertical or horizontal (see [Axis] class)
  ///
  /// This value also affects how bottom or top
  /// edge header positioned headers behave
  final Axis scrollDirection;

  /// Number of items in list
  final int itemCount;

  ///Composed of the size of each item + its margin/padding.
  ///Size used is width if `scrollDirection` is `Axis.horizontal`, height if `Axis.vertical`.
  ///
  ///Example:
  ///- Horizontal list
  ///- Card with `width` 100
  ///- Margin is `EdgeInsets.symmetric(horizontal: 5)`
  ///- itemSize is `100+5+5 = 110`
  final double itemSize;

  /// Loop in list items
  final bool loop;

  /// Snap to item
  final bool itemSnapping;

  /// index of selected item
  /// - index 0 for first visible items
  final int selectedItemIndex;

  ///Animation curve
  final Curve curve;

  ///Animation duration in milliseconds (ms)
  final int duration;

  ///Callback function when list snaps/focuses to an item
  final void Function(int) onItemSelected;

  ///Callback function when list snaps/focuses to an item
  final void Function(int) onItemFocus;

  ///Callback function when list start scrolling
  final void Function() onScrollStart;

  ///Callback function when list end scrolling
  final void Function() onScrollEnd;


  TVInfiniteListView({
    Key key,
    @required this.itemBuilder,

    this.direction = InfiniteListDirection.multi,
    TVInfiniteScrollController controller,
    @required this.loop,
    this.itemSnapping = true,
    this.selectedItemIndex = 0,
    this.curve = Curves.ease,
    this.duration = 500,
    this.itemCount,
    @required this.itemSize,
    this.anchor = 0.0,
    this.cacheExtent,
    this.scrollDirection = Axis.horizontal,
    this.onItemSelected,
    this.onItemFocus,
    this.onScrollStart,
    this.onScrollEnd
  })  : controller = controller ?? TVInfiniteScrollController(),
        super(key: key);

  @override
  _TVInfiniteListViewState createState() => _TVInfiniteListViewState();

}


class TVInfiniteScrollController extends ScrollController {
  @protected
  double itemSize = 1;
  final Duration _scrollAnimationDuration = Duration(milliseconds: 500);
  final Curve _scrollCurve = Curves.linearToEaseOut ;
  double _offset = 0;
  String _name;


  @protected
  void setItemSize(double size) {
    itemSize = size;
  }

  @override
  void dispose() {
    debugPrint('dispose');
    super.dispose();
  }

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }

  /// Scroll to previous item
  void prevItem() {
    double newOffset = _offset - itemSize;
    if (newOffset >= position.minScrollExtent) {
      _offset = newOffset;
      animateTo((_offset), duration: _scrollAnimationDuration, curve: _scrollCurve);
    }
  }

  /// Scroll to next item
  void nextItem() {
    double newOffset = _offset + itemSize;
    if (newOffset <= position.maxScrollExtent) {
      _offset = newOffset;
      // debugPrint('nextItem after: _offset $_offset itemSize: $itemSize');
      animateTo((_offset), duration: _scrollAnimationDuration, curve: _scrollCurve);

    }
    // jumpTo(_offset);
  }
}

class _TVInfiniteListViewState extends State<TVInfiniteListView> {

  /// Max child count for positive direction list
  int posChildCount;

  /// Max child count for negative list direction
  ///
  /// Ignored when [direction] is [InfiniteListDirection.single]
  ///
  /// This value should have negative value in order to provide right calculation
  /// for negative list
  int negChildCount;


  int _selectedIndex = 0;
  int _previousSelectedIndex = -1;
  bool _addFakeItems = false;

  void initState() {
    /// Check if fake items are needed
    /// Fake items are used so that all items could be scrolled to selectedItemIndex position

    if (widget.itemCount != null && widget.selectedItemIndex != null && widget.loop != true) {
      _addFakeItems = true;
      posChildCount = widget.itemCount;
    }

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.setItemSize(widget.itemSize);
      _selectedIndex = 0;
      _previousSelectedIndex = -1;
      _setSelectedItem();
    });
  }

  /// Calculate offset needed for snapping to item
  double _calcItemPosition({double pixel, @required double itemSize, int index})  {
    double _offset = 0.0;
    _selectedIndex = index != null ? index : ((pixel - itemSize / 2) / itemSize).ceil();
    if (widget.itemSnapping) {
      _offset = _selectedIndex * itemSize;
    }
    return _offset;
  }

  /// Calculate index of selected item
  int _calculateSelectedIndex() {
    if (_selectedIndex != null) {
      return (_selectedIndex + widget.selectedItemIndex);
    } else {
      return _selectedIndex;
    }
  }

  /// Set Selected index
  void _setSelectedItem() {
    if (_selectedIndex != _previousSelectedIndex) {
      _previousSelectedIndex = _selectedIndex;
      if (widget.loop) {
        widget.onItemSelected?.call( _recalculateIndex(_calculateSelectedIndex()) );
      } else {
        widget.onItemSelected?.call( _calculateSelectedIndex() );
      }
    } else {
      widget.onItemSelected?.call( _selectedIndex );
    }
  }

  /// Recalculate item index if loop option is set
  int _recalculateIndex(int index) {
    int outIndex = index;
    if (widget.loop == true) {
      if (widget.itemCount != null && widget.itemCount > 0) {
        outIndex = index % widget.itemCount;
        if (outIndex < 0) {
          outIndex = widget.itemCount + outIndex;
        }
      }
    }
    return outIndex;
  }

  /// Scroll list to an offset - after finished animation call onItemSelected callback
  void _animateSnapScroll(double location) {
    Future.delayed(Duration.zero, () {
      widget.controller.animateTo(
        location,
        duration: new Duration(milliseconds: widget.duration),
        curve: widget.curve,
      ).then( (_) {
        _setSelectedItem();
        setState(() {});
      }
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    double _posFakeItemSize = 0;
    double _negFakeItemSize = 0;

    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraint) {

          /// Adding fake items in order to scroll to selected index position
          if (_addFakeItems) {
            _posFakeItemSize = (widget.scrollDirection == Axis.horizontal
                ? constraint.maxWidth
                : constraint.maxHeight) - (widget.selectedItemIndex + 1) * widget.itemSize;
            _negFakeItemSize = widget.selectedItemIndex * widget.itemSize;
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo is ScrollStartNotification) {
                Future.delayed(Duration.zero, () {
                  widget.onScrollStart?.call();
                  setState(() {
                    _selectedIndex = null;
                  });
                });
              }
              if (scrollInfo is ScrollEndNotification) {
                widget.onScrollEnd?.call();

                //snap to item
                double offset = _calcItemPosition(
                  pixel: scrollInfo.metrics.pixels,
                  itemSize: widget.itemSize,
                );

                //only animate if not yet snapped (tolerance 0.01 pixel)
                if ((scrollInfo.metrics.pixels - offset).abs() > 0.01) {
                  _animateSnapScroll(offset);
                } else {
                  _setSelectedItem();
                  setState(() {});
                }
              }
              return true;
            },
            child: InfiniteList(
                controller: widget.controller,
                direction: widget.direction,
                scrollDirection: widget.scrollDirection,
                posChildCount: _addFakeItems ? posChildCount + 1 : posChildCount,
                negChildCount: _addFakeItems ? 1 : negChildCount ,
                anchor: widget.anchor,
                builder: (context, index) {
                  // debugPrint('InfiniteList index: $index _selectedIndex: $_selectedIndex');
                  bool isSelected = index == _calculateSelectedIndex() ? true : false;
                  int itemIndex = _recalculateIndex(index);
                  return InfiniteListItem(
                    contentBuilder: (BuildContext context) {
                      if (_addFakeItems && ((index >= posChildCount) || index < 0)) {
                        if (index < 0) {
                          return SizedBox(
                            height: widget.scrollDirection == Axis.horizontal ? 1 : _negFakeItemSize,
                            width: widget.scrollDirection == Axis.horizontal ? _negFakeItemSize : 1,
                          );
                        } else {
                          return SizedBox(
                            height: widget.scrollDirection == Axis.horizontal ? 1 : _posFakeItemSize,
                            width: widget.scrollDirection == Axis.horizontal ? _posFakeItemSize : 1,
                          );
                        }
                      } else {
                        return widget.itemBuilder(context, itemIndex, isSelected);
                      }

                    },
                  );
                }
            ),
          );
        }
    );
  }

  @override
  void dispose() {
    debugPrint('DISPOSE');
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    widget.controller.dispose();
    super.dispose();
  }

}