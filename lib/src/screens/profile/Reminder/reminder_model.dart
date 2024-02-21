class Reminder{
  final String option;
  //final Timestamp time;
  final String text;

  Reminder({required this.option,required this.text});

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      option: json['option'],
      // time: json['time'],
      text: json['text'],
    );
  }
}