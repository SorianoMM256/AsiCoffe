import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'item_cafe.dart';
import 'providers.dart';

class ItemDetailsPage extends ConsumerWidget {
  final CafeItem item;

  const ItemDetailsPage({
    super.key,
    required this.item,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesProvider);
    final isFavorite = favoriteIds.contains(item.id);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.nome),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoritesProvider.notifier).toggleFavorite(item.id);
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.network(
                  item.imagemUrl,
                  height: 230,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 230,
                      alignment: Alignment.center,
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.local_cafe,
                        size: 80,
                        color: colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                item.nome,
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _DetailLine(
                        icon: Icons.category,
                        label: 'Categoria',
                        value: item.categoria,
                      ),
                      const Divider(),
                      _DetailLine(
                        icon: Icons.calendar_month,
                        label: 'Lançamento',
                        value: _formatDate(item.dataLancamento),
                      ),
                      const Divider(),
                      _DetailLine(
                        icon: Icons.restaurant,
                        label: 'Glúten',
                        value: item.semGluten ? 'Sem glúten' : 'Contém glúten',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(item.id);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text(
                  isFavorite
                      ? 'Remover dos favoritos'
                      : 'Adicionar aos favoritos',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailLine({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(),
        ),
      ],
    );
  }
}