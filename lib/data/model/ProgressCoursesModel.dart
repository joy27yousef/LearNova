import 'package:learn_nova/core/function/translationData.dart';

class CourseSection {
  final int id;
  final String title;
  final List<CourseVideo> videos;

  CourseSection({
    required this.id,
    required this.title,
    required this.videos,
  });

  factory CourseSection.fromJson(Map<String, dynamic> json) {
    return CourseSection(
      id: json['id'] ?? 0,
      title: json['title'][translationData()]?.toString() ?? '',
      videos: (json['videos'] as List? ?? [])
          .map((video) => CourseVideo.fromJson(video))
          .toList(),
    );
  }
}

class CourseVideo {
  final int id;
  final String title;
  final String videoUrl;

  CourseVideo({
    required this.id,
    required this.title,
    required this.videoUrl,
  });

  factory CourseVideo.fromJson(Map<String, dynamic> json) {
    return CourseVideo(
      id: json['id'] ?? 0,
      title: json['title'][translationData()]?.toString() ?? '',
      videoUrl: json['videoUrl']?.toString() ?? '',
    );
  }
}
