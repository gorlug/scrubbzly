import 'dart:html';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jira_game/path_game/path_game.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    document.onContextMenu.listen((event) => event.preventDefault());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jira Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jira Game'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Hello World'),
            ],
          ),
          SizedBox(
              width: gameWidth,
              height: gameHeight,
              child: GameWidget(game: PathGame())),
          Row(
            children: [
              const Text('Hello World'),
            ],
          ),
        ],
      ),
    );
  }
}
