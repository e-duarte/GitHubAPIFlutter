class Repos {
  final String name;
  final String description;

  Repos({this.name, this.description});

  factory Repos.fromJson(Map<String, dynamic> json) {
    return Repos(
      name: json['name'],
      description: json['description'],
    );
  }
}
