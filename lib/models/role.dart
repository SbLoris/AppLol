class Role {
  final int id;
  final String name;
  final String iconPath;

  Role({
    required this.id,
    required this.name,
    required this.iconPath,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: int.parse(json['id'] as String),
      name: json['roles'] as String,
      iconPath: json['path_icon'] as String,
    );
  }
}
