import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mascotia/core/app_background.dart';

class AboutMascotiaScreen extends StatelessWidget {
  const AboutMascotiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool smallDevice = size.height < 750;

    final double logoSize = smallDevice ? 240 : 300;

    return Scaffold(
      body: AppBackgroundBlobs(
        child: Stack(
          children: [
            // ───────── PATITAS EN TODA LA PANTALLA
            ..._buildPaws(),

            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      SizedBox(height: smallDevice ? 0 : 6),

                      // ───────── LOGO GRANDE
                      Hero(
                        tag: 'mascotia_logo',
                        child: Transform.scale(
                          scale: 1.35,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: logoSize,
                            height: logoSize,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      // ───────── TÍTULO
                      Transform.translate(
                        offset: const Offset(0, -54),
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white,
                                  Color(0xFF8BE5C0),
                                ],
                              ).createShader(bounds),
                          child: const Text(
                            "Sobre Mascotia",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -2.2,
                              height: 0.90,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: smallDevice ? 0 : 6),

                      // ───────── CARD 1
                      _premiumCard(
                        title: "Qué puedes hacer",
                        icon: Icons.pets_rounded,
                        child: Column(
                          children: const [
                            _BulletItem(
                              'Gestionar recordatorios de salud.',
                            ),
                            _BulletItem(
                              'Capturar momentos inolvidables.',
                            ),
                            _BulletItem(
                              'Conectar con una comunidad real.',
                            ),
                            _BulletItem(
                              'Sugerencias inteligentes de cuidado.',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ───────── CARD 2
                      _premiumCard(
                        title: "Por qué existe",
                        icon: Icons.auto_awesome_rounded,
                        child: Text(
                          'Creemos que cuidar a tu mascota debería sentirse natural. '
                              'Sin ruido visual ni distracciones, Mascotia se enfoca '
                              'en fortalecer el vínculo con tu mejor amigo.',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.82),
                            fontSize: 15,
                            height: 1.7,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ───────── CARD 3
                      _premiumCard(
                        title: "Diseño & Privacidad",
                        icon: Icons.verified_user_rounded,
                        child: Column(
                          children: const [
                            _BulletItem(
                              'Interfaz limpia y moderna.',
                            ),
                            _BulletItem(
                              'Experiencia fluida y rápida.',
                            ),
                            _BulletItem(
                              'Tus datos están protegidos.',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 38),

                      // ───────── FOOTER
                      Text(
                        'Hecho con ❤️ para quienes aman a sus mascotas.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),

                      const SizedBox(height: 34),

                      Container(
                        width: 36,
                        height: 1.5,
                        color: Colors.white.withOpacity(0.12),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        'SOSA TECH LAB',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 4,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '© 2026 • Todos los derechos reservados',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.35),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                        ),
                      ),

                      SizedBox(height: smallDevice ? 24 : 34),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ───────── PREMIUM CARD
  Widget _premiumCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),

            // ───────── MÁS TRANSPARENTE
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.10),
                Colors.white.withOpacity(0.035),
              ],
            ),

            border: Border.all(
              color: Colors.white.withOpacity(0.10),
              width: 1.2,
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 28,
                offset: const Offset(0, 14),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      icon,
                      color: const Color(0xFF8BE0BD),
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.4,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              child,
            ],
          ),
        ),
      ),
    );
  }

  // ───────── PATITAS EN TODA LA PANTALLA
  List<Widget> _buildPaws() {
    return [
      // TOP
      _paw(top: 30, left: 22, size: 18, opacity: 0.08, angle: -0.4),
      _paw(top: 55, left: 110, size: 14, opacity: 0.07, angle: 0.3),
      _paw(top: 42, left: 210, size: 22, opacity: 0.09, angle: 0.5),
      _paw(top: 70, right: 30, size: 18, opacity: 0.08, angle: -0.2),

      // UPPER
      _paw(top: 120, left: 45, size: 24, opacity: 0.10, angle: 0.7),
      _paw(top: 140, left: 160, size: 16, opacity: 0.08, angle: -0.5),
      _paw(top: 115, right: 75, size: 26, opacity: 0.09, angle: 0.4),
      _paw(top: 170, right: 25, size: 18, opacity: 0.08, angle: -0.6),

      // LOGO
      _paw(top: 220, left: 18, size: 20, opacity: 0.08, angle: 0.2),
      _paw(top: 250, left: 120, size: 28, opacity: 0.10, angle: -0.4),
      _paw(top: 235, right: 120, size: 24, opacity: 0.09, angle: 0.6),
      _paw(top: 275, right: 18, size: 18, opacity: 0.08, angle: -0.3),

      // TITLE
      _paw(top: 345, left: 40, size: 16, opacity: 0.08, angle: 0.5),
      _paw(top: 365, left: 180, size: 26, opacity: 0.10, angle: -0.7),
      _paw(top: 340, right: 70, size: 20, opacity: 0.09, angle: 0.2),

      // CARD AREA
      _paw(top: 455, left: 22, size: 30, opacity: 0.10, angle: -0.4),
      _paw(top: 500, left: 135, size: 18, opacity: 0.08, angle: 0.3),
      _paw(top: 470, right: 115, size: 28, opacity: 0.10, angle: -0.5),
      _paw(top: 525, right: 20, size: 20, opacity: 0.08, angle: 0.6),

      // BUTTON AREA
      _paw(top: 620, left: 40, size: 24, opacity: 0.09, angle: -0.2),
      _paw(top: 655, left: 175, size: 16, opacity: 0.08, angle: 0.5),
      _paw(top: 635, right: 95, size: 32, opacity: 0.10, angle: -0.7),
      _paw(top: 690, right: 25, size: 20, opacity: 0.08, angle: 0.4),

      // LOWER
      _paw(bottom: 210, left: 25, size: 26, opacity: 0.09, angle: 0.6),
      _paw(bottom: 170, left: 130, size: 18, opacity: 0.08, angle: -0.3),
      _paw(bottom: 200, right: 120, size: 24, opacity: 0.09, angle: 0.5),
      _paw(bottom: 150, right: 30, size: 30, opacity: 0.10, angle: -0.5),

      // BOTTOM
      _paw(bottom: 80, left: 55, size: 18, opacity: 0.08, angle: 0.2),
      _paw(bottom: 60, left: 190, size: 24, opacity: 0.09, angle: -0.6),
      _paw(bottom: 95, right: 75, size: 20, opacity: 0.08, angle: 0.4),
      _paw(bottom: 40, right: 20, size: 28, opacity: 0.10, angle: -0.3),
    ];
  }

  Widget _paw({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required double opacity,
    double angle = 0.3,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: angle,
          child: Icon(
            Icons.pets_rounded,
            size: size,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// BULLET ITEM
// ─────────────────────────────────────────────────────
class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF8BE0BD),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.82),
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}