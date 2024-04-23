class Champion {
  final int id;
  final String name;
  final String description;
  final String iconPath;
  List<Spell>? spells;

  Champion({
    required this.id,
    required this.name,
    required this.description,
    required this.iconPath,
    this.spells,
  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    var spellsList = json['spells'] as List;
    List<Spell> spells = spellsList.map((i) => Spell.fromJson(i)).toList();

    return Champion(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconPath: json['path_icon'],
      spells: spells,
    );
  }
}

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

  factory Spell.fromJson(Map<String, dynamic> json) {
    return Spell(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      touch: json['touch'],
      iconPath: json['path_icon'],
      championsId: json['champions_id']
    );
  }
}
