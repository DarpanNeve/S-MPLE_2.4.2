class Reminder{
  final String option;
  final String time;
  final String text;

  Reminder({required this.option,required this.time,required this.text});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      option: json['option'],
      time: json['time'],
      text: json['text'],
    );
  }
}