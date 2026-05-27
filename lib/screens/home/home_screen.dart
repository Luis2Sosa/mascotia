import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_background.dart';
import '../../core/app_ui.dart';
import '../social/social_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Tab { reminders, social }

class _HomeScreenState extends State<HomeScreen> {
  _Tab current = _Tab.reminders;

  final List<_Pet> _pets = const [
    _Pet(name: 'Rocky', meta: '4 años • 31 kg'),
    _Pet(name: 'Luna', meta: '2 años • 5 kg'),
    _Pet(name: 'Coco', meta: '1 año • 9 kg'),
  ];

  int _activePetIndex = 0;

  final List<Post> posts = const [
    Post(
      id: 1,
      author: 'Rocky',
      text: '¡Cumplí 2 años! 🎉',
      imageAsset: 'assets/images/feed1.jpg',
    ),
    Post(
      id: 2,
      author: 'Luna',
      text: 'Fui al parque hoy 🐕🌳',
      imageAsset: 'assets/images/feed2.jpg',
    ),
  ];

  final Set<int> liked = {1};

  @override
  Widget build(BuildContext context) {
    final activePet = _pets[_activePetIndex];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackgroundBlobs(
        child: Stack(
          children: [
            ..._buildPaws(),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
                child: current == _Tab.social
                    ? NestedScrollView(
                  headerSliverBuilder: (_, __) => [
                    SliverToBoxAdapter(
                      child: _HeaderAndTabs(
                        pet: activePet,
                        current: current,
                        onChanged: _onTabChange,
                        showPetSwitch: false,
                        onTapSwitch: null,
                      ),
                    ),
                  ],
                  body: SocialPanel(
                    posts: posts,
                    isLiked: (id) => liked.contains(id),
                    onToggleLike: (id) {
                      setState(() {
                        liked.contains(id)
                            ? liked.remove(id)
                            : liked.add(id);
                      });
                    },
                  ),
                )
                    : Column(
                  children: [
                    _HeaderAndTabs(
                      pet: activePet,
                      current: current,
                      onChanged: _onTabChange,
                      showPetSwitch: true,
                      onTapSwitch: () async {
                        final i = await _showPetPicker(
                          context,
                          title: 'Cambiar mascota',
                          initialIndex: _activePetIndex,
                        );

                        if (i != null) {
                          setState(() => _activePetIndex = i);
                        }
                      },
                    ),

                    const Expanded(
                      child: _RemindersPanelNoScroll(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTabChange(_Tab t) {
    setState(() => current = t);
  }

  List<Widget> _buildPaws() {
    return [
      _paw(top: 20, left: 20, size: 18, opacity: 0.08),
      _paw(top: 70, right: 40, size: 24, opacity: 0.09),
      _paw(top: 160, left: 40, size: 20, opacity: 0.07),
      _paw(top: 240, right: 90, size: 30, opacity: 0.08),
      _paw(top: 340, left: 25, size: 22, opacity: 0.09),
      _paw(top: 480, right: 30, size: 26, opacity: 0.08),
      _paw(bottom: 220, left: 40, size: 24, opacity: 0.07),
      _paw(bottom: 120, right: 50, size: 20, opacity: 0.08),
      _paw(bottom: 40, left: 120, size: 28, opacity: 0.09),
    ];
  }

  Widget _paw({
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
          angle: 0.35,
          child: Icon(
            Icons.pets_rounded,
            size: size,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<int?> _showPetPicker(
      BuildContext context, {
        required String title,
        required int initialIndex,
      }) {
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: const Color(0xFF0E2238),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (_) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'Cambiar mascota',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 18),

                ...List.generate(_pets.length, (i) {
                  final pet = _pets[i];
                  final selected = i == initialIndex;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white.withOpacity(0.06),
                      border: Border.all(
                        color: Colors.white.withOpacity(
                          selected ? 0.18 : 0.06,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.20),
                              Colors.white.withOpacity(0.06),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.pets,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        pet.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      subtitle: Text(
                        pet.meta,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.65),
                        ),
                      ),
                      trailing: selected
                          ? const Icon(
                        Icons.check_circle,
                        color: Color(0xFF8BE0BD),
                      )
                          : null,
                      onTap: () => Navigator.pop(context, i),
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Pet {
  final String name;
  final String meta;

  const _Pet({
    required this.name,
    required this.meta,
  });
}

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
    final inactive = Colors.white.withOpacity(.72);

    return Column(
      children: [
        const SizedBox(height: 2),

        if (showPetSwitch) ...[
          Center(
            child: _PetSwitchButton(
              label: 'Cambiar',
              onTap: onTapSwitch!,
            ),
          ),

          const SizedBox(height: 10),
        ],

        // AVATAR
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.20),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withOpacity(0.10),
                ),
              ),
              child: const Icon(
                Icons.pets_rounded,
                size: 54,
                color: Colors.white70,
              ),
            ),

            Positioned(
              bottom: 0,
              right: -2,
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2C7BE5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Text(
          pet.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
            height: 1,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          pet.meta,
          style: TextStyle(
            color: Colors.white.withOpacity(0.80),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(_Tab.reminders),
                child: Column(
                  children: [
                    Text(
                      'Recordatorios',
                      style: TextStyle(
                        color: current == _Tab.reminders
                            ? Colors.white
                            : inactive,
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(_Tab.social),
                child: Column(
                  children: [
                    Text(
                      'Social',
                      style: TextStyle(
                        color: current == _Tab.social
                            ? Colors.white
                            : inactive,
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 2.5,
          child: LayoutBuilder(
            builder: (context, c) {
              final half = c.maxWidth / 2;

              return Stack(
                children: [
                  Container(
                    color: Colors.white.withOpacity(0.12),
                  ),

                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    left: current == _Tab.reminders ? 0 : half,
                    width: half,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}

class _PetSwitchButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PetSwitchButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(.10),
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(.10),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.pets_rounded,
                size: 16,
                color: Colors.white,
              ),

              const SizedBox(width: 8),

              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(width: 4),

              const Icon(
                Icons.expand_more,
                size: 16,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RemindersPanelNoScroll extends StatelessWidget {
  const _RemindersPanelNoScroll();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hoy 15:00',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.65),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Próxima vacunación',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          const Text(
            'Próximas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.5,
            ),
          ),

          const SizedBox(height: 18),

          _GlassCard(
            child: Column(
              children: const [
                _ReminderRow(
                  icon: Icons.directions_walk,
                  text: 'Paseo (tarde)',
                  date: '5:00 p.m.',
                ),

                Divider(color: Colors.white24),

                _ReminderRow(
                  icon: Icons.medication,
                  text: 'Desparasitación',
                  date: '1 mayo',
                ),

                Divider(color: Colors.white24),

                _ReminderRow(
                  icon: Icons.bathtub,
                  text: 'Baño',
                  date: '20 mayo',
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const _TipsCTA(),

          const SizedBox(height: 20),

          SizedBox(
            height: 62,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67C26F),
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Añadir recordatorio',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;

  const _GlassCard({
    required this.child,
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
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.10),
                Colors.white.withOpacity(0.04),
              ],
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.10),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String date;

  const _ReminderRow({
    required this.icon,
    required this.text,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.80),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          Text(
            date,
            style: TextStyle(
              color: Colors.white.withOpacity(0.70),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TipsCTA extends StatelessWidget {
  const _TipsCTA();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _GlassCard(
        child: Row(
          children: [
            Icon(
              Icons.pets_rounded,
              color: Colors.white.withOpacity(0.85),
            ),

            const SizedBox(width: 14),

            const Expanded(
              child: Text(
                'Cuida mejor a tu mascota',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.75),
            ),
          ],
        ),
      ),
    );
  }
}