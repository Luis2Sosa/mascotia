import 'package:flutter/material.dart';
import '../../core/app_ui.dart';

/// ─────────────────────────────────────────────
/// MODELO RECORDATORIO
/// ─────────────────────────────────────────────
class Reminder {
  final int petId;
  final IconData icon;
  final String title;
  final String description;
  final String date;

  const Reminder({
    required this.petId,
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
  });
}

/// ─────────────────────────────────────────────
/// PANEL RECORDATORIOS
/// ─────────────────────────────────────────────
class RemindersPanel extends StatelessWidget {
  final String petName;
  final List<Reminder> reminders;
  final VoidCallback onAddReminder;

  const RemindersPanel({
    super.key,
    required this.petName,
    required this.reminders,
    required this.onAddReminder,
  });

  @override
  Widget build(BuildContext context) {
    final nextReminder =
    reminders.isNotEmpty ? reminders.first : null;

    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [
        // ─────────────────────────────────────────
        // CARD PRINCIPAL
        // ─────────────────────────────────────────
        if (nextReminder != null)
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nextReminder.date,
                  style: Txt.small,
                ),

                Gaps.s,

                Text(
                  nextReminder.title,
                  style: Txt.h2,
                ),

                Gaps.m,

                Text(
                  nextReminder.description,
                  style: Txt.body,
                ),

                Gaps.l,

                Row(
                  children: [
                    _MiniInfo(
                      icon: Icons.calendar_month_rounded,
                      label: nextReminder.date,
                    ),

                    Gaps.wm,

                    _MiniInfo(
                      icon: Icons.pets_rounded,
                      label: petName,
                    ),
                  ],
                ),
              ],
            ),
          ),

        Gaps.xl,

        // ─────────────────────────────────────────
        // TÍTULO
        // ─────────────────────────────────────────
        Text(
          'Recordatorios de $petName',
          style: Txt.h2,
        ),

        Gaps.m,

        // ─────────────────────────────────────────
        // LISTA
        // ─────────────────────────────────────────
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          child: reminders.isEmpty
              ? const _EmptyState()
              : Column(
            children: List.generate(
              reminders.length,
                  (index) {
                final reminder = reminders[index];

                return Column(
                  children: [
                    _ReminderRow(
                      icon: reminder.icon,
                      text: reminder.title,
                      date: reminder.date,
                      onEdit: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Editar recordatorio'),
                            content: Text(
                              'Modificar ${reminder.title}',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cerrar'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    if (index != reminders.length - 1)
                      const _GlassDivider(),
                  ],
                );
              },
            ),
          ),
        ),

        Gaps.xl,

        // ─────────────────────────────────────────
        // CARD TIPS
        // ─────────────────────────────────────────
        GestureDetector(
          onTap: () {},
          child: AppCard(
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(.16),
                        Colors.white.withOpacity(.05),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                  ),
                ),

                Gaps.wm,

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Consejos para tu mascota',
                        style: Txt.h3,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        'Descubre tips personalizados de cuidado.',
                        style: Txt.small,
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withOpacity(.65),
                ),
              ],
            ),
          ),
        ),

        Gaps.xl,

        // ─────────────────────────────────────────
        // BOTÓN
        // ─────────────────────────────────────────
        AppButton(
          label: 'Añadir recordatorio para $petName',
          icon: Icons.add_rounded,
          onPressed: onAddReminder,
        ),

        Gaps.l,
      ],
    );
  }
}

/// ─────────────────────────────────────────────
/// EMPTY STATE
/// ─────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Icon(
            Icons.event_busy_rounded,
            size: 42,
            color: Colors.white.withOpacity(.55),
          ),

          Gaps.m,

          Text(
            'No hay recordatorios',
            style: Txt.h3,
          ),

          const SizedBox(height: 4),

          Text(
            'Añade el primer recordatorio.',
            style: Txt.small,
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// FILA RECORDATORIO
/// ─────────────────────────────────────────────
class _ReminderRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String date;
  final VoidCallback? onEdit;

  const _ReminderRow({
    super.key,
    required this.icon,
    required this.text,
    required this.date,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(.14),
                  Colors.white.withOpacity(.05),
                ],
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),

          Gaps.wm,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: Txt.h3,
                ),

                const SizedBox(height: 3),

                Text(
                  'Recordatorio programado',
                  style: Txt.small,
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white.withOpacity(.08),
            ),
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),

          const SizedBox(width: 8),

          IconButton(
            onPressed: onEdit,
            icon: const Icon(
              Icons.edit_rounded,
              color: Colors.white,
              size: 20,
            ),
            tooltip: 'Editar recordatorio',
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// MINI INFO
/// ─────────────────────────────────────────────
class _MiniInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MiniInfo({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withOpacity(.08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.white.withOpacity(.85),
          ),

          const SizedBox(width: 8),

          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────
/// DIVIDER
/// ─────────────────────────────────────────────
class _GlassDivider extends StatelessWidget {
  const _GlassDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        height: 1,
        color: Colors.white.withOpacity(.08),
      ),
    );
  }
}