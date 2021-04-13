import 'package:flutter/material.dart';

import 'instruction.dart';

class UsingGrid extends StatefulWidget {
  @override
  _UsingGridState createState() => _UsingGridState();
}

class _UsingGridState extends State<UsingGrid> {
  TextEditingController _input = TextEditingController();
  String _result = "0";

  final List <String>key = [
    '^',
    '%',
    'DL',
    'AC',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total=',
                    style: TextStyle(fontSize: 30 ,color: Colors.grey),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        _result.toString(),
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              style: TextStyle(fontSize: 30),
              controller: _input,
              decoration: InputDecoration(
                  hintText: '0',
                  hintStyle: TextStyle(fontSize: 30,color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.grey))),
              // textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
            ),
            Expanded(
              flex: 3,
              child: Container(
                child: GridView.builder(
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  itemCount: key.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // height: 75,width: 75,
                      child: RaisedButton(
                        child: Text(key[index],style: TextStyle(fontSize: 30),),
                          highlightColor: Colors.orange,
                          highlightElevation: 30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                            0,
                          )),
                          onPressed: () {
                          var text=key[index];
                            Instruction ins=Instruction();
                            if (text == '=') {
                              setState(() {
                                _result = ins.isEqual(_input);
                              });
                            } else if (text == '+' ||
                                text == '-' ||
                                text == '*' ||
                                text == '/' ||
                                text == '%' ||
                                text == '^') {
                              setState(() {
                                _input=ins.isOperator(_input,text);
                              });
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

                          }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
