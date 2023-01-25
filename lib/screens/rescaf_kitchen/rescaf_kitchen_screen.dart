import 'package:flutter/material.dart';

import 'components/body.dart';

class ResCafKitchenMainScreen extends StatelessWidget {
  static String routeName = "/rescaf_kitchen";

  const ResCafKitchenMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: Text("POS Main"),automaticallyImplyLeading: false,),
      body: ResCafKitchenMainBody(),
    );
  }
}
