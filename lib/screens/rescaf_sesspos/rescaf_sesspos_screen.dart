import 'package:flutter/material.dart';

import 'components/body.dart';

class ResCafSessPosMainScreen extends StatelessWidget {
  static String routeName = "/rescaf_sesspos";

  const ResCafSessPosMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: Text("POS Main"),automaticallyImplyLeading: false,),
      body: ResCafSessPosMainBody(),
    );
  }
}
