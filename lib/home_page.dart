import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Center(
        child: Text(
          'Bem-vindo ao AsiCoffee!',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF3E2723),
          ),
        ),
      ),
    );
  }
}