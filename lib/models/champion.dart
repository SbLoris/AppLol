import 'spell.dart';  // Importe la définition de la classe Spell

class Champion {
  final int id;
  final String name;
  // final String roles;
  // final String types;
  final String description;
  final String iconPath;
  List<Spell>? spells;

  Champion({
    required this.id,
    required this.name,
    // required this.roles,
    // required this.types,
    required this.description,
    required this.iconPath,
    this.spells,
  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    int id = int.parse(json['id'] as String);

    var spellsList = json['spells'] != null ? json['spells'] as List : [];
    List<Spell> spells = spellsList.isNotEmpty
        ? spellsList.map((i) => Spell.fromJson(i as Map<String, dynamic>)).toList()
        : [];

    return Champion(
      id: id,
      name: json['name'] as String,
      // roles: json['roles'] as String,
      // types: json['types'] as String,
      description: json['description'] as String,
      iconPath: json['path_icon'] as String,
      spells: spells,
    );
  }

}
