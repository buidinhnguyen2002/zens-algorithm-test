class Joke {
  int? id;
  String content;
  bool isFunny;
  Joke({required this.content, this.isFunny = false, this.id});
  Map<String, dynamic> toMap() {
    return {
      'content': content,
    };
  }

  factory Joke.fromMap(Map<String, dynamic> map) {
    return Joke(
      id: int.parse(map['id'].toString()),
      content: map['content'],
      isFunny: map['isFunny'] == 1,
    );
  }
}
