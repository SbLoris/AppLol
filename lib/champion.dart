class Champion {
  final String champname;
  final String champdescription;
  final String champicon;


  Champion({
    required this.champname,
    required this.champdescription,
    required this.champicon,

  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    return Champion(
      champname: json['name'],
      champdescription: json['description'],
      champicon: json['path_icon'],

    );
  }
}
