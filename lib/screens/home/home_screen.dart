import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_background.dart';
import '../../core/constants/mock_data.dart';
import '../../models/pet.dart';
import '../../models/reminder.dart';
import '../reminders/reminders_panel.dart';
import '../social/social_panel.dart';

class HomeScreen extends StatefulWidget {
  // Cuando se llega desde PetCarePlanScreen se pasan estos datos
  final String?        newPetName;
  final String?        newPetType;
  final int?           newPetAge;
  final double?        newPetWeight;
  final int?           newPetId;
  final List<Reminder>? planReminders;

  const HomeScreen({
    super.key,
    this.newPetName,
    this.newPetType,
    this.newPetAge,
    this.newPetWeight,
    this.newPetId,
    this.planReminders,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum _Tab { reminders, social }

class _HomeScreenState extends State<HomeScreen> {
  _Tab _tab = _Tab.reminders;

  late List<Pet>      _pets;
  late List<Reminder> _reminders;
  int _activePetIndex = 0;

  // Posts de la red social
  final List<Post> _posts = const [
    Post(id: 1, author: 'Rocky', text: '¡Cumplí 2 años! 🎉',
        imageAsset: 'assets/images/feed1.jpg'),
    Post(id: 2, author: 'Luna',  text: 'Fui al parque hoy 🐕🌳',
        imageAsset: 'assets/images/feed2.jpg'),
  ];

  final Set<int> _liked = {1};

  @override
  void initState() {
    super.initState();

    // Copia mutable de las mascotas mock
    _pets      = List<Pet>.from(petsMock);
    _reminders = List<Reminder>.from(remindersMock);

    // Si se registró una mascota nueva, agregarla con su plan
    if (widget.newPetName != null && widget.newPetId != null) {
      final newPet = Pet(
        id:     widget.newPetId!,
        name:   widget.newPetName!,
        type:   widget.newPetType ?? 'Otro',
        breed:  '',
        age:    widget.newPetAge ?? 0,
        weight: widget.newPetWeight ?? 0,
        gender: '',
      );

      _pets.add(newPet);
      _activePetIndex = _pets.length - 1;

      if (widget.planReminders != null) {
        _reminders.addAll(widget.planReminders!);
      }
    }
  }

  // ─────────────────────────────────────────────
  // Helpers
  // ─────────────────────────────────────────────
  Pet get _activePet => _pets[_activePetIndex];

  List<Reminder> get _petReminders =>
      _reminders.where((r) => r.petId == _activePet.id).toList();

  void _updateReminder(Reminder updated) {
    setState(() {
      final idx = _reminders.indexWhere((r) => r.id == updated.id);
      if (idx != -1) _reminders[idx] = updated;
    });
  }

  Future<void> _openPetPicker() async {
    final i = await _showPetPicker(context, initialIndex: _activePetIndex);
    if (i != null) setState(() => _activePetIndex = i);
  }

  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBackgroundBlobs(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
            child: _tab == _Tab.social
                ? NestedScrollView(
              headerSliverBuilder: (_, __) => [
                SliverToBoxAdapter(
                  child: _HeaderAndTabs(
                    pet: _activePet,
                    tab: _tab,
                    onTabChanged: (t) => setState(() => _tab = t),
                    onTapSwitch: _openPetPicker,
                  ),
                ),
              ],
              body: SocialPanel(
                posts: _posts,
                petNames: _pets.map((p) => p.name).toList(),
                isLiked: (id) => _liked.contains(id),
                onToggleLike: (id) {
                  setState(() {
                    _liked.contains(id)
                        ? _liked.remove(id)
                        : _liked.add(id);
                  });
                },
              ),
            )
                : Column(
              children: [
                _HeaderAndTabs(
                  pet: _activePet,
                  tab: _tab,
                  onTabChanged: (t) => setState(() => _tab = t),
                  onTapSwitch: _openPetPicker,
                ),
                Expanded(
                  child: RemindersPanel(
                    petName: _activePet.name,
                    reminders: _petReminders,
                    onAddReminder: () {
                      // TODO: abrir pantalla de añadir recordatorio
                    },
                    onReminderUpdated: _updateReminder,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // Bottom sheet selector de mascotas
  // ─────────────────────────────────────────────
  Future<int?> _showPetPicker(
      BuildContext context, {
        required int initialIndex,
      }) {
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: const Color(0xFF0E2238),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => SafeArea(
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
                final pet      = _pets[i];
                final selected = i == initialIndex;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white.withOpacity(0.06),
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(selected ? 0.18 : 0.06),
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
                      child: const Icon(Icons.pets, color: Colors.white),
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
                          color: Colors.white.withOpacity(0.65)),
                    ),
                    trailing: selected
                        ? const Icon(Icons.check_circle,
                        color: Color(0xFF8BE0BD))
                        : null,
                    onTap: () => Navigator.pop(context, i),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// HEADER + TABS
// ─────────────────────────────────────────────
class _HeaderAndTabs extends StatelessWidget {
  final Pet              pet;
  final _Tab             tab;
  final ValueChanged<_Tab> onTabChanged;
  final VoidCallback     onTapSwitch;

  const _HeaderAndTabs({
    required this.pet,
    required this.tab,
    required this.onTabChanged,
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

        // Avatar
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
            border:
            Border.all(color: Colors.white.withOpacity(0.10)),
          ),
          child: pet.image != null
              ? ClipOval(
              child: Image.asset(pet.image!, fit: BoxFit.cover))
              : const Icon(Icons.pets_rounded,
              size: 54, color: Colors.white70),
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

        // Tabs
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(_Tab.reminders),
                child: Text(
                  'Recordatorios',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: tab == _Tab.reminders
                        ? Colors.white
                        : inactive,
                    fontWeight: FontWeight.w800,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(_Tab.social),
                child: Text(
                  'Social',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: tab == _Tab.social ? Colors.white : inactive,
                    fontWeight: FontWeight.w800,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Indicador
        SizedBox(
          height: 2.5,
          child: LayoutBuilder(
            builder: (context, c) {
              final half = c.maxWidth / 2;
              return Stack(
                children: [
                  Container(color: Colors.white.withOpacity(0.12)),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOut,
                    left: tab == _Tab.reminders ? 0 : half,
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

// ─────────────────────────────────────────────
// BOTÓN CAMBIAR MASCOTA
// ─────────────────────────────────────────────
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
              horizontal: 16, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.pets_rounded,
                  size: 16, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Cambiar mascota',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.expand_more,
                  size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}