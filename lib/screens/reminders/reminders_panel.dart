import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/app_ui.dart';
import '../../models/reminder.dart';

/// Panel de recordatorios que se muestra en el HomeScreen.
/// Recibe la lista ya filtrada por mascota.
class RemindersPanel extends StatefulWidget {
  final String petName;
  final List<Reminder> reminders;

  /// Callback para añadir un recordatorio nuevo
  final VoidCallback onAddReminder;

  /// Callback cuando el usuario edita un recordatorio
  final ValueChanged<Reminder> onReminderUpdated;

  const RemindersPanel({
    super.key,
    required this.petName,
    required this.reminders,
    required this.onAddReminder,
    required this.onReminderUpdated,
  });

  @override
  State<RemindersPanel> createState() => _RemindersPanelState();
}

class _RemindersPanelState extends State<RemindersPanel> {
  // ─────────────────────────────────────────────
  // Editar recordatorio
  // ─────────────────────────────────────────────
  Future<void> _openEdit(Reminder reminder) async {
    final titleCtrl = TextEditingController(text: reminder.title);
    final descCtrl  = TextEditingController(text: reminder.description);

    final result = await showDialog<Reminder>(
      context: context,
      builder: (ctx) => _EditReminderDialog(
        reminder: reminder,
        titleCtrl: titleCtrl,
        descCtrl: descCtrl,
      ),
    );

    if (result != null) {
      widget.onReminderUpdated(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sorted = [...widget.reminders]
      ..sort((a, b) => a.date.compareTo(b.date));

    final next = sorted.isNotEmpty ? sorted.first : null;

    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: [

        // ── Próximo recordatorio destacado ──
        if (next != null) ...[
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF58D36E).withValues(alpha: .15),
                      ),
                      child: Icon(next.icon,
                          color: const Color(0xFF58D36E), size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(next.title, style: Txt.h3),
                          const SizedBox(height: 3),
                          Text(next.dateLabel, style: Txt.small),
                        ],
                      ),
                    ),
                    _editButton(() => _openEdit(next)),
                  ],
                ),
                Gaps.m,
                Text(next.description, style: Txt.body),
                Gaps.l,
                Row(
                  children: [
                    _MiniInfo(
                      icon: Icons.calendar_month_rounded,
                      label: next.dateLabel,
                    ),
                    Gaps.wm,
                    _MiniInfo(
                      icon: Icons.pets_rounded,
                      label: widget.petName,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gaps.xl,
        ],

        // ── Título lista ──
        Text('Próximos', style: Txt.h2),
        Gaps.m,

        // ── Lista todos los recordatorios ──
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: sorted.isEmpty
              ? const _EmptyState()
              : Column(
            children: List.generate(sorted.length, (index) {
              final r = sorted[index];
              return Column(
                children: [
                  _ReminderRow(
                    reminder: r,
                    onEdit: () => _openEdit(r),
                  ),
                  if (index != sorted.length - 1)
                    const _GlassDivider(),
                ],
              );
            }),
          ),
        ),

        Gaps.xl,

        // ── Consejos ──
        AppCard(
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: .16),
                      Colors.white.withValues(alpha: .05),
                    ],
                  ),
                ),
                child: const Icon(Icons.auto_awesome_rounded,
                    color: Colors.white),
              ),
              Gaps.wm,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Consejos para tu mascota', style: Txt.h3),
                    const SizedBox(height: 4),
                    Text('Descubre tips personalizados de cuidado.',
                        style: Txt.small),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: Colors.white.withValues(alpha: .65)),
            ],
          ),
        ),

        Gaps.xl,

        // ── Botón añadir ──
        AppButton(
          label: 'Configurar recordatorios para ${widget.petName}',
          icon: Icons.add_rounded,
          onPressed: widget.onAddReminder,
        ),

        Gaps.l,
      ],
    );
  }

  Widget _editButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withValues(alpha: .08),
        ),
        child: const Icon(Icons.edit_rounded,
            color: Colors.white, size: 18),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// DIÁLOGO DE EDICIÓN
// ─────────────────────────────────────────────
class _EditReminderDialog extends StatefulWidget {
  final Reminder reminder;
  final TextEditingController titleCtrl;
  final TextEditingController descCtrl;

  const _EditReminderDialog({
    required this.reminder,
    required this.titleCtrl,
    required this.descCtrl,
  });

  @override
  State<_EditReminderDialog> createState() => _EditReminderDialogState();
}

class _EditReminderDialogState extends State<_EditReminderDialog> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.reminder.date;
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 3)),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );
    if (time == null) return;

    setState(() {
      selectedDate = DateTime(
        date.year, date.month, date.day,
        time.hour, time.minute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0E2238),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Editar recordatorio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 20),

            _DialogField(
              controller: widget.titleCtrl,
              hint: 'Título',
              icon: Icons.title_rounded,
            ),

            const SizedBox(height: 14),

            _DialogField(
              controller: widget.descCtrl,
              hint: 'Descripción',
              icon: Icons.notes_rounded,
              maxLines: 2,
            ),

            const SizedBox(height: 14),

            // Fecha / hora
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white.withValues(alpha: .06),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: .08)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_rounded,
                        color: Colors.white.withValues(alpha: .65),
                        size: 20),
                    const SizedBox(width: 12),
                    Text(
                      widget.reminder
                          .copyWith(date: selectedDate)
                          .dateLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.edit_calendar_rounded,
                        color: Colors.white.withValues(alpha: .45),
                        size: 18),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                          color: Colors.white.withValues(alpha: .65)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF58D36E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      final updated = widget.reminder.copyWith(
                        title:       widget.titleCtrl.text.trim(),
                        description: widget.descCtrl.text.trim(),
                        date:        selectedDate,
                      );
                      Navigator.pop(context, updated);
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;

  const _DialogField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withValues(alpha: .06),
        border: Border.all(color: Colors.white.withValues(alpha: .08)),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle:
          TextStyle(color: Colors.white.withValues(alpha: .38)),
          prefixIcon: Icon(icon,
              color: Colors.white.withValues(alpha: .55), size: 20),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 16, horizontal: 4),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// WIDGETS INTERNOS
// ─────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: Column(
        children: [
          Icon(Icons.event_busy_rounded,
              size: 42,
              color: Colors.white.withValues(alpha: .55)),
          Gaps.m,
          const Text('No hay recordatorios', style: Txt.h3),
          const SizedBox(height: 4),
          Text('Añade el primer recordatorio.', style: Txt.small),
        ],
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onEdit;

  const _ReminderRow({
    required this.reminder,
    required this.onEdit,
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
                  Colors.white.withValues(alpha: .14),
                  Colors.white.withValues(alpha: .05),
                ],
              ),
            ),
            child: Icon(reminder.icon, color: Colors.white, size: 22),
          ),
          Gaps.wm,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(reminder.title, style: Txt.h3),
                const SizedBox(height: 3),
                Text(reminder.description, style: Txt.small),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white.withValues(alpha: .08),
            ),
            child: Text(
              reminder.dateLabel,
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
            icon: const Icon(Icons.edit_rounded,
                color: Colors.white, size: 20),
            tooltip: 'Editar recordatorio',
          ),
        ],
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: .08),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 16,
              color: Colors.white.withValues(alpha: .85)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _GlassDivider extends StatelessWidget {
  const _GlassDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Container(
        height: 1,
        color: Colors.white.withValues(alpha: .08),
      ),
    );
  }
}