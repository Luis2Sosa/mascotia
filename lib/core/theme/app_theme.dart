import 'package:flutter/material.dart';

class AppTheme {
  // 🎨 Paleta de colores oscuros y elegantes
  static const Color azulProfundo = Color(0xFF1565C0); // azul fuerte
  static const Color verdeEsmeralda = Color(0xFF2E7D32); // verde oscuro elegante
  static const Color acentoVerde = Color(0xFF66BB6A); // verde más claro para botones

  static const Color crema = Color(0xFFFFF6E5);
  static const Color tinta = Color(0xFF222222);

  // 🌈 Degradado global (azul profundo -> verde esmeralda)
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      azulProfundo,
      verdeEsmeralda,
    ],
  );

  // 📐 Radios y sombras consistentes
  static const BorderRadius cardRadius = BorderRadius.all(Radius.circular(20));
  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8)),
  ];

  // 🎭 ThemeData global
  static ThemeData get theme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      primaryColor: acentoVerde,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: tinta,
        displayColor: tinta,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: acentoVerde,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.black45),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      cardTheme: const CardThemeData(
        color: crema,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  static Color? get azul => null;
}