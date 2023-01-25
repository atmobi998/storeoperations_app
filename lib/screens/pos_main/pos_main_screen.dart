import 'package:flutter/material.dart';

import 'components/body.dart';

class PosMainScreen extends StatelessWidget {
  static String routeName = "/pos_main";

  const PosMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: Text("POS Main"),automaticallyImplyLeading: false,),
      body: PosMainBody(),
    );
  }
}
