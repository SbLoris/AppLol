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
      id: int.parse(json['id']),
      name: json['name'] ?? "", // Gérer les valeurs nulles
      description: json['description'] ?? "", // Gérer les valeurs nulles
      touch: json['touch'] ?? "",
      iconPath: json['path_icon'] ?? "",
      championsId: int.parse(json['champions_id']),
    );
  }
}
