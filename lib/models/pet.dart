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
}