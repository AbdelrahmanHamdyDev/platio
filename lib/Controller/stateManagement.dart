import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platio/Model/menuItem.dart';

class CartNotifier extends StateNotifier<Map<menuItem_Model, int>> {
  CartNotifier() : super({});

  bool toggleItem(menuItem_Model item) {
    if (state.containsKey(item)) {
      // remove
      final newState = Map<menuItem_Model, int>.from(state);
      newState.remove(item);
      state = newState;
      return false;
    } else {
      // add with qty=1
      state = {...state, item: 1};
      return true;
    }
  }

  void increaseQuantity(menuItem_Model item) {
    if (state.containsKey(item)) {
      state = {...state, item: state[item]! + 1};
    }
  }

  void decreaseQuantity(menuItem_Model item) {
    if (!state.containsKey(item)) return;

    final qty = state[item]!;
    if (qty > 1) {
      state = {...state, item: qty - 1};
    } else {
      final newState = Map<menuItem_Model, int>.from(state);
      newState.remove(item);
      state = newState;
    }
  }

  void clearCart() {
    state = {};
  }

  // Get all cart items as a list
  List<menuItem_Model> get cartItems => state.keys.toList();
}

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<menuItem_Model, int>>(
      (ref) => CartNotifier(),
    );
