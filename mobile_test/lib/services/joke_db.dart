import 'package:sqflite/sqflite.dart';
import './database_service.dart';
import '../models/joke.dart';

class JokeDB {
  static const tableName = 'jokes';
  final List<Joke> _initData = [
    Joke(
        content:
            "A child asked his father, \"How were people born?\" So his father said, \"Adam and Eve made babies, then their babies became adults and made babies, and so on.\"The child then went to his mother, asked her the same question and she told him, \"We were monkeys then we evolved to become like we are now.\"The child ran back to his father and said, \"You lied to me!\" His father replied, \"No, your mom was talking about her side of the family.\""),
    Joke(
        content:
            "Teacher: \"Kids,what does the chicken give you?\" Student: \"Meat!\" Teacher: \"Very good! Now what does the pig give you?\" Student: \"Bacon!\". Teacher: \"Great! And what does the fat cow give you?\" Student: \"Homework!\""),
    Joke(
        content:
            "The teacher asked Jimmy, \"Why is your cat at school today Jimmy?\" Jimmy replied crying, \"Because I heard my daddy tell my mommy, 'I am going to eat that pussy once Jimmy leaves for school today!'\""),
    Joke(
        content:
            "A housewife, an accountant and a lawyer were asked \"How much is 2+2?\" The housewife replies: \"Four!\". The accountant says: \"I think it's either 3 or 4. Let me run those figures through my spreadsheet one more time.\" The lawyer pulls the drapes, dims the lights and asks in a hushed voice, \"How much do you want it to be?\""),
  ];
  Future<void> createTable(Database database) async {
    await database.execute(
        "CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, isFunny INTEGER DEFAULT 0)");
  }

  Future<int> create(Database database, String content) async {
    return await database
        .rawInsert('INSERT INTO $tableName (content) VALUES (?)', [content]);
  }

  Future<void> insertInitData(Database database) async {
    _initData.forEach((joke) {
      create(database, joke.content);
    });
  }

  Future<List<Joke>> fetchAllJokes() async {
    final database = await DatabaseService().database;
    final List<Map<String, dynamic>> jokes = await database.query(
      tableName,
    );
    return jokes.map((joke) => Joke.fromMap(joke)).toList();
  }

  Future<int> update(int? id, bool isFunny) async {
    final database = await DatabaseService().database;
    return await database.update(tableName, {'isFunny': isFunny ? 1 : 0},
        where: 'id = ?',
        conflictAlgorithm: ConflictAlgorithm.rollback,
        whereArgs: [id]);
  }
}
