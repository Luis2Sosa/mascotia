import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/app_background.dart';
import '../social/social_panel.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Tab { reminders, social }

class _HomeScreenState extends State<HomeScreen> {
  _Tab current = _Tab.reminders;

  /// ─────────────────────────────────────────────
  /// MASCOTAS
  /// ─────────────────────────────────────────────
  final List<_Pet> _pets = const [
    _Pet(
      id: 1,
      name: 'Rocky',
      meta: '4 años • 31 kg',
    ),
    _Pet(
      id: 2,
      name: 'Luna',
      meta: '2 años • 5 kg',
    ),
    _Pet(
      id: 3,
      name: 'Coco',
      meta: '1 año • 9 kg',
    ),
  ];

  int _activePetIndex = 0;

  /// ─────────────────────────────────────────────
  /// RECORDATORIOS
  /// ─────────────────────────────────────────────
  final List<_Reminder> reminders = const [
    _Reminder(
      petId: 1,
      icon: Icons.medication,
      title: 'Vacunación anual',
      date: 'Hoy 3:00 PM',
    ),
    _Reminder(
      petId: 1,
      icon: Icons.directions_walk,
      title: 'Paseo de la tarde',
      date: '5:00 PM',
    ),
    _Reminder(
      petId: 1,
      icon: Icons.bathtub,
      title: 'Baño',
      date: '20 Mayo',
    ),

    /// Luna
    _Reminder(
      petId: 2,
      icon: Icons.restaurant,
      title: 'Comprar alimento',
      date: '22 Mayo',
    ),
    _Reminder(
      petId: 2,
      icon: Icons.medical_services,
      title: 'Chequeo veterinario',
      date: '28 Mayo',
    ),

    /// Coco
    _Reminder(
      petId: 3,
      icon: Icons.pets,
      title: 'Corte de uñas',
      date: '15 Junio',
    ),
  ];

  /// ─────────────────────────────────────────────
  /// POSTS
  /// ─────────────────────────────────────────────
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

    /// 🔥 FILTRAR RECORDATORIOS POR MASCOTA
    final petReminders = reminders
        .where((r) => r.petId == activePet.id)
        .toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackgroundBlobs(
        child: SafeArea(
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
                    onTapSwitch: _openPetPicker,
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
                  onTapSwitch: _openPetPicker,
                ),

                Expanded(
                  child: _RemindersPanel(
                    pet: activePet,
                    reminders: petReminders,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabChange(_Tab t) {
    setState(() => current = t);
  }

  Future<void> _openPetPicker() async {
    final i = await _showPetPicker(
      context,
      initialIndex: _activePetIndex,
    );

    if (i != null) {
      setState(() => _activePetIndex = i);
    }
  }

  Future<int?> _showPetPicker(
      BuildContext context, {
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

/// ─────────────────────────────────────────────
/// MODELO PET
/// ─────────────────────────────────────────────
class _Pet {
  final int id;
  final String name;
  final String meta;

  const _Pet({
    required this.id,
    required this.name,
    required this.meta,
  });
}

/// ─────────────────────────────────────────────
/// MODELO REMINDER
/// ─────────────────────────────────────────────
class _Reminder {
  final int petId;
  final IconData icon;
  final String title;
  final String date;

  const _Reminder({
    required this.petId,
    required this.icon,
    required this.title,
    required this.date,
  });
}

/// ─────────────────────────────────────────────
/// HEADER
/// ─────────────────────────────────────────────
class _HeaderAndTabs extends StatelessWidget {
  final _Pet pet;
  final _Tab current;
  final ValueChanged<_Tab> onChanged;
  final VoidCallback onTapSwitch;

  const _HeaderAndTabs({
    required this.pet,
    required this.current,
    required this.onChanged,
    required this.onTapSwitch,
  });

  @override
  Widget build(BuildContext context) {
    final inactive = Colors.white.withOpacity(.72);

    return Column(
      children: [
        const SizedBox(height: 8),

        Center(
          child: _PetSwitchButton(
            label: 'Cambiar mascota',
            onTap: onTapSwitch,
          ),
        ),

        const SizedBox(height: 14),

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

        const SizedBox(height: 14),

        Text(
          pet.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 42,
            fontWeight: FontWeight.w900,
            letterSpacing: -2,
          ),
        ),

        Text(
          pet.meta,
          style: TextStyle(
            color: Colors.white.withOpacity(.80),
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 26),

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

        const SizedBox(height: 18),
      ],
    );
  }
}

/// ─────────────────────────────────────────────
/// BOTÓN CAMBIAR MASCOTA
/// ─────────────────────────────────────────────
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

/// ─────────────────────────────────────────────
/// PANEL RECORDATORIOS
/// ─────────────────────────────────────────────
class _RemindersPanel extends StatelessWidget {
  final _Pet pet;
  final List<_Reminder> reminders;

  const _RemindersPanel({
    required this.pet,
    required this.reminders,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          if (reminders.isNotEmpty)
            _GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminders.first.date,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.65),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    reminders.first.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 24),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Próximos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(height: 18),

          _GlassCard(
            child: Column(
              children: reminders.map((r) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        r.icon,
                        color: Colors.white.withOpacity(.85),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Text(
                          r.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                      ),

                      Text(
                        r.date,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.70),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 22),

          SizedBox(
            height: 62,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF67C26F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Configurar recordatorios para ${pet.name}',
                style: const TextStyle(
                  fontSize: 17,
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

/// ─────────────────────────────────────────────
/// GLASS CARD
/// ─────────────────────────────────────────────
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
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}