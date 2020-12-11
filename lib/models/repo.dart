import './models.dart';

class Repo {
  String name;
  int watchers;
  int stars;
  int forks;
  int count;
  User user;
  DateTime createdAt;

  Repo({
    this.name,
    this.watchers,
    this.stars,
    this.forks,
    this.user,
    this.count,
    this.createdAt,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      name: json['name'],
      watchers: json['watchers_count'],
      stars: json['stargazers_count'],
      forks: json['forks'],
      user: User.fromJson(json['owner']),
      count: json['total_count'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}