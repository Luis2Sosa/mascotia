import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

/// Espaciados
class Gaps {
  static const s = SizedBox(height: 8);
  static const m = SizedBox(height: 12);
  static const l = SizedBox(height: 20);
  static const xl = SizedBox(height: 28);

  static const ws = SizedBox(width: 8);
  static const wm = SizedBox(width: 12);
  static const wl = SizedBox(width: 20);
}

/// Tipografías
class Txt {
  static const h1 = TextStyle(fontSize: 28, fontWeight: FontWeight.w800);
  static const h2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  static const h3 = TextStyle(fontSize: 16, fontWeight: FontWeight.w700);
  static const body = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const small = TextStyle(fontSize: 13, color: Colors.black54);
}

/// Scaffold con fondo degradado
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppTheme.brandGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar ??
              (title == null ? null : AppBar(title: Text(title!, overflow: TextOverflow.ellipsis))),
          body: body,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
        ),
      ),
    );
  }
}

/// Card crema reusable
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const AppCard({super.key, required this.child, this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.crema,
        borderRadius: AppTheme.cardRadius,
        boxShadow: AppTheme.cardShadow,
      ),
      padding: padding,
      child: child,
    );
  }
}

/// Botón primario
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const AppButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}

/// TextField
class AppTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  const AppTextField({super.key, this.hint, this.controller, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(hintText: hint),
    );
  }
}

/// Avatar con botón de cámara
class PetAvatar extends StatelessWidget {
  final ImageProvider? imageProvider;
  final VoidCallback onTap;
  const PetAvatar({super.key, this.imageProvider, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 52,
          backgroundColor: Colors.white,
          backgroundImage: imageProvider,
          child: imageProvider == null
              ? const Icon(Icons.pets, size: 40, color: Colors.black38)
              : null,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.azul,
              shape: BoxShape.circle,
              boxShadow: AppTheme.cardShadow,
            ),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
              onPressed: onTap,
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}