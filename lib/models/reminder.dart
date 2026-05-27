enum ReminderType {
  vaccine,
  walk,
  bath,
  medicine,
  food,
  vet,
}

class Reminder {
  final String id;
  final String petId;

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
}