import 'package:flutter/material.dart';

import 'components/body.dart';

class RetailPosMainScreen extends StatelessWidget {
  static String routeName = "/retail_pos";

  const RetailPosMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: Text("POS Main"),automaticallyImplyLeading: false,),
      body: RetailPosMainBody(),
    );
  }
}
