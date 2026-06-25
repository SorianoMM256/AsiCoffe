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

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggleFavorite(String id) {
    final updatedFavorites = {...state};

    if (updatedFavorites.contains(id)) {
      updatedFavorites.remove(id);
    } else {
      updatedFavorites.add(id);
    }

    state = updatedFavorites;
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});

final favoriteProductsProvider = Provider<List<CafeItem>>((ref) {
  final products = ref.watch(productsProvider);
  final favoriteIds = ref.watch(favoritesProvider);

  return products.where((item) => favoriteIds.contains(item.id)).toList();
});

enum ProductFilter {
  onlyCoffee,
  glutenFree,
}

class FiltersNotifier extends StateNotifier<Map<ProductFilter, bool>> {
  FiltersNotifier()
      : super({
          ProductFilter.onlyCoffee: false,
          ProductFilter.glutenFree: false,
        });

  void setFilter(ProductFilter filter, bool active) {
    state = {
      ...state,
      filter: active,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<ProductFilter, bool>>((ref) {
  return FiltersNotifier();
});

final filteredProductsProvider = Provider<List<CafeItem>>((ref) {
  final products = ref.watch(productsProvider);
  final filters = ref.watch(filtersProvider);

  var filteredProducts = products;

  if (filters[ProductFilter.onlyCoffee] == true) {
    filteredProducts = filteredProducts
        .where((item) => item.categoria.toLowerCase().contains('café'))
        .toList();
  }

  if (filters[ProductFilter.glutenFree] == true) {
    filteredProducts = filteredProducts.where((item) => item.semGluten).toList();
  }

  return filteredProducts;
});