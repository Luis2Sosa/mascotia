import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

/// Fondo degradado simple (por si lo usas en otras pantallas)
class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.brandGradient),
      child: SafeArea(child: child),
    );
  }
}

/// Fondo degradado + círculos translúcidos (el que te gusta)
class AppBackgroundBlobs extends StatelessWidget {
  final Widget child;
  const AppBackgroundBlobs({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.brandGradient),
      child: Stack(
        children: [
          // Círculo grande arriba-derecha
          Positioned(
            top: -90,
            right: -40,
            child: _blob(260, Colors.white.withOpacity(.10)),
          ),
          // Círculo mediano izquierda-centro
          Positioned(
            top: 180,
            left: -60,
            child: _blob(220, Colors.white.withOpacity(.08)),
          ),
          // Círculo grande abajo-izquierda
          Positioned(
            bottom: -120,
            left: -80,
            child: _blob(340, Colors.white.withOpacity(.07)),
          ),
          // Contenido
          SafeArea(child: child),
        ],
      ),
    );
  }

  Widget _blob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}