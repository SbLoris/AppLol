class Type {
  final int id;
  final String name;
  final String iconPath;

  Type({
    required this.id,
    required this.name,
    required this.iconPath,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      id: int.parse(json['id'] as String),
      name: json['types'] as String,
      iconPath: json['path_icon'] as String,
    );
  }
}
