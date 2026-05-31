class Pet {
  final int id;
  final String name;
  final String type;
  final String breed;
  final int age;
  final double weight;
  final String gender;
  final String? image;

  const Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.age,
    required this.weight,
    required this.gender,
    this.image,
  });

  /// Utilidad para crear copias modificadas
  Pet copyWith({
    int? id,
    String? name,
    String? type,
    String? breed,
    int? age,
    double? weight,
    String? gender,
    String? image,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      image: image ?? this.image,
    );
  }

  /// Texto corto para mostrar en UI: "4 años • 31 kg"
  String get meta {
    final ageStr = age == 1 ? '1 año' : '$age años';
    final weightStr = weight == weight.truncateToDouble()
        ? '${weight.toInt()} kg'
        : '$weight kg';
    return '$ageStr • $weightStr';
  }
}