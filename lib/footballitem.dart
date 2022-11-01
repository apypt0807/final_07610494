import 'dart:convert';

class FootballItem {
  final int id;
  final String team;
  final int group;
  final String image;
  final int voteCount;

  FootballItem({
    required this.id,
    required this.team,
    required this.group,
    required this.image,
    required this.voteCount,
  });

  factory FootballItem.fromJson(Map<String, dynamic> json) {
    return FootballItem(
      id: json['id'],
      team: json['team'],
      group: json['group'],
      image: json['image'],
      voteCount:json['voteCount'],
    );
  }

  // named constructor
  FootballItem.fromJson2(Map<String, dynamic> json)
      : id = json['id'],
        team = json['team'],
        group = json['group'],
        image = json['image'],
        voteCount = json['voteCount'];

}