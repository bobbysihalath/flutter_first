import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComplexLayout extends StatelessWidget {
  const ComplexLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _textString = 'Hello Word';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Test",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          Text(
            _textString,
            style: TextStyle(fontSize: 30.0),
          ),
          TextField(
            onChanged: (text){
              // _doSomething(text);
            },
          ),
        ],
      ),
    );
  }

  // void _doSomething(String text) {
  //   setState(() {
  //     _textString = text;
  //   });
  // }

  Widget myLayoutWidget() {
    return Container(
      margin: EdgeInsets.all(30.0),
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(),
      ),
      child: Text(
        "Hello word",
        style: TextStyle(fontSize: 30.0),
      ),
    );
  }

  Widget rowLayout() {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            color: Colors.green,
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.yellow,
          ),
        ),
      ],
    );
  }

  Widget stackLayout() {
    return Stack(
      // any unpositioned children (ie, our text) will be aligned at the bottom right
      alignment: Alignment.bottomRight,

      children: [
        // first child in the stack is on bottom
        Image.asset('assets/images/hey.png'), //            <--- image

        // second child in the stack
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Bobby Na Ja', //                              <--- text
            style: TextStyle(fontSize: 30),
          ),
        ),
      ],
    );
  }

  Widget columnLayout() {
    // wrap everything in a purple color container
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.purple[900],
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),

      // column of three rows
      child: Column(
        // this. make the column heght hug its content
        mainAxisSize: MainAxisSize.min,

        children: [
          // first row
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
              ),
              Text(
                'BEAMS',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          // second row (single item)
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 0,
            ),
            child: Text(
              'Send programmable push notifications to iOS and Android devices with delivery and open rate tracking built in.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),

          // Third row
          Row(
            children: [
              Text(
                'EXPLOE BEAMS',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.arrow_forward,color: Colors.green,),
              ),
            ],
          ),

        ],
      ),
    );
  }

}


