import './models.dart';

class Issue {
  String title;
  String state;
  User user;
  DateTime lastUpdate;

  Issue({
    this.title,
    this.state,
    this.user,
    this.lastUpdate,
  });

  factory Issue.fromJson(Map<String, dynamic> json) {
    return Issue(
      title: json['title'],
      state: json['state'],
      user: User.fromJson(json['user']),
      lastUpdate: DateTime.parse(json['updated_at']),
    );
  }
}