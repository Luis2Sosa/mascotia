import 'package:flutter/material.dart';
import '../core/app_ui.dart';

class PetHeaderCenter extends StatelessWidget {
  final String name;
  final String meta;
  const PetHeaderCenter({super.key, required this.name, required this.meta});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(child: PetAvatar(imageProvider: null, onTap: () {})),
        const SizedBox(height: 8),
        Text(name, style: Txt.h1, textAlign: TextAlign.center),
        Text(meta, style: Txt.body, textAlign: TextAlign.center),
      ],
    );
  }
}