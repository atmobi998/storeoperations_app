import 'package:flutter/material.dart';

import 'components/body.dart';

class ResCafPosMainScreen extends StatelessWidget {
  static String routeName = "/rescaf_pos";

  const ResCafPosMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: Text("POS Main"),automaticallyImplyLeading: false,),
      body: ResCafPosMainBody(),
    );
  }
}
