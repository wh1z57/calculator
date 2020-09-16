import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

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
      debugShowCheckedModeBanner: false,
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
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '+',
    '3',
    '2',
    '1',
    '-',
    '0',
    '.',
    '=',
    'ANS',
  ];
  var userQuestion = '';
  var userAnswer = '';
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 20),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 40),
                  ),
                  alignment: Alignment.centerLeft,
                )
              ],
            ),
          )),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (buttons[index] == 'DEL') {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepOrange,
                        textcolor: Colors.white,
                      );
                    }
                    if (index == 0) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            userQuestion = '';
                            userAnswer = '';
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.green,
                        textcolor: Colors.white,
                      );
                    }
                    if (index == 18) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            answerEquals();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.black,
                        textcolor: Colors.white,
                      );
                    }
                    if (index == 19) {
                      return MyButton(
                        buttontapped: () {
                          setState(() {
                            answerANS();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.black,
                        textcolor: Colors.white,
                      );
                    }

                    if (isOperator(buttons[index])) {
                      return MyButton(
                          buttonText: buttons[index],
                          color: Colors.black,
                          textcolor: Colors.white,
                          buttontapped: () {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                          });
                    }
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.white,
                      textcolor: Colors.blueGrey,
                      buttontapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '+' || x == '-' || x == '*' || x == '/') {
      return true;
    }
    return false;
  }

  void answerEquals() {
    String equation = userQuestion;

    Parser p = Parser();
    Expression exp = p.parse(equation);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }

  void answerANS() {
    String prevAns = userAnswer;
    userQuestion = prevAns;
  }
}
