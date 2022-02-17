import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';

class MyLayoutPage extends StatelessWidget {
  MyLayoutPage({Key key}) : super(key: key);
  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print("on press");
          },
        ),
        title: Text("Calendar"),
        actions: [
          IconButton(
            onPressed: () {
              print("on press");
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        color: Color(0xffdfd4f4),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              child: SimpleFoldingCell(
                key: _foldingCellKey,
                frontWidget: _buildFrontWidget(),
                innerTopWidget: _buildInnerTopWidget(),
                innerBottomWidget: _buildInnerBottomWidget(),
                cellSize: Size(MediaQuery.of(context).size.width, 175),
                padding: EdgeInsets.all(10.0),
                animationDuration: Duration(milliseconds: 300),
                borderRadius: 10,
                onOpen: () => print('cell opened'),
                onClose: () => print('cell closed'),
              ),
            ),
            // list tile
          ],
        ),
      ),
    );
  }

  Widget _buildInnerBottomWidget() {
    return Container(
      color: Colors.white,
      child:   MaterialButton(
        onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
        child: Text(
          "Close",
        ),
        textColor: Colors.white,
        color: Colors.indigoAccent,
        splashColor: Colors.white.withOpacity(0.5),
      ),
    );
  }

  Widget _buildInnerTopWidget() {
    return Container(
      color: Color(0xff6a53a4),
      alignment: Alignment.center,
      child: Text(
        "TITLE",
        style: TextStyle(
            color: Color(0xFF2e282a),
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  Widget _buildFrontWidget() {
    return Container(
      color: Color(0xffdfd4f4),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xff6a53a4)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
            child: Text(
              "Open",
            ),
            textColor: Colors.white,
            color: Colors.indigoAccent,
            splashColor: Colors.white.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}
