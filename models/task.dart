class Task {
  final String title;
  final String? imagePath;

  Task({required this.title, this.imagePath});

  Map<String, dynamic> toJson() {
    return {'title': title, 'imagePath': imagePath};
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(title: json['title'], imagePath: json['imagePath']);
  }
}
