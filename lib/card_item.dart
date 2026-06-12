import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'item_cafe.dart';

class CafeItemCard extends StatelessWidget {
  final CafeItem item;

  const CafeItemCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
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
                    color: Colors.brown.shade100,
                    child: const Icon(
                      Icons.local_cafe,
                      size: 40,
                      color: Colors.brown,
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
                      color: const Color(0xFF3E2723),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    item.categoria,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.brown,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'R\$ ${item.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6D4C41),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}