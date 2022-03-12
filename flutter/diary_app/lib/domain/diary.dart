class Diary {

  Diary(this.userId, this.day, this.color, this.summary, this.text);

  String userId;
  String day;
  String color;
  String summary;
  String text;

  @override
  String toString() {

    return "Emotion: " + color + "\n" +
        "Summary: " + summary + "\n" +
        "Text: " + text + "\n";
  }
}