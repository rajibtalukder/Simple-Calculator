import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyStateApp(),
    );
  }
}
// there are a statefulwidget

class MyStateApp extends StatefulWidget {
  MyStateApp({Key? key}) : super(key: key);

  @override
  State<MyStateApp> createState() => _MyStateAppState();
}

class _MyStateAppState extends State<MyStateApp> {
  //varriables
  String inputField = '0';
  String result = '0';
  String expression = '';
  //functions
  void pressButton(String btnText) {
    setState(() {
      if (btnText == 'C') {
        inputField = '0';
        result = '0';
      } else if (btnText == 'D') {
        inputField = inputField.substring(
          0,
          inputField.length - 1,
        );
        if (inputField == '') {
          inputField = '0';
        }
      } else if (btnText == '') {
        inputField = '';
      } else if (btnText == '=') {
        expression = inputField;
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'Error';
        }
      } else {
        if (inputField == '0') {
          inputField = btnText;
        } else {
          inputField = inputField + btnText;
        }
      }
    });
  }

//there are a custom widget i have created
// This widget will make a beautiful button...

  Widget buildButton(String btnText, Color btnColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width * .2,
      margin: EdgeInsets.all(7),
      alignment: Alignment.center,
      child: FlatButton(
          color: btnColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(width: 1, color: Colors.grey)),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          onPressed: () => pressButton(btnText),
          child: Text(
            btnText,
            style: TextStyle(fontSize: 32, color: Colors.white),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Calculator',
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                inputField,
                style: TextStyle(fontSize: 40),
              ),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                result,
                style: TextStyle(fontSize: 50),
              ),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
            ),
            Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('C', Colors.teal),
                buildButton('D', Colors.teal),
                buildButton('/', Colors.teal),
                buildButton('*', Colors.teal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('7', Colors.black87),
                buildButton('8', Colors.black87),
                buildButton('9', Colors.black87),
                buildButton('-', Colors.teal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('4', Colors.black87),
                buildButton('5', Colors.black87),
                buildButton('6', Colors.black87),
                buildButton('+', Colors.teal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('1', Colors.black87),
                buildButton('2', Colors.black87),
                buildButton('3', Colors.black87),
                buildButton('%', Colors.teal),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton('.', Colors.black87),
                buildButton('0', Colors.black87),
                buildButton('00', Colors.black87),
                buildButton('=', Colors.orangeAccent),
              ],
            ),
          ],
        ));
  }
}
