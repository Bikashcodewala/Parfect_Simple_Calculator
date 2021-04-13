import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:untitled/usingGrid.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: UsingGrid(),
    );
  }
}

class nextPage extends StatefulWidget {
  @override
  _nextPageState createState() => _nextPageState();
}

class _nextPageState extends State<nextPage> {
  TextEditingController _input = TextEditingController();
  String _result = "0";
  double val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total=',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    _result.toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 30),
              controller: _input,
              decoration: InputDecoration(
                  hintText: '0',
                  hintStyle: TextStyle(fontSize: 30, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.grey))),
              // textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                getButton('^', context),
                getButton('%', context),
                getButton('DL', context),
                getButton('AC', context),
              ],
            ),
            Row(
              children: [
                getButton('7', context),
                getButton('8', context),
                getButton('9', context),
                getButton('/', context),
              ],
            ),
            Row(
              children: [
                getButton('4', context),
                getButton('5', context),
                getButton('6', context),
                getButton('*', context),
              ],
            ),
            Row(
              children: [
                getButton('1', context),
                getButton('2', context),
                getButton('3', context),
                getButton('-', context),
              ],
            ),
            Row(
              children: [
                getButton('0', context),
                getButton('.', context),
                getButton('=', context),
                getButton('+', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setOperator(text) {
    int l = _input.text.length;
    if (l < 1) {
      _input.text = '0';
    } else if (_input.text[l - 1] == '+' ||
        _input.text[l - 1] == '-' ||
        _input.text[l - 1] == '*' ||
        _input.text[l - 1] == '/' ||
        _input.text[l - 1] == '%' ||
        _input.text[l - 1] == '^') {
      _input.text = _input.text.substring(0, _input.text.length - 1);
      _input.text += text;
    } else {
      _input.text += text;
    }
  }

  Widget getButton(text, context) {
    return Expanded(
      child: Container(
        height: 75,
        width: 75,
        child: RaisedButton(
          highlightColor: Colors.orange,
          highlightElevation: 30,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
            0,
          )),
          onPressed: () {
            if (text == '=') {
              Parser p = new Parser();
              Expression exp = p.parse(_input.text);
              ContextModel cm = ContextModel();
              setState(() {
                _result = exp.evaluate(EvaluationType.REAL, cm).toString();
                // _input = exp.evaluate(EvaluationType.REAL, cm);
              });
            } else if (text == '+' ||
                text == '-' ||
                text == '*' ||
                text == '/' ||
                text == '%' ||
                text == '^') {
              setOperator(text);
            } else if (text == 'AC') {
              setState(() {
                _input.text = "";
                _result = "0";
              });
            } else if (text == 'DL') {
              _input.text = _input.text.length > 0
                  ? _input.text.substring(0, _input.text.length - 1)
                  : "";
            } else {
              setState(() {
                _input.text += text;
              });
            }
          },
          child: Text(
            text.toString(),
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
