class Report {
  final String title;
  final String url;

  Report({required this.title, required this.url});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      title: json['title'],
      url: json['url'],
    );
  }
}
