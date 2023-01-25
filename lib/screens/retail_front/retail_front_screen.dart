import 'package:flutter/material.dart';

import 'components/body.dart';

class RetailFrontMainScreen extends StatelessWidget {
  static String routeName = "/retail_front";

  const RetailFrontMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: Text("POS Main"),automaticallyImplyLeading: false,),
      body: RetailFrontMainBody(),
    );
  }
}
