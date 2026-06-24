import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_cafe.dart';
import 'item_cafe.dart';

class ProductsNotifier extends StateNotifier<List<CafeItem>> {
  ProductsNotifier() : super(cafeItems);

  void addProduct(CafeItem item) {
    state = [item, ...state];
  }

  void removeProduct(String id) {
    state = state.where((item) => item.id != id).toList();
  }
}

final productsProvider =
    StateNotifierProvider<ProductsNotifier, List<CafeItem>>((ref) {
  return ProductsNotifier();
});