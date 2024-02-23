class Champion {
  final String champname;
  final String champdescription;
  final String champicon;
  final String type;
  final String role;

  Champion({
    required this.champname,
    required this.champdescription,
    required this.champicon,
    required this.type,
    required this.role,
  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    return Champion(
      champname: json['champname'],
      champdescription: json['champdescription'],
      champicon: json['champicon'],
      type: json['type'],
      role: json['role'],
    );
  }
}
