import 'package:bloc/bloc.dart';
import 'package:dro_health/data/models/models.dart';
import 'package:equatable/equatable.dart';

part 'bag_state.dart';

class BagCubit extends Cubit<BagState> {
  BagCubit() : super(BagState());

  List<BagItem> itemBagList = [];

  void addToBag(Medication medication) {
    // check if the product is already in bag
    // check if the quantity is 0
    final isMedicationInBag = itemBagList.any(
      (itemBag) => itemBag.medication == medication,
    );

    if (isMedicationInBag) {
      // modify exisiting medication in the bag
      final BagItem bagItem = itemBagList.firstWhere(
        (itemBag) => itemBag.medication == medication,
      );

      if (state.quantity != 0) {
        bagItem.quantity = state.quantity;
        int index = itemBagList.indexOf(bagItem);
        itemBagList[index] = bagItem;
        emit(
          state.copyWith(
            itemState: ItemState.added,
            bagItems: itemBagList,
          ),
        );
        // remove from bag if quantity is less than zero
      } else {
        final BagItem bagItem = itemBagList.firstWhere(
          (itemBag) => itemBag.medication == medication,
        );
        itemBagList.remove(bagItem);
        emit(
          state.copyWith(
            itemState: ItemState.removed,
            bagItems: itemBagList,
          ),
        );
      }
    } else {
      // create a new bag item if medication is not in bag
      BagItem bagItem = BagItem(
        medication: medication,
        quantity: state.quantity,
      );

      emit(
        state.copyWith(
          itemState: ItemState.added,
          bagItems: itemBagList..add(bagItem),
        ),
      );
    }
  }

  // increase the quantity of an item
  void increaseQuantity() {
    var newQuantity = state.quantity + 1;
    print(newQuantity);
    emit(
      state.copyWith(
        quantity: newQuantity,
        itemState: ItemState.initial,
      ),
    );
  }

  // increase the quantity of an item
  void decreaseQuantity() {
    if (state.quantity >= 1) {
      var newQuantity = state.quantity - 1;
      emit(
        state.copyWith(
          quantity: newQuantity,
          itemState: ItemState.initial,
        ),
      );
    }
  }

  void resetToInitial() {
    emit(
      state.copyWith(
        quantity: 0,
        itemState: ItemState.initial,
      ),
    );
  }

  void removeItemFromBag(Medication medication) {
    final BagItem bagItem = itemBagList.firstWhere(
      (itemBag) => itemBag.medication == medication,
    );
    itemBagList.remove(bagItem);
    emit(
      state.copyWith(
        itemState: ItemState.removed,
        bagItems: itemBagList,
      ),
    );
  }

  void increaseItemQuanity(String productId) {}

  void decreaseItemQuantity(String productId) {}
}
