import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool firstRender = true;
  double blueHeight = 100;
  double redHeight = 100;
  double winningLimt = 200;
  double difficulty = 5;
  @override
  Widget build(BuildContext context) {
    if (firstRender) {
      double height = MediaQuery.of(context).size.height;
      setState(() {
        winningLimt = height - 5;
        redHeight = height / 2;
        blueHeight = height / 2;
        firstRender = false;
      });
    }
    void onRedClick() {
      if (redHeight > winningLimt) {
        showAlertDialog(context, "Red Won");
      } else {
        setState(() {
          redHeight += difficulty;
          blueHeight -= difficulty;
          print(redHeight);
        });
      }
    }

    void onBlueClick() {
      if (blueHeight > winningLimt) {
        showAlertDialog(context, "Blue Won");
      } else {
        setState(() {
          redHeight -= difficulty;
          blueHeight += difficulty;
        });
      }
    }

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Column(children: [
        GestureDetector(
          onTap: () => {onRedClick()},
          child: Container(
            height: redHeight,
            color: Colors.red,
          ),
        ),
        GestureDetector(
          onTap: () => {onBlueClick()},
          child: Container(
            height: blueHeight,
            color: Colors.blue,
          ),
        )
      ]),
    );
  }

  showAlertDialog(BuildContext context, String title) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: Text("Continue"),
      onPressed: () {
        setState(() {
          firstRender = true;
        });
        Navigator.pop(context, true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text("Click Continue to restart game!"),
      actions: [
        remindButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
