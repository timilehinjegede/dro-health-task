part of 'bag_cubit.dart';

enum ItemState { initial, added, removed }

class BagState extends Equatable{
  final ItemState itemState;
  final BagItem bagItem;
  final List<BagItem> bagItems;

  BagState({
    this.itemState = ItemState.initial,
    this.bagItem = const BagItem(quantity: 0),
    this.bagItems = const <BagItem>[],
  });

  BagState copyWith({
    final ItemState itemState,
    final BagItem bagItem,
    final List<BagItem> bagItems,
  }) {
    return BagState(
      itemState: itemState ?? this.itemState,
      bagItem: bagItem ?? this.bagItem,
      bagItems: bagItems ?? this.bagItems,
    );
  }

  @override
  List<Object> get props => [itemState, bagItem, bagItems];
  
}
