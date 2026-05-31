import 'package:flutter/material.dart';

enum ReminderType {
  vaccine,
  walk,
  bath,
  medicine,
  food,
  vet,
  water,
  clean,
  other,
}

class Reminder {
  final String id;
  final int petId; // int para coincidir con Pet.id
  final String title;
  final String description;
  final DateTime date;
  final ReminderType type;
  final bool completed;

  const Reminder({
    required this.id,
    required this.petId,
    required this.title,
    required this.description,
    required this.date,
    required this.type,
    this.completed = false,
  });

  Reminder copyWith({
    String? id,
    int? petId,
    String? title,
    String? description,
    DateTime? date,
    ReminderType? type,
    bool? completed,
  }) {
    return Reminder(
      id: id ?? this.id,
      petId: petId ?? this.petId,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      type: type ?? this.type,
      completed: completed ?? this.completed,
    );
  }

  // ─────────────────────────────────────────────
  // Helpers de UI — ícono e etiqueta de fecha
  // ─────────────────────────────────────────────

  IconData get icon {
    switch (type) {
      case ReminderType.vaccine:
        return Icons.vaccines_rounded;
      case ReminderType.walk:
        return Icons.directions_walk_rounded;
      case ReminderType.bath:
        return Icons.bathtub_rounded;
      case ReminderType.medicine:
        return Icons.medication_rounded;
      case ReminderType.food:
        return Icons.restaurant_rounded;
      case ReminderType.vet:
        return Icons.medical_services_rounded;
      case ReminderType.water:
        return Icons.water_drop_rounded;
      case ReminderType.clean:
        return Icons.cleaning_services_rounded;
      case ReminderType.other:
        return Icons.event_rounded;
    }
  }

  /// Texto corto para la UI: "Hoy 3:00 PM", "20 Mayo", etc.
  String get dateLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final reminderDay = DateTime(date.year, date.month, date.day);
    final hour = _formatHour(date);

    if (reminderDay == today) return 'Hoy $hour';

    final tomorrow = today.add(const Duration(days: 1));
    if (reminderDay == tomorrow) return 'Mañana $hour';

    const months = [
      '', 'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
    ];
    return '${date.day} ${months[date.month]}';
  }

  String _formatHour(DateTime dt) {
    final h = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
    final m = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }
}