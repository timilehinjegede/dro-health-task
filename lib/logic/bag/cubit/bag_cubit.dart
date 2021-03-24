import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:dro_health/data/data_providers/medications.dart';
import 'package:dro_health/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagState());

  // get
  void getBagItem(Medication med) {
    if (state.bagItems.isNotEmpty) {
      final bool itemExists = state.bagItems.any(
        (item) => item.medication.name == med.name,
      );
      if (itemExists) {
        final bagItem = state.bagItems.firstWhere(
          (element) => element.medication.name == med.name,
        );
        List<BagItem> newBagItemList = [...state.bagItems];
        int index = newBagItemList.indexOf(bagItem);
        newBagItemList[index] = bagItem;
        emit(
          state.copyWith(
            bagItems: newBagItemList,
            bagItem: bagItem,
            itemState: ItemState.initial,
          ),
        );
      } else {
        emit(
          state.copyWith(
            bagItem: BagItem(medication: med, quantity: 0),
            itemState: ItemState.initial,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          bagItem: BagItem(medication: med, quantity: 0),
          itemState: ItemState.initial,
        ),
      );
    }
  }

  // add
  void addItemToBag(Medication med) {
    final bool itemExists =
        state.bagItems.any((item) => item.medication.name == med.name);

    if (itemExists) {
      if (state.bagItem.quantity != 0) {
        final bagItem = state.bagItems.firstWhere(
          (element) => element.medication.name == med.name,
        );
        final List<BagItem> newBagItemList = [...state.bagItems];
        int index = newBagItemList.indexOf(bagItem);
        state.bagItem.copyWith(
          quantity: state.bagItem.quantity,
        );

        newBagItemList[index] = state.bagItem;
        emit(
          state.copyWith(
            bagItems: newBagItemList,
            bagItem: state.bagItem,
            itemState: ItemState.added,
          ),
        );
      } else {
        removeItemFromBag(state.bagItem);
      }
    } else {
      if (state.bagItem.quantity != 0) {
        List<BagItem> newBagList = [...state.bagItems];
        newBagList.add(state.bagItem);
        emit(
          state.copyWith(
            bagItems: newBagList,
            itemState: ItemState.added,
          ),
        );
      }
    }
  }

  // increase
  void increaseItemQuantity([BagItem bagItem]) {
    if (bagItem != null) {
      var newQuantity = state.bagItem.quantity + 1;
      emit(
        state.copyWith(
          bagItem: state.bagItem.copyWith(
            quantity: newQuantity,
          ),
          itemState: ItemState.initial,
        ),
      );
      final List<BagItem> newBagItemList = [...state.bagItems];
      int index = newBagItemList.indexOf(bagItem);
      state.bagItem.copyWith(
        quantity: state.bagItem.quantity,
      );

      newBagItemList[index] = state.bagItem;
      emit(
        state.copyWith(
          bagItems: newBagItemList,
          bagItem: state.bagItem,
          itemState: ItemState.added,
        ),
      );

      addItemToBag(state.bagItem.medication);
    } else {
      var newQuantity = state.bagItem.quantity + 1;
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

  // decrease
  void decreaseItemQuantity([BagItem bagItem]) {
    if (bagItem != null) {
      if (state.bagItem.quantity != 0) {
        var newQuantity = state.bagItem.quantity - 1;
        emit(
          state.copyWith(
            bagItem: state.bagItem.copyWith(
              quantity: newQuantity,
            ),
            itemState: ItemState.initial,
          ),
        );
        final List<BagItem> newBagItemList = [...state.bagItems];
        int index = newBagItemList.indexOf(bagItem);
        state.bagItem.copyWith(
          quantity: state.bagItem.quantity,
        );

        newBagItemList[index] = state.bagItem;
        emit(
          state.copyWith(
            bagItems: newBagItemList,
            bagItem: state.bagItem,
            itemState: ItemState.added,
          ),
        );

        addItemToBag(state.bagItem.medication);
      } else {
        removeItemFromBag(bagItem);
      }
    } else {
      if (state.bagItem.quantity >= 1) {
        var newQuantity = state.bagItem.quantity - 1;
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

  // remove
  void removeItemFromBag(BagItem bagItem) {
    List<BagItem> newBagItemList = [...state.bagItems];
    final item = newBagItemList.firstWhere(
      (element) => element.medication.name == bagItem.medication.name,
    );

    final int index = newBagItemList.indexOf(item);
    newBagItemList.removeAt(index);

    emit(
      state.copyWith(
        bagItems: newBagItemList,
        itemState: ItemState.removed,
      ),
    );
  }

  // get total price
  int getTotalPrice() {
    int totalPrice = 0;
    for (BagItem bagItem in state.bagItems) {
      totalPrice += bagItem.quantity * bagItem.medication.price;
    }
    return totalPrice;
  }
}
