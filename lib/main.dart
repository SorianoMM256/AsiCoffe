import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data_cafe.dart';
import 'card_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5D4037),
        centerTitle: true,
        title: Text(
          'AsiCoffee',
          style: GoogleFonts.pacifico(
            fontSize: 28,
            color: Colors.white,
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
                itemCount: cafeItems.length,
                itemBuilder: (context, index) {
                  final item = cafeItems[index];

                  return CafeItemCard(item: item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}