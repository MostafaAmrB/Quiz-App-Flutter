class Question {
  int? id;
  String? question;
  List<String>? choices;
  int? rightChoice;
  int? scoreForQuestion = 10;

  Question({
    required this.id,
    required this.question,
    required this.choices,
    required this.rightChoice,
    this.scoreForQuestion,
  });
}
