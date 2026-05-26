import 'package:flutter/material.dart';
import '../../core/app_ui.dart';
import '../../core/theme/app_theme.dart';
import '../social/social_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Tab { reminders, social }

class _HomeScreenState extends State<HomeScreen> {
  _Tab current = _Tab.reminders;

  // DEMO: mascotas disponibles (perfil activo arriba)
  final List<_Pet> _pets = const [
    _Pet(name: 'Rocky', meta: '4 años • 31 kg'),
    _Pet(name: 'Luna',  meta: '2 años • 5 kg'),
    _Pet(name: 'Coco',  meta: '1 año • 9 kg'),
  ];
  int _activePetIndex = 0;

  // DEMO feed
  final List<Post> posts = const [
    Post(id: 1, author: 'Rocky', text: '¡Cumplí 2 años! 🎉', imageAsset: 'assets/images/feed1.jpg'),
    Post(id: 2, author: 'Luna',  text: 'Fui al parque hoy 🐕🌳', imageAsset: 'assets/images/feed2.jpg'),
    Post(id: 3, author: 'Milo',  text: 'Siesta después del baño 🧼😴', imageAsset: 'assets/images/feed3.jpg'),
    Post(id: 4, author: 'Nala',  text: 'Nueva correa 💙', imageAsset: 'assets/images/feed4.jpg'),
    Post(id: 5, author: 'Coco',  text: 'Veterinario listo ✅', imageAsset: 'assets/images/feed5.jpg'),
    Post(id: 6, author: 'Simba', text: 'Aprendí “sentado” 🐾', imageAsset: 'assets/images/feed6.jpg'),
  ];
  final Set<int> liked = {1};

  @override
  Widget build(BuildContext context) {
    final activePet = _pets[_activePetIndex];

    return AppScaffold(
      appBar: AppBar(title: const SizedBox.shrink(), centerTitle: true),

      // FAB solo en Social: abre picker “Publicar como…”
      floatingActionButton: current == _Tab.social
          ? FloatingActionButton(
        onPressed: () async {
          final name = await SocialPanel.showPublishAsPicker(
            context,
            petNames: _pets.map((e) => e.name).toList(),
          );
          if (name == null) return;
          final i = _pets.indexWhere((p) => p.name == name);
          if (i >= 0) setState(() => _activePetIndex = i);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Publicar como: $name')),
          );
        },
        child: const Icon(Icons.add_a_photo_rounded),
      )
          : null,

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
        child: current == _Tab.social
            ? NestedScrollView(
          headerSliverBuilder: (_, __) => [
            SliverToBoxAdapter(
              child: _HeaderAndTabs(
                pet: activePet,
                current: current,
                onChanged: _onTabChange,
                showPetSwitch: false, // NO en Social
                onTapSwitch: null,
              ),
            ),
          ],
          body: SocialPanel(
            posts: posts,
            isLiked: (id) => liked.contains(id),
            onToggleLike: (id) => setState(
                    () => liked.contains(id) ? liked.remove(id) : liked.add(id)),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HeaderAndTabs(
              pet: activePet,
              current: current,
              onChanged: _onTabChange,
              showPetSwitch: true, // SOLO en Recordatorios
              onTapSwitch: () async {
                final i = await _showPetPicker(
                  context,
                  title: 'Cambiar mascota',
                  initialIndex: _activePetIndex,
                );
                if (i != null) setState(() => _activePetIndex = i);
              },
            ),
            const Expanded(child: _RemindersPanelNoScroll()),
          ],
        ),
      ),
    );
  }

  void _onTabChange(_Tab t) => setState(() => current = t);

  /// Bottom sheet para elegir mascota
  Future<int?> _showPetPicker(
      BuildContext context, {
        required String title,
        required int initialIndex,
      }) {
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 38, height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12, borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 14),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                ...List.generate(_pets.length, (i) {
                  final p = _pets[i];
                  final selected = i == initialIndex;
                  return ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    leading: const CircleAvatar(
                      backgroundColor: Colors.black12,
                      child: Icon(Icons.pets, color: Colors.black54),
                    ),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text(p.meta),
                    trailing: selected ? const Icon(Icons.check, color: Colors.green) : null,
                    onTap: () => Navigator.of(context).pop(i),
                  );
                }),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Modelo simple de mascota (demo)
class _Pet {
  final String name;
  final String meta;
  const _Pet({required this.name, required this.meta});
}

/// Cabecera + Tabs
class _HeaderAndTabs extends StatelessWidget {
  final _Pet pet;
  final _Tab current;
  final ValueChanged<_Tab> onChanged;
  final bool showPetSwitch;
  final VoidCallback? onTapSwitch;

  const _HeaderAndTabs({
    required this.pet,
    required this.current,
    required this.onChanged,
    required this.showPetSwitch,
    required this.onTapSwitch,
  });

  @override
  Widget build(BuildContext context) {
    final inactive = Colors.white.withOpacity(.80);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 4),

        // Botón "Cambiar" ENCIMA del avatar (y todo más arriba)
        if (showPetSwitch) ...[
          Center(
            child: _PetSwitchButton(
              label: 'Cambiar',
              onTap: onTapSwitch!, // se inyecta desde arriba
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Avatar
        const Center(child: PetAvatar(imageProvider: null, onTap: _noop)),
        const SizedBox(height: 6),

        // Nombre + meta
        Text(pet.name, style: Txt.h1, textAlign: TextAlign.center),
        Text(pet.meta, style: Txt.body, textAlign: TextAlign.center),
        const SizedBox(height: 8),

        // Tabs
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onChanged(_Tab.reminders),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recordatorios',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: current == _Tab.reminders ? Colors.white : inactive,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onChanged(_Tab.social),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Social',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: current == _Tab.social ? Colors.white : inactive,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 4,
          child: LayoutBuilder(builder: (context, c) {
            final half = c.maxWidth / 2;
            return Stack(
              children: [
                Container(color: Colors.white.withOpacity(.22)),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  left: current == _Tab.reminders ? 0 : half,
                  width: half,
                  top: 0,
                  bottom: 0,
                  child: Container(color: Colors.white),
                ),
              ],
            );
          }),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// Botón pequeño para cambiar mascota (solo en Recordatorios)
class _PetSwitchButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _PetSwitchButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(.18),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.pets, size: 16, color: Colors.white),
              const SizedBox(width: 6),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800)),
              const SizedBox(width: 4),
              const Icon(Icons.expand_more, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

/// Recordatorios (sin scroll) + CTA de Tips
class _RemindersPanelNoScroll extends StatelessWidget {
  const _RemindersPanelNoScroll();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hoy 15:00', style: Txt.small),
                Gaps.s,
                Text('Próxima vacunación', style: Txt.h2),
              ],
            ),
          ),
          Gaps.l,
          const Text('Próximas', style: Txt.h2),
          Gaps.m,
          const AppCard(
            child: Column(
              children: [
                _ReminderRow(icon: Icons.directions_walk, text: 'Paseo (tarde)', date: '5:00 p.m.'),
                Divider(),
                _ReminderRow(icon: Icons.medication, text: 'Desparasitación', date: '1 mayo'),
                Divider(),
                _ReminderRow(icon: Icons.bathtub, text: 'Baño', date: '20 mayo'),
              ],
            ),
          ),
          Gaps.l,
          _TipsCTA(),
          Gaps.m,
          AppButton(label: 'Añadir recordatorio', onPressed: _noop),
          Gaps.m,
        ],
      ),
    );
  }
}

void _noop() {}

class _ReminderRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String date;
  const _ReminderRow({required this.icon, required this.text, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        Gaps.wm,
        Expanded(child: Text(text, style: Txt.body)),
        Text(date, style: Txt.small),
      ],
    );
  }
}

/// CTA “Cuida mejor a tu mascota”
class _TipsCTA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: navegar a pantalla de tips
      },
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: const [
            Icon(Icons.pets, color: Colors.black54),
            Gaps.wm,
            Expanded(child: Text('Cuida mejor a tu mascota', style: TextStyle(fontWeight: FontWeight.w800))),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}