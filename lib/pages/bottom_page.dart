import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/widgets/bottom_bar/fab_bottom_app_bar.dart';
import 'package:flutter_catalog/widgets/bottom_bar/fab_with_icons.dart';
import 'package:flutter_catalog/widgets/bottom_bar/layout.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({Key key}) : super(key: key);

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  String _lastSelected = 'TAB: 0';

  void _selectedTab(int index) {
    setState(() {
      _lastSelected = 'TAB: $index';
    });
  }

  void _selectedFab(int index) {
    setState(() {
      _lastSelected = 'FAB: $index';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "Bottom Bar".text.color(Colors.black).make(),
      ),
      body: Center(
        child: Text(
          _lastSelected,
          style: TextStyle(fontSize: 32.0),
        ),
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: Colors.grey,
        selectedColor: Colors.red,
        onTabSelected: _selectedTab,
        items: [
          FABBottomAppBarItem(iconData: Icons.menu, text: 'This'),
          FABBottomAppBarItem(iconData: Icons.layers, text: 'Is'),
          FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Bottom'),
          FABBottomAppBarItem(iconData: Icons.info, text: 'Bar'),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _buildFab(
          context), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget _buildFab(BuildContext context) {
  final icons = [Icons.sms, Icons.mail, Icons.phone];
  return AnchoredOverlay(
    showOverlay: true,
    overlayBuilder: (context, offset) {
      return CenterAbout(
        position: Offset(offset.dx, offset.dy - icons.length * 35.0),
        child: FabWithIcons(
          icons: icons,
          onIconTapped: null,
        ),
      );
    },
    child: SizedBox(
      width: 40.0,
      height: 40.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.edit),
        ),
      ),
    ),
    // child: SizedBox(
    //   width: 80.0,
    //   height: 80.0,
    //   child: FloatingActionButton(
    //     onPressed: () {},
    //     tooltip: 'Increment',
    //     child: Icon(Icons.add),
    //     elevation: 0.0,
    //   ),
    // )
  );
}
