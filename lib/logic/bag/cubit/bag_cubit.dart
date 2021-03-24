import 'package:bloc/bloc.dart';
import 'package:dro_health/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagState());

  // get the current bag item [clicked] or [navigated to]
  void getBagItem(Medication med) {
    // check if the current bag items list is empty
    if (state.bagItems.isNotEmpty) {
      // check if the current bag item exists
      final bool itemExists = state.bagItems.any(
        (item) => item.medication.productId == med.productId,
      );
      if (itemExists) {
        // get the bag item if it exists
        final bagItem = state.bagItems.firstWhere(
          (element) => element.medication.productId == med.productId,
        );

        // list manipulation to add a bag item
        List<BagItem> newBagItemList = [...state.bagItems];
        int index = newBagItemList.indexOf(bagItem);
        newBagItemList[index] = bagItem;

        // emit a state after list manipulation
        emit(
          state.copyWith(
            bagItems: newBagItemList,
            bagItem: bagItem,
            itemState: ItemState.initial,
          ),
        );
      } else {
        // emit a state if item does not exist
        emit(
          state.copyWith(
            bagItem: BagItem(medication: med, quantity: 0),
            itemState: ItemState.initial,
          ),
        );
      }
    } else {
      // emit a state if bag item list is empty
      emit(
        state.copyWith(
          bagItem: BagItem(medication: med, quantity: 0),
          itemState: ItemState.initial,
        ),
      );
    }
  }

  // add a bag item to the bag items list
  void addItemToBag(Medication med) {
    // check if the bag item exists in bag
    final bool itemExists =
        state.bagItems.any((item) => item.medication.productId == med.productId);

    if (itemExists) {
      // check is the current quantity is not zero
      if (state.bagItem.quantity != 0) {
        final bagItem = state.bagItems.firstWhere(
          (element) => element.medication.productId == med.productId,
        );

        // list manipulation
        final List<BagItem> newBagItemList = [...state.bagItems];
        int index = newBagItemList.indexOf(bagItem);
        state.bagItem.copyWith(
          quantity: state.bagItem.quantity,
        );
        newBagItemList[index] = state.bagItem;

        // emit a state after list manipulation
        emit(
          state.copyWith(
            bagItems: newBagItemList,
            bagItem: state.bagItem,
            itemState: ItemState.added,
          ),
        );
      } else {
        // if the item quantity is zero, remove from the bag item lists
        removeItemFromBag(state.bagItem);
      }
    } else {
      // if the item does not exist in bag
      // check is the current quantity is not zero
      if (state.bagItem.quantity != 0) {
        // list manipulation
        List<BagItem> newBagList = [...state.bagItems];
        newBagList.add(state.bagItem);
        // emit a state after list manipulation
        emit(
          state.copyWith(
            bagItems: newBagList,
            itemState: ItemState.added,
          ),
        );
      }
    }
  }

  // increase the quantity of a bag item
  void increaseItemQuantity([BagItem bagItem]) {
    // increasing the quantity from the checkout screen
    if (bagItem != null) {
      // increase the quantity
      var newQuantity = state.bagItem.quantity + 1;
      // emit a new state after increasing the quantity
      emit(
        state.copyWith(
          bagItem: state.bagItem.copyWith(
            quantity: newQuantity,
          ),
          itemState: ItemState.initial,
        ),
      );

      // list manipulation
      final List<BagItem> newBagItemList = [...state.bagItems];
      int index = newBagItemList.indexOf(bagItem);
      // mutate the bag item with the current quantity
      state.bagItem.copyWith(
        quantity: state.bagItem.quantity,
      );

      // list manipulation
      newBagItemList[index] = state.bagItem;

      // emit a new state after sucessful manipulation
      emit(
        state.copyWith(
          bagItems: newBagItemList,
          bagItem: state.bagItem,
          itemState: ItemState.added,
        ),
      );
      // add the item to bag automatically
      addItemToBag(state.bagItem.medication);

      // increasing the quantity from the medication details screen
    } else {
      // increase the qunaity
      var newQuantity = state.bagItem.quantity + 1;
      // emit a new state
      emit(
        state.copyWith(
          bagItem: state.bagItem.copyWith(
            quantity: newQuantity,
          ),
          itemState: ItemState.initial,
        ),
      );
    }
  }

  // decrease the quantity of a bag item
  void decreaseItemQuantity([BagItem bagItem]) {
    // decreasing the quantity from the checkout screen
    if (bagItem != null) {
      // check if item quantity is not equals to zero
      if (state.bagItem.quantity != 0) {
        // decrease the quantity
        var newQuantity = state.bagItem.quantity - 1;
        // emit a new state after decreasing the quantity
        emit(
          state.copyWith(
            bagItem: state.bagItem.copyWith(
              quantity: newQuantity,
            ),
            itemState: ItemState.initial,
          ),
        );

        // list manipulation
        final List<BagItem> newBagItemList = [...state.bagItems];
        int index = newBagItemList.indexOf(bagItem);
        // mutate the bag item with the current quantity
        state.bagItem.copyWith(
          quantity: state.bagItem.quantity,
        );
        // list manipulation
        newBagItemList[index] = state.bagItem;

        // emit a new state after successful manipulation
        emit(
          state.copyWith(
            bagItems: newBagItemList,
            bagItem: state.bagItem,
            itemState: ItemState.added,
          ),
        );

        // add the item to bag automatically
        addItemToBag(state.bagItem.medication);
      } else {
        // remove item from bag if thw quantity is equal to zero
        removeItemFromBag(bagItem);
      }
    // decreasing the quantity from the medication details screen
    } else {
      if (state.bagItem.quantity >= 1) {
        // decrease the quantity
        var newQuantity = state.bagItem.quantity - 1;
        // emit a new state
        emit(
          state.copyWith(
            bagItem: state.bagItem.copyWith(
              quantity: newQuantity,
            ),
            itemState: ItemState.initial,
          ),
        );
      }
    }
  }

  // remove an item from the item bag lists
  void removeItemFromBag(BagItem bagItem) {
    // list manipulation
    List<BagItem> newBagItemList = [...state.bagItems];
    // get the current item
    final item = newBagItemList.firstWhere(
      (element) => element.medication.productId == bagItem.medication.productId,
    );

    final int index = newBagItemList.indexOf(item);
    // remove the item
    newBagItemList.removeAt(index);

    // emit a new state after removing an item
    emit(
      state.copyWith(
        bagItems: newBagItemList,
        itemState: ItemState.removed,
      ),
    );
  }

  // get the total price of items in bag
  int getTotalPrice() {
    int totalPrice = 0;
    for (BagItem bagItem in state.bagItems) {
      totalPrice += bagItem.quantity * bagItem.medication.price;
    }
    return totalPrice;
  }
}
