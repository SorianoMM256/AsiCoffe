import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'item_cafe.dart';
import 'providers.dart';

class CafeItemCard extends ConsumerWidget {
  final CafeItem item;
  final VoidCallback onTap;

  const CafeItemCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteIds = ref.watch(favoritesProvider);
    final isFavorite = favoriteIds.contains(item.id);
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  item.imagemUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 90,
                      height: 90,
                      color: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.local_cafe,
                        size: 40,
                        color: colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nome,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.categoria,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.semGluten ? 'Sem glúten' : 'Contém glúten',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: item.semGluten ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isFavorite ? 'Remover dos favoritos' : 'Favoritar',
                onPressed: () {
                  ref.read(favoritesProvider.notifier).toggleFavorite(item.id);
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : colorScheme.outline,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}