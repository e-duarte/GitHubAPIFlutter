class User {
  final String login;
  final String name;
  final String avatarUrl;
  final String reposUrl;

  User({this.login, this.name, this.avatarUrl, this.reposUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      reposUrl: json['repos_url'],
    );
  }
}
