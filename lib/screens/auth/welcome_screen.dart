import 'package:flutter/material.dart';
import 'package:mascotia/core/app_background.dart';
import 'package:mascotia/screens/about/about_screen.dart';
import 'package:mascotia/screens/home/home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildPaws() {
    return [
      // ───────── TOP AREA
      _paw(top: 30, left: 22, size: 18, opacity: 0.08, angle: -0.4),
      _paw(top: 55, left: 110, size: 14, opacity: 0.07, angle: 0.3),
      _paw(top: 42, left: 210, size: 22, opacity: 0.09, angle: 0.5),
      _paw(top: 70, right: 30, size: 18, opacity: 0.08, angle: -0.2),

      // ───────── UPPER CENTER
      _paw(top: 120, left: 45, size: 24, opacity: 0.10, angle: 0.7),
      _paw(top: 140, left: 160, size: 16, opacity: 0.08, angle: -0.5),
      _paw(top: 115, right: 75, size: 26, opacity: 0.09, angle: 0.4),
      _paw(top: 170, right: 25, size: 18, opacity: 0.08, angle: -0.6),

      // ───────── LOGO ZONE
      _paw(top: 220, left: 18, size: 20, opacity: 0.08, angle: 0.2),
      _paw(top: 250, left: 120, size: 28, opacity: 0.10, angle: -0.4),
      _paw(top: 235, right: 120, size: 24, opacity: 0.09, angle: 0.6),
      _paw(top: 275, right: 18, size: 18, opacity: 0.08, angle: -0.3),

      // ───────── TITLE AREA
      _paw(top: 345, left: 40, size: 16, opacity: 0.08, angle: 0.5),
      _paw(top: 365, left: 180, size: 26, opacity: 0.10, angle: -0.7),
      _paw(top: 340, right: 70, size: 20, opacity: 0.09, angle: 0.2),

      // ───────── CARD AREA
      _paw(top: 455, left: 22, size: 30, opacity: 0.10, angle: -0.4),
      _paw(top: 500, left: 135, size: 18, opacity: 0.08, angle: 0.3),
      _paw(top: 470, right: 115, size: 28, opacity: 0.10, angle: -0.5),
      _paw(top: 525, right: 20, size: 20, opacity: 0.08, angle: 0.6),

      // ───────── BUTTON AREA
      _paw(top: 620, left: 40, size: 24, opacity: 0.09, angle: -0.2),
      _paw(top: 655, left: 175, size: 16, opacity: 0.08, angle: 0.5),
      _paw(top: 635, right: 95, size: 32, opacity: 0.10, angle: -0.7),
      _paw(top: 690, right: 25, size: 20, opacity: 0.08, angle: 0.4),

      // ───────── LOWER AREA
      _paw(bottom: 210, left: 25, size: 26, opacity: 0.09, angle: 0.6),
      _paw(bottom: 170, left: 130, size: 18, opacity: 0.08, angle: -0.3),
      _paw(bottom: 200, right: 120, size: 24, opacity: 0.09, angle: 0.5),
      _paw(bottom: 150, right: 30, size: 30, opacity: 0.10, angle: -0.5),

      // ───────── BOTTOM
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool smallDevice = size.height < 750;

    final double logoSize = smallDevice ? 240 : 300;
    final double titleSize = smallDevice ? 54 : 72;

    return Scaffold(
      body: AppBackgroundBlobs(
        child: Stack(
          children: [
            ..._buildPaws(),

            SafeArea(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 28,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: smallDevice ? 0 : 6),

                                // ───────── LOGO
                                Hero(
                                  tag: 'mascotia_logo',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF7FE0B7)
                                              .withOpacity(0.22),
                                          blurRadius: 40,
                                          spreadRadius: 8,
                                        ),
                                        BoxShadow(
                                          color: const Color(0xFF378ADD)
                                              .withOpacity(0.10),
                                          blurRadius: 65,
                                          spreadRadius: 4,
                                        ),
                                      ],
                                    ),
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
                                    child: Text(
                                      "Mascotia",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: titleSize,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        letterSpacing: -3.2,
                                        height: 0.90,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: smallDevice ? 0 : 6),

                                // ───────── CARD PREMIUM
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 26,
                                    vertical: 24,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(32),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.white.withOpacity(0.11),
                                        Colors.white.withOpacity(0.045),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.12),
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
                                    children: [
                                      Container(
                                        width: 42,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF8BE0BD)
                                              .withOpacity(0.90),
                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),
                                      ),

                                      const SizedBox(height: 18),

                                      Text(
                                        "La vida de tu mascota",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                          smallDevice ? 20 : 24,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white
                                              .withOpacity(0.97),
                                          letterSpacing: -0.8,
                                          height: 1.05,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      Text(
                                        "organizada en un solo lugar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize:
                                          smallDevice ? 14 : 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                              .withOpacity(0.82),
                                          height: 1.6,
                                          letterSpacing: 0.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: smallDevice ? 38 : 52),

                                // ───────── BOTÓN GOOGLE
                                _buildGoogleButton(context),

                                const SizedBox(height: 12),

                                // ───────── ABOUT
                                _buildAboutButton(context),

                                SizedBox(height: smallDevice ? 20 : 30),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 66,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0A1628),
          elevation: 14,
          shadowColor: Colors.black.withOpacity(0.22),
          side: BorderSide(
            color: Colors.black.withOpacity(0.04),
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google_logo.png',
              width: 22,
              height: 22,
              fit: BoxFit.contain,
            ),

            const SizedBox(width: 12),

            const Text(
              "Continuar con Google",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Color(0xFF0A1628),
                fontSize: 17,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const AboutMascotiaScreen(),
          ),
        );
      },
      icon: Icon(
        Icons.info_outline_rounded,
        color: Colors.white.withOpacity(0.50),
        size: 16,
      ),
      label: Text(
        "Sobre Mascotia",
        style: TextStyle(
          color: Colors.white.withOpacity(0.50),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}