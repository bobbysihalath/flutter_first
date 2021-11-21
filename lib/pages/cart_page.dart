import 'package:flutter/material.dart';
import 'package:flutter_catalog/widgets/theme.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.canvasColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Cart".text.color(Colors.black).make(),
        ),
        body: Column(
          children: [_CardList().p32().expand(), Divider(), _CardTotal()],
        ));
  }
}

class _CardTotal extends StatelessWidget {
  const _CardTotal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          '\$9999'.text.xl5.color(context.theme.accentColor).make(),
          30.widthBox,
          ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: "Buying not support yet...".text.make()));
              },
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(context.theme.buttonColor)),
              child: "Buy".text.white.make())
              .w32(context)
        ],
      ),
    );
  }
}

class _CardList extends StatefulWidget {
  const _CardList({Key key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<_CardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) =>
            ListTile(
              leading: Icon(Icons.done),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle_outline),
                onPressed: () => {},
              ),
              title: "Item 1".text.make(),
            ));
  }
}
