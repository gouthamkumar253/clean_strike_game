import 'package:clean_strike/views/game_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Strike',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Clean Strike',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _tapped1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/carrom.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Opacity(
                    opacity: 0.95,
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      'Clean Strike',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 100),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Start Game',
                                style: TextStyle(
                                  color: _tapped1 ? Colors.blue : Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            color: _tapped1
                                ? Colors.white
                                : Colors.black.withOpacity(0.25),
                            onPressed: () {
                              setState(
                                () {
                                  _tapped1 = true;
                                },
                              );
                              Navigator.of(context)
                                  .push(
                                CupertinoPageRoute<Widget>(
                                  builder: (BuildContext context) =>
                                      const CleanStrike(
                                    gameType: 1,
                                  ),
                                ),
                              ).then(
                                (dynamic value) {
                                  setState(
                                    () {
                                      _tapped1 = false;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
