import '../../models/pet.dart';
import '../../models/reminder.dart';

// ─────────────────────────────────────────────
// MASCOTAS DEMO
// ─────────────────────────────────────────────
const petsMock = [
  Pet(
    id: 1,
    name: 'Rocky',
    age: 4,
    breed: 'Golden Retriever',
    gender: 'Macho',
    type: 'Perro',
    weight: 31,
  ),
  Pet(
    id: 2,
    name: 'Luna',
    age: 2,
    breed: 'Siamés',
    gender: 'Hembra',
    type: 'Gato',
    weight: 5,
  ),
  Pet(
    id: 3,
    name: 'Coco',
    age: 1,
    breed: 'Poodle',
    gender: 'Macho',
    type: 'Perro',
    weight: 9,
  ),
];

// ─────────────────────────────────────────────
// RECORDATORIOS DEMO  (petId == Pet.id)
// ─────────────────────────────────────────────
final remindersMock = [
  // ROCKY (id: 1)
  Reminder(
    id: 'r1',
    petId: 1,
    title: 'Vacuna anual',
    description: 'Aplicar vacuna anual.',
    date: DateTime(2026, 5, 15, 15, 0),
    type: ReminderType.vaccine,
  ),
  Reminder(
    id: 'r2',
    petId: 1,
    title: 'Paseo de la tarde',
    description: 'Salir al parque.',
    date: DateTime(2026, 5, 31, 17, 0),
    type: ReminderType.walk,
  ),
  Reminder(
    id: 'r3',
    petId: 1,
    title: 'Baño',
    description: 'Baño completo en casa.',
    date: DateTime(2026, 5, 20, 10, 0),
    type: ReminderType.bath,
  ),

  // LUNA (id: 2)
  Reminder(
    id: 'r4',
    petId: 2,
    title: 'Baño y limpieza',
    description: 'Baño completo.',
    date: DateTime(2026, 5, 20, 10, 0),
    type: ReminderType.bath,
  ),
  Reminder(
    id: 'r5',
    petId: 2,
    title: 'Cita veterinaria',
    description: 'Chequeo general.',
    date: DateTime(2026, 5, 21, 9, 0),
    type: ReminderType.vet,
  ),

  // COCO (id: 3)
  Reminder(
    id: 'r6',
    petId: 3,
    title: 'Desparasitación',
    description: 'Tomar medicamento.',
    date: DateTime(2026, 5, 22, 8, 0),
    type: ReminderType.medicine,
  ),
  Reminder(
    id: 'r7',
    petId: 3,
    title: 'Paseo mañanero',
    description: 'Caminar 30 minutos.',
    date: DateTime(2026, 5, 31, 7, 30),
    type: ReminderType.walk,
  ),
];

// ─────────────────────────────────────────────
// HELPER: plan recomendado → recordatorios
// Convierte el plan de PetCarePlanScreen en
// Reminders reales cuando se registra una mascota.
// ─────────────────────────────────────────────
List<Reminder> buildPlanReminders({
  required int petId,
  required String petType,
}) {
  final now = DateTime.now();

  Reminder make({
    required String id,
    required String title,
    required String description,
    required ReminderType type,
    required DateTime date,
  }) {
    return Reminder(
      id: id,
      petId: petId,
      title: title,
      description: description,
      date: date,
      type: type,
    );
  }

  switch (petType) {
    case 'Perro':
      return [
        make(
          id: 'plan_${petId}_walk',
          title: 'Paseo diario',
          description: '2 veces al día.',
          type: ReminderType.walk,
          date: DateTime(now.year, now.month, now.day, 8, 0),
        ),
        make(
          id: 'plan_${petId}_food',
          title: 'Alimentación',
          description: '08:00 AM y 06:00 PM.',
          type: ReminderType.food,
          date: DateTime(now.year, now.month, now.day, 8, 0),
        ),
        make(
          id: 'plan_${petId}_water',
          title: 'Hidratación',
          description: 'Agua disponible todo el día.',
          type: ReminderType.water,
          date: DateTime(now.year, now.month, now.day, 7, 0),
        ),
        make(
          id: 'plan_${petId}_vaccine',
          title: 'Vacuna anual',
          description: 'Recordatorio automático.',
          type: ReminderType.vaccine,
          date: now.add(const Duration(days: 365)),
        ),
        make(
          id: 'plan_${petId}_bath',
          title: 'Baño',
          description: 'Cada 30 días.',
          type: ReminderType.bath,
          date: now.add(const Duration(days: 30)),
        ),
      ];

    case 'Gato':
      return [
        make(
          id: 'plan_${petId}_food',
          title: 'Alimentación',
          description: '2 veces al día.',
          type: ReminderType.food,
          date: DateTime(now.year, now.month, now.day, 8, 0),
        ),
        make(
          id: 'plan_${petId}_water',
          title: 'Agua fresca',
          description: 'Renovar diariamente.',
          type: ReminderType.water,
          date: DateTime(now.year, now.month, now.day, 7, 0),
        ),
        make(
          id: 'plan_${petId}_clean',
          title: 'Limpieza de arenero',
          description: 'Limpieza diaria.',
          type: ReminderType.clean,
          date: DateTime(now.year, now.month, now.day, 9, 0),
        ),
        make(
          id: 'plan_${petId}_vaccine',
          title: 'Vacuna anual',
          description: 'Control veterinario.',
          type: ReminderType.vaccine,
          date: now.add(const Duration(days: 365)),
        ),
      ];

    case 'Pez':
      return [
        make(
          id: 'plan_${petId}_food',
          title: 'Alimentación',
          description: '1-2 veces al día.',
          type: ReminderType.food,
          date: DateTime(now.year, now.month, now.day, 9, 0),
        ),
        make(
          id: 'plan_${petId}_water',
          title: 'Cambio de agua',
          description: 'Cada 7 días.',
          type: ReminderType.water,
          date: now.add(const Duration(days: 7)),
        ),
        make(
          id: 'plan_${petId}_clean',
          title: 'Limpieza de pecera',
          description: 'Cada 15 días.',
          type: ReminderType.clean,
          date: now.add(const Duration(days: 15)),
        ),
      ];

    case 'Ave':
      return [
        make(
          id: 'plan_${petId}_food',
          title: 'Alimentación',
          description: 'Diariamente.',
          type: ReminderType.food,
          date: DateTime(now.year, now.month, now.day, 8, 0),
        ),
        make(
          id: 'plan_${petId}_water',
          title: 'Agua limpia',
          description: 'Renovar diariamente.',
          type: ReminderType.water,
          date: DateTime(now.year, now.month, now.day, 8, 0),
        ),
        make(
          id: 'plan_${petId}_clean',
          title: 'Limpieza de jaula',
          description: 'Cada semana.',
          type: ReminderType.clean,
          date: now.add(const Duration(days: 7)),
        ),
      ];

    case 'Reptil':
      return [
        make(
          id: 'plan_${petId}_food',
          title: 'Alimentación',
          description: 'Según especie.',
          type: ReminderType.food,
          date: DateTime(now.year, now.month, now.day, 10, 0),
        ),
        make(
          id: 'plan_${petId}_other',
          title: 'Control de temperatura',
          description: 'Monitoreo diario.',
          type: ReminderType.other,
          date: DateTime(now.year, now.month, now.day, 8, 0),
        ),
        make(
          id: 'plan_${petId}_clean',
          title: 'Limpieza del terrario',
          description: 'Semanal.',
          type: ReminderType.clean,
          date: now.add(const Duration(days: 7)),
        ),
      ];

    default:
      return [
        make(
          id: 'plan_${petId}_food',
          title: 'Alimentación',
          description: 'Diaria.',
          type: ReminderType.food,
          date: DateTime(now.year, now.month, now.day, 9, 0),
        ),
        make(
          id: 'plan_${petId}_water',
          title: 'Hidratación',
          description: 'Diaria.',
          type: ReminderType.water,
          date: DateTime(now.year, now.month, now.day, 9, 0),
        ),
      ];
  }
}