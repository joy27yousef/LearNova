import 'package:learn_nova/core/function/translationData.dart';

class SearchCoursesModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final String duration;
  final String difficulty_level;
  final String thumbnailurl;
  final double? price;
  final String teacher;
  final List<String> skills;

  SearchCoursesModel({
    required this.thumbnailurl,
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.difficulty_level,
    this.price,
    required this.teacher,
    required this.skills,
  });

  factory SearchCoursesModel.fromJson(Map<String, dynamic> json) {
    return SearchCoursesModel(
      id: json['id'],
      title: json['title'][translationData()] ?? '',
      description: json['description'][translationData()] ?? '',
      category: json['category']?['name']?[translationData()] ?? '',
      duration: json['duration'][translationData()] ?? '',
      price: null, //
      teacher: json['teacher']?['name'] ?? '',
      skills: (json['skills'] as List<dynamic>).map<String>((skill) {
        return skill['name']?['en'] ?? '';
      }).toList(),
      difficulty_level: json['difficulty_level'],
      thumbnailurl: json['thumbnail_url'],
    );
  }

  get thumbnailUrl => null;
}
