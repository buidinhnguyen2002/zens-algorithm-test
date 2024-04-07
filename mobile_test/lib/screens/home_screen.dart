import 'package:flutter/material.dart';
import 'package:mobile_test/database/joke_db.dart';
import 'package:mobile_test/models/joke.dart';
import 'package:mobile_test/utils/box_empty.dart';
import 'package:mobile_test/utils/constants.dart';
import 'package:mobile_test/widgets/banner.dart';
import 'package:mobile_test/widgets/text_button_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Joke>? jokes;
  final jokeDB = JokeDB();
  List<int>? jokesReadId;

  @override
  void initState() {
    super.initState();
    loadInitData();
  }

  void loadInitData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> ids = prefs.getStringList('readIds') != null
        ? prefs.getStringList('readIds')!.map((id) => int.parse(id)).toList()
        : [];
    setState(() {
      jokesReadId = ids;
    });
    fetchAndSetJokes(ids);
  }

  void addRead(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final newIds = [...?jokesReadId, id];
    prefs.setStringList('readIds', newIds.map((id) => id.toString()).toList());
    setState(() {
      jokesReadId = newIds;
    });
  }

  void fetchAndSetJokes(List<int> ids) {
    jokeDB.fetchAllJokes().then((jokes) {
      List<Joke> jokesNotRead =
          jokes.where((joke) => !ids.contains(joke.id)).toList();
      setState(() {
        this.jokes = jokesNotRead;
      });
    });
  }

  void vote(bool isFunny) async {
    int? jokeId = jokes![0].id;
    await jokeDB.update(jokeId, isFunny);
    addRead(jokeId!);
    final newIds = [...?jokesReadId, jokeId];
    fetchAndSetJokes(newIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetConstants.jokeLogo,
          width: 60,
          height: 60,
        ),
        actions: const [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Handicrafted by",
                    style: TextStyle(
                      color: AppColors.greyish,
                    ),
                  ),
                  Text(
                    "Jim HLS",
                    style: TextStyle(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
              BoxEmpty.sizeBox10,
              CircleAvatar(
                backgroundImage: AssetImage(
                  AssetConstants.avatar,
                ),
                radius: 25,
              ),
              BoxEmpty.sizeBox25,
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BoxEmpty.sizeBox15,
            const BannerApp(),
            BoxEmpty.sizeBox30,
            jokes != null && jokes!.isNotEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 30, bottom: 50),
                        child: Center(
                          child: jokes == null
                              ? const CircularProgressIndicator.adaptive()
                              : Text(
                                  jokes![0].content,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                        ),
                      ),
                      BoxEmpty.sizeBox30,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButtonCustom(
                            bgColor: Theme.of(context).colorScheme.secondary,
                            title: "This is Funny!",
                            onPress: () => vote(true),
                          ),
                          BoxEmpty.sizeBox30,
                          TextButtonCustom(
                            bgColor: Theme.of(context).colorScheme.primary,
                            title: "This is not Funny.",
                            onPress: () => vote(false),
                          ),
                        ],
                      ),
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Text(
                      "That's all the jokes for today! Come back another day!",
                      style: TextStyle(
                        color: AppColors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
            BoxEmpty.sizeBox30,
            const Divider(
              color: AppColors.greyish,
              height: 1,
              thickness: 0.3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "This appis created as part of HLsolutions program. The material con-tained on this website are provided for general information only and do not constitute any form of advice. HLS assusmes no responsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may arise from reliance on the infor-mation contained on this site.",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  BoxEmpty.sizeBox15,
                  Text(
                    "Copyright 2021 HLS",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppColors.greyish,
              height: 1,
              thickness: 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
