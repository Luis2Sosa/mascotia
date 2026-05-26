import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mascotia/core/app_background.dart';

class AboutMascotiaScreen extends StatelessWidget {
  const AboutMascotiaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final safeTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackgroundBlobs(
        child: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // ─────────────────────────────────────────────
                  // HEADER PREMIUM
                  // ─────────────────────────────────────────────
                  SliverAppBar(
                    expandedHeight: size.height * 0.28,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    pinned: false,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Center(
                        child: Hero(
                          tag: 'mascotia_logo',
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // GLOW
                              Container(
                                width: size.width * 0.52,
                                height: size.width * 0.52,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xFF5DCAA5)
                                          .withOpacity(0.16),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),

                              // LOGO
                              Container(
                                padding: const EdgeInsets.all(26),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFF1D9E75)
                                          .withOpacity(0.25),
                                      const Color(0xFF143A32)
                                          .withOpacity(0.18),
                                    ],
                                  ),
                                  border: Border.all(
                                    color:
                                    Colors.white.withOpacity(0.10),
                                    width: 1.2,
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: size.width * 0.34,
                                  height: size.width * 0.34,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ─────────────────────────────────────────────
                  // CONTENIDO
                  // ─────────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          // TITULO
                          Text(
                            'Sobre Mascotia',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.08,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14),

                          // SUBTITULO
                          Text(
                            'Recordatorios, comunidad y cuidado.\nTodo en un solo lugar.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.72),
                              fontSize: 15,
                              height: 1.6,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 36),

                          // ─────────────────────────────────────
                          // CARD 1
                          // ─────────────────────────────────────
                          _PremiumGlassCard(
                            title: 'Qué puedes hacer',
                            icon: Icons.pets_rounded,
                            accentColor: Colors.orangeAccent,
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

                          const SizedBox(height: 26),

                          // ─────────────────────────────────────
                          // CARD 2
                          // ─────────────────────────────────────
                          _PremiumGlassCard(
                            title: 'Por qué existe',
                            icon: Icons.auto_awesome_rounded,
                            accentColor: Colors.lightBlueAccent,
                            child: Text(
                              'Creemos que cuidar a tu mascota debería sentirse natural. '
                                  'Sin ruido visual ni distracciones, Mascotia se enfoca '
                                  'en fortalecer el vínculo con tu mejor amigo.',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.72),
                                fontSize: 15,
                                height: 1.7,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 26),

                          // ─────────────────────────────────────
                          // CARD 3
                          // ─────────────────────────────────────
                          _PremiumGlassCard(
                            title: 'Diseño & Privacidad',
                            icon: Icons.verified_user_rounded,
                            accentColor: Colors.greenAccent,
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

                          const SizedBox(height: 46),

                          // TEXTO FINAL
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
                        ],
                      ),
                    ),
                  ),

                  // ─────────────────────────────────────────────
                  // FOOTER
                  // ─────────────────────────────────────────────
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 40,
                        bottom: size.height * 0.04,
                      ),
                      child: Column(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // ─────────────────────────────────────────────
              // BOTON BACK
              // ─────────────────────────────────────────────
              Positioned(
                top: safeTop + 8,
                left: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter:
                    ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1,
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        tooltip: 'Volver',
                        onPressed: () =>
                            Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// PREMIUM CARD
// ─────────────────────────────────────────────────────
class _PremiumGlassCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color accentColor;

  const _PremiumGlassCard({
    required this.title,
    required this.icon,
    required this.child,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 16,
          sigmaY: 16,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.82),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.55),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 40,
                spreadRadius: -8,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.16),
                      borderRadius:
                      BorderRadius.circular(14),
                    ),
                    child: Icon(
                      icon,
                      color: accentColor,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1E24),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              child,
            ],
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
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFF1D9E75),
                borderRadius:
                BorderRadius.circular(20),
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black.withOpacity(0.72),
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