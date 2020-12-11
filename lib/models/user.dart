class User {
  String username;
  String avatar;
  int count;

  User({
    this.username,
    this.avatar,
    this.count,
  });

  factory User.fromJson(json) {
    return User(
      username: json['login'],
      avatar: json['avatar_url'],
      count: json['total_count'],
    );
  }
}