class Spell {
  final int id;
  final String name;    // Convertir `id` en int en vérifiant d'abord si c'est une chaîne

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

  // Spell model
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
