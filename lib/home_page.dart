import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'new_item_modal.dart';

import 'card_item.dart';
import 'providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _openNewItemModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) => const NewItemModal(),
  );
 }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final items = ref.watch(productsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        actions: [
        IconButton(
          tooltip: 'Cadastrar item',
          onPressed: () => _openNewItemModal(context),
          icon: const Icon(Icons.add),
         ),
        ],
        backgroundColor: const Color(0xFF5D4037),
        centerTitle: true,
        title: Text(
          'AsiCoffee',
          style: GoogleFonts.pacifico(
            fontSize: 28,
            color: const Color.fromARGB(255, 212, 200, 200),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Cardápio da cafeteria',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3E2723),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Escolha seu café favorito e marque os itens que mais gostou.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.brown,
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return CafeItemCard(item: item);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openNewItemModal(context),
        icon: const Icon(Icons.add),
        label: const Text('Novo item'),
      ),
    );
  }
}