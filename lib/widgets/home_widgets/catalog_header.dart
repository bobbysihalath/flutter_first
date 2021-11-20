import 'package:flutter/cupertino.dart';
import 'package:flutter_catalog/widgets/theme.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';
import 'package:velocity_x/src/extensions/string_ext.dart';

class CatalogHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      "Catalog App".text.xl5.bold.color(context.theme.accentColor).make(),
      "Trending products".text.xl2.make()
    ]);
  }
}


