part of 'bag_cubit.dart';

enum ItemState { initial, added, removed }

class BagState extends Equatable {
  const BagState({
    this.bagItems = const <BagItem>[],
    this.itemState = ItemState.initial,
    this.quantity = 0,
  });

  final List<BagItem> bagItems;
  final ItemState itemState;
  final int quantity;

  BagState copyWith({
    final List<BagItem> bagItems,
    final ItemState itemState,
    final int quantity,
  }) {
    return BagState(
      bagItems: bagItems ?? this.bagItems,
      itemState: itemState ?? this.itemState,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [bagItems, itemState];
}
