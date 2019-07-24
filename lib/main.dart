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
  bool tapped1 = false;
  bool tapped2 = false;



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
                    child: Container(
//                      decoration: const BoxDecoration(
//                        gradient: LinearGradient(
//                          begin: Alignment.topLeft,
//                          end: Alignment.bottomRight,
//                          colors: const <Color>[
//                            Color(0xFF0084E9),
//                            Color(0xFF7BCDC8),
//                          ],
//                        ),
//                      ),
                        ),
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
                    style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 100),
                  ),),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Manual',
                                  style: TextStyle(
                                    color:
                                        tapped1 ? Colors.blue : Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'ProximaNovaSemiBold',
                                  ),
                                ),
                              ),
                              color: tapped1
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.25),
                              onPressed: () {
                                setState(
                                  () {
                                    tapped1 = true;
                                    tapped2 = false;
                                  },
                                );
                                Navigator.of(context).push(
                                  CupertinoPageRoute<Widget>(
                                    builder: (BuildContext context) =>
                                        const CleanStrike(
                                      gameType: 1,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Automatic',
                                  style: TextStyle(
                                    color:
                                        tapped2 ? Colors.blue : Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'ProximaNovaSemiBold',
                                  ),
                                ),
                              ),
                              color: tapped2
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.25),
                              onPressed: () {
                                setState(
                                  () {
                                    tapped2 = true;
                                    tapped1 = false;
                                  },
                                );
                                Navigator.of(context).push(
                                  CupertinoPageRoute<Widget>(
                                    builder: (BuildContext context) =>
                                        const CleanStrike(
                                      gameType: 2,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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
