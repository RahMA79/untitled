class Question {
  String questionText;
  List answerList;

  Question(this.questionText, this.answerList);
}

class Answers {
  String answerText;
  bool isCorrect;

  Answers(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];
  list.add(
    Question(
      "Who is the owner of Flutter ?",
      [
        Answers('Nokia', false),
        Answers('Samsung', false),
        Answers('Google', true),
        Answers('Apple', false)
      ],
    ),
  );
  list.add(
    Question(
      "Who is the owner of Iphone ?",
      [
        Answers('Microsoft', false),
        Answers('Oppo', false),
        Answers('Google', false),
        Answers('Apple', true)
      ],
    ),
  );
  list.add(
    Question(
      "Youtube is ------- Platform .",
      [
        Answers('Music Sharing', false),
        Answers('Video Sharing', false),
        Answers('Live Streaming', false),
        Answers('All of the above', true)
      ],
    ),
  );
  list.add(Question("Do you love GDSC Benha ?", [
    Answers('True', true),
    Answers('False', false),
  ]));
  return list;
}
