import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'new_item_modal.dart';
import 'item_cafe.dart';
import 'item_details_page.dart';
import 'card_item.dart';
import 'providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedTab = 0;

  void _openNewItemModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const NewItemModal(),
    );
  }

  void _openDetails(CafeItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ItemDetailsPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _selectedTab == 0
      ? ref.watch(filteredProductsProvider)
      : ref.watch(favoriteProductsProvider);

    final filters = ref.watch(filtersProvider);
    final isFavoritesTab = _selectedTab == 1;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        actions: [
          IconButton(
            tooltip: 'Cadastrar item',
            onPressed: _openNewItemModal,
            icon: const Icon(Icons.add),
          ),
        ],
        backgroundColor: const Color(0xFF5D4037),
        centerTitle: true,
        title: Text(
          isFavoritesTab ? 'Favoritos' : 'AsiCoffee',
          style: GoogleFonts.pacifico(
            fontSize: 28,
            color: const Color.fromARGB(255, 212, 200, 200),
          ),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.local_cafe,
                      size: 46,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Filtros do Cardápio',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SwitchListTile(
                value: filters[ProductFilter.onlyCoffee] ?? false,
                title: const Text('Mostrar apenas cafés'),
                secondary: const Icon(Icons.coffee),
                onChanged: (value) {
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(ProductFilter.onlyCoffee, value);
                },
              ),
              SwitchListTile(
                value: filters[ProductFilter.glutenFree] ?? false,
                title: const Text('Mostrar apenas sem glúten'),
                secondary: const Icon(Icons.no_food),
                onChanged: (value) {
                  ref
                      .read(filtersProvider.notifier)
                      .setFilter(ProductFilter.glutenFree, value);
                },
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('AsiCoffee 2.0'),
                subtitle: Text('Tabs, Drawer, Modal, Dismissible e Riverpod'),
              ),
            ],
              ),
            ),
          ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              isFavoritesTab ? 'Meus Favoritos' : 'Cardápio da cafeteria',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3E2723),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isFavoritesTab
                  ? 'Os itens favoritados aparecem aqui automaticamente.'
                  : 'Escolha seu café favorito e marque os itens que mais gostou.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.brown,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        isFavoritesTab
                            ? 'Nenhum favorito ainda.'
                            : 'Nenhum item cadastrado no cardápio.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.brown,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return _DismissibleItem(
                          item: item,
                          onTap: () => _openDetails(item),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openNewItemModal,
        icon: const Icon(Icons.add),
        label: const Text('Novo item'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) {
          setState(() {
            _selectedTab = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Cardápio',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}

class _DismissibleItem extends ConsumerWidget {
  final CafeItem item;
  final VoidCallback onTap;

  const _DismissibleItem({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(item.id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade700,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      secondaryBackground: Container(
        margin: const EdgeInsets.only(bottom: 14),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade700,
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        ref.read(productsProvider.notifier).removeProduct(item.id);

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.nome} removido.'),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                ref.read(productsProvider.notifier).addProduct(item);
              },
            ),
          ),
        );
      },
      child: CafeItemCard(
        item: item,
        onTap: onTap,
      ),
    );
  }
}