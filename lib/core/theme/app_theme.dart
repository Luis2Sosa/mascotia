import 'package:flutter/material.dart';

class AppTheme {
  // ─────────────────────────────────────────────
  // 🎨 COLORES PRINCIPALES
  // ─────────────────────────────────────────────
  static const Color azulProfundo = Color(0xFF1565C0);
  static const Color verdeEsmeralda = Color(0xFF2E7D32);
  static const Color acentoVerde = Color(0xFF66BB6A);

  static const Color blancoSuave = Color(0xFFF5F7FA);

  // ─────────────────────────────────────────────
  // 🌈 DEGRADADO GLOBAL PREMIUM
  // ─────────────────────────────────────────────
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      azulProfundo,
      verdeEsmeralda,
    ],
  );

  // ─────────────────────────────────────────────
  // ✨ GLASS EFFECT
  // ─────────────────────────────────────────────
  static BoxDecoration glassDecoration({
    double radius = 28,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),

      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(.12),
          Colors.white.withOpacity(.05),
        ],
      ),

      border: Border.all(
        color: Colors.white.withOpacity(.08),
        width: 1.1,
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.12),
          blurRadius: 24,
          offset: const Offset(0, 14),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  // 📐 RADIOS
  // ─────────────────────────────────────────────
  static const BorderRadius cardRadius =
  BorderRadius.all(Radius.circular(28));

  // ─────────────────────────────────────────────
  // 🎭 THEME GLOBAL
  // ─────────────────────────────────────────────
  static ThemeData get theme {
    final base = ThemeData.dark(
      useMaterial3: true,
    );

    return base.copyWith(
      primaryColor: acentoVerde,

      scaffoldBackgroundColor: Colors.transparent,

      splashColor: Colors.white10,
      highlightColor: Colors.transparent,

      colorScheme: base.colorScheme.copyWith(
        primary: acentoVerde,
        secondary: acentoVerde,
        surface: const Color(0xFF13293F),
      ),

      // ───────────────── APP BAR
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.8,
        ),
      ),

      // ───────────────── TEXTOS
      textTheme: base.textTheme.copyWith(
        headlineLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          letterSpacing: -2,
        ),

        headlineMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          letterSpacing: -1,
        ),

        titleLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),

        bodyLarge: TextStyle(
          color: Colors.white.withOpacity(.92),
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),

        bodyMedium: TextStyle(
          color: Colors.white.withOpacity(.78),
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),

        labelLarge: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ───────────────── BOTONES
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: acentoVerde,
          foregroundColor: Colors.white,

          minimumSize: const Size.fromHeight(58),

          elevation: 0,

          shadowColor: Colors.transparent,

          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),

          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
          ),
        ),
      ),

      // ───────────────── INPUTS
      inputDecorationTheme: InputDecorationTheme(
        filled: true,

        fillColor: Colors.white.withOpacity(.08),

        hintStyle: TextStyle(
          color: Colors.white.withOpacity(.45),
          fontWeight: FontWeight.w500,
        ),

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(.08),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: acentoVerde.withOpacity(.45),
            width: 1.3,
          ),
        ),
      ),

      // ───────────────── CARDS
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(.06),

        margin: EdgeInsets.zero,

        elevation: 0,

        clipBehavior: Clip.antiAlias,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),

      // ───────────────── FLOATING BUTTON
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: acentoVerde,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ───────────────── BOTTOM SHEET
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: const Color(0xFF10263E),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
      ),

      // ───────────────── DIVIDER
      dividerColor: Colors.white.withOpacity(.08),
    );
  }

  // ─────────────────────────────────────────────
  // 🎨 HELPERS
  // ─────────────────────────────────────────────
  static Color get azul => azulProfundo;
}