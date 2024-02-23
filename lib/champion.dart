class Champion {
  final String id;
  final String name;

  Champion({required this.id, required this.name});

  factory Champion.fromJson(Map<String, dynamic> json) {
    return Champion(
      id: json['id'],
      name: json['name'],
    );
  }
}
