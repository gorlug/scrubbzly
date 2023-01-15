// import 'dart:html';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jira_game/items/forge_item_board.dart';
import 'package:jira_game/items/item_sorter.dart';
import 'package:jira_game/items/item_sorter_with_delay.dart';
import 'package:jira_game/items/flutter/sort_finished_widget.dart';
import 'package:jira_game/path_game/block.dart';
import 'package:jira_game/path_game/path_game.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

import 'items/item_board.dart';
import 'path_game/flutter/game_page.dart';
import 'path_game/flutter/show_game_widget.dart';
import 'path_game/flutter/show_item_list_widget.dart';

final getIt = GetIt.instance;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

final List<Item> initialItems = [];

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
            labelSmall: TextStyle(fontSize: 25),
            bodyMedium: TextStyle(fontSize: 20),
            labelLarge: TextStyle(fontSize: 21),
            titleMedium: TextStyle(fontSize: 20)),
      ),
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          minWidth: gameWidth,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(gameWidth, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: EdgeInsets.all(8.0),
                child: GamePage(),
              ),
            ),
      },
    );
  }
}
