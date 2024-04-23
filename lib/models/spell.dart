// Define the Spell model class

class Spell {
  final int id;
  final String name;
  final String description;
  final String touch;
  final String iconPath;
  final int championsId;

  Spell({
    required this.id,
    required this.name,
    required this.description,
    required this.touch,
    required this.iconPath,
    required this.championsId,
  });

  // Factory constructor to create a Spell from JSON data
  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      touch: json['touch'] as String,
      iconPath: json['path_icon'] as String,
      championsId: json['champions_id'] as int,
    );
  }
}
