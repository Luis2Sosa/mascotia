import 'dart:ui';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

/// ─────────────────────────────────────────────
/// ESPACIADOS
/// ─────────────────────────────────────────────
class Gaps {
  static const s = SizedBox(height: 8);
  static const m = SizedBox(height: 14);
  static const l = SizedBox(height: 22);
  static const xl = SizedBox(height: 32);

  static const ws = SizedBox(width: 8);
  static const wm = SizedBox(width: 14);
  static const wl = SizedBox(width: 22);
}

/// ─────────────────────────────────────────────
/// TIPOGRAFÍAS PREMIUM
/// ─────────────────────────────────────────────
class Txt {
  static const h1 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    letterSpacing: -1.8,
    height: 1,
  );

  static const h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    letterSpacing: -0.8,
  );

  static const h3 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static TextStyle body = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: Colors.white.withOpacity(.88),
    height: 1.55,
  );

  static TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.white.withOpacity(.55),
  );
}

/// ─────────────────────────────────────────────
/// APP SCAFFOLD PREMIUM
/// ─────────────────────────────────────────────
class AppScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  const AppScaffold({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
  });

  List<Widget> _buildPaws() {
    return [
      _paw(top: 40, left: 18, size: 18, opacity: .05),
      _paw(top: 120, right: 25, size: 26, opacity: .07),
      _paw(top: 240, left: 35, size: 22, opacity: .06),
      _paw(top: 380, right: 40, size: 30, opacity: .08),
      _paw(top: 520, left: 25, size: 20, opacity: .06),

      _paw(bottom: 260, right: 30, size: 24, opacity: .07),
      _paw(bottom: 180, left: 45, size: 18, opacity: .05),
      _paw(bottom: 100, right: 80, size: 28, opacity: .08),
      _paw(bottom: 40, left: 24, size: 22, opacity: .06),
    ];
  }

  static Widget _paw({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required double opacity,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: .35,
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
    return Container(
      decoration: const BoxDecoration(
        gradient: AppTheme.brandGradient,
      ),
      child: Stack(
        children: [
          ..._buildPaws(),

          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,

              extendBody: true,
              extendBodyBehindAppBar: true,

              appBar: appBar ??
                  (title == null
                      ? null
                      : AppBar(
                    title: Text(
                      title!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),

              body: body,

              floatingActionButton: floatingActionButton,

              bottomNavigationBar: bottomNavigationBar,
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// GLASS CARD PREMIUM
/// ─────────────────────────────────────────────
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          padding: padding,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),

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
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.12),
                blurRadius: 26,
                offset: const Offset(0, 14),
              ),
            ],
          ),

          child: child,
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// BOTÓN PREMIUM
/// ─────────────────────────────────────────────
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.acentoVerde,
          foregroundColor: Colors.white,

          elevation: 0,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 10),
            ],

            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// TEXT FIELD PREMIUM
/// ─────────────────────────────────────────────
class AppTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final IconData? icon;

  const AppTextField({
    super.key,
    this.hint,
    this.controller,
    this.keyboardType,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: icon == null
            ? null
            : Icon(
          icon,
          color: Colors.white.withOpacity(.55),
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// PET AVATAR PREMIUM
/// ─────────────────────────────────────────────
class PetAvatar extends StatelessWidget {
  final ImageProvider? imageProvider;
  final VoidCallback onTap;

  const PetAvatar({
    super.key,
    this.imageProvider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.18),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 58,

            backgroundColor: Colors.white.withOpacity(.95),

            backgroundImage: imageProvider,

            child: imageProvider == null
                ? Icon(
              Icons.pets_rounded,
              size: 42,
              color: Colors.grey.shade500,
            )
                : null,
          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 46,
            height: 46,

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2D8CFF),
                  Color(0xFF1565C0),
                ],
              ),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],

              border: Border.all(
                color: Colors.white.withOpacity(.12),
              ),
            ),

            child: IconButton(
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 20,
              ),

              onPressed: onTap,

              padding: EdgeInsets.zero,

              constraints: const BoxConstraints(),
            ),
          ),
        ),
      ],
    );
  }
}