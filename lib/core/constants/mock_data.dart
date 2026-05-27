import '../../models/pet.dart';
import '../../models/reminder.dart';

/// ─────────────────────────────────────────
/// MASCOTAS DEMO
/// ─────────────────────────────────────────
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

/// ─────────────────────────────────────────
/// RECORDATORIOS DEMO
/// ─────────────────────────────────────────
final remindersMock = [
  /// ROCKY
  Reminder(
    id: 'r1',
    petId: 'rocky',
    title: 'Vacuna anual',
    description: 'Aplicar vacuna anual.',
    date: DateTime(2026, 5, 15, 15, 00),
    type: ReminderType.vaccine,
  ),

  Reminder(
    id: 'r2',
    petId: 'rocky',
    title: 'Paseo de la tarde',
    description: 'Salir al parque.',
    date: DateTime(2026, 5, 10, 17, 00),
    type: ReminderType.walk,
  ),

  Reminder(
    id: 'r3',
    petId: 'rocky',
    title: 'Comprar alimento',
    description: 'Comprar comida premium.',
    date: DateTime(2026, 5, 12, 12, 00),
    type: ReminderType.food,
  ),

  /// LUNA
  Reminder(
    id: 'r4',
    petId: 'luna',
    title: 'Baño y limpieza',
    description: 'Baño completo.',
    date: DateTime(2026, 5, 20, 10, 00),
    type: ReminderType.bath,
  ),

  Reminder(
    id: 'r5',
    petId: 'luna',
    title: 'Cita veterinaria',
    description: 'Chequeo general.',
    date: DateTime(2026, 5, 21, 9, 00),
    type: ReminderType.vet,
  ),

  /// COCO
  Reminder(
    id: 'r6',
    petId: 'coco',
    title: 'Desparasitación',
    description: 'Tomar medicamento.',
    date: DateTime(2026, 5, 22, 8, 00),
    type: ReminderType.medicine,
  ),

  Reminder(
    id: 'r7',
    petId: 'coco',
    title: 'Paseo mañanero',
    description: 'Caminar 30 minutos.',
    date: DateTime(2026, 5, 11, 7, 30),
    type: ReminderType.walk,
  ),
];