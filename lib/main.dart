import 'dart:math';

import 'package:flutter/material.dart';
import 'button.dart';
import 'dialogebox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GameButton> buttonList;
  var player1;
  var player2;
  var activeplayer;

  @override
  void initState() {
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();
    activeplayer = 1;
    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gameButtons;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = doInit();
    });
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activeplayer == 1) {
        gb.text = 'x';
        gb.bg = Colors.red;
        activeplayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = '0';
        gb.bg = Colors.black;
        activeplayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();

      if (winner == -1) {
        if (buttonList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => CustomDialog("Game Tied",
                  "press the reset button to start again", resetGame));
        } else {
          activeplayer == 2 ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = List();
    var list = List.generate(9, (i) => i + 1);
    for (var cellId in list) {
      if (!(player1.contains(cellId) || player2.contains(cellId))) {
        emptyCells.add(cellId);
      }
    }
    var r = Random();
    var randomIndex = r.nextInt(emptyCells.length - 1);
    var cellId = emptyCells[randomIndex];
    int i = buttonList.indexWhere((p) => p.id == cellId);
    playGame(buttonList[i]);
  }

  int checkWinner() {
    var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3))
      winner = 1;
    if (player2.contains(1) && player2.contains(2) && player2.contains(3))
      winner = 2;

    if (player1.contains(4) && player1.contains(5) && player1.contains(6))
      winner = 1;
    if (player2.contains(4) && player2.contains(5) && player2.contains(6))
      winner = 2;

    if (player1.contains(7) && player1.contains(8) && player1.contains(9))
      winner = 1;
    if (player2.contains(7) && player2.contains(8) && player2.contains(9))
      winner = 2;

    if (player1.contains(1) && player1.contains(4) && player1.contains(7))
      winner = 1;
    if (player2.contains(1) && player2.contains(4) && player2.contains(7))
      winner = 2;

    if (player1.contains(2) && player1.contains(5) && player1.contains(8))
      winner = 1;
    if (player2.contains(2) && player2.contains(5) && player2.contains(8))
      winner = 2;

    if (player1.contains(6) && player1.contains(3) && player1.contains(9))
      winner = 1;
    if (player2.contains(6) && player2.contains(3) && player2.contains(9))
      winner = 2;

    if (player1.contains(1) && player1.contains(5) && player1.contains(9))
      winner = 1;
    if (player2.contains(1) && player2.contains(5) && player2.contains(9))
      winner = 2;

    if (player1.contains(3) && player1.contains(5) && player1.contains(7))
      winner = 1;
    if (player2.contains(3) && player2.contains(5) && player2.contains(7))
      winner = 2;

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => CustomDialog("Player 1 won",
                "press the reset button to start again", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => CustomDialog("Player 2 won",
                "press the reset button to start again", resetGame));
      }
    }
    return winner;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: buttonList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 9,
                  mainAxisSpacing: 9),
              itemBuilder: (context, i) => SizedBox(
                width: 100,
                height: 100,
                child: RaisedButton(
                  padding: EdgeInsets.all(8),
                  onPressed: buttonList[i].enabled
                      ? () => playGame(buttonList[i])
                      : null,
                  child: Text(
                    buttonList[i].text,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: buttonList[i].bg,
                  disabledColor: buttonList[i].bg,
                ),
              ),
            ),
          ),
          RaisedButton(
            color: Colors.red,
            padding: EdgeInsets.all(20),
            onPressed: resetGame,
            child: Text(
              "Reset",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
