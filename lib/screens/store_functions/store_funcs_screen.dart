import 'package:flutter/material.dart';

import 'components/body.dart';

class StoreFuncMainScreen extends StatelessWidget {
  static String routeName = "/store_functions";

  const StoreFuncMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(title: Text("POS Main"),automaticallyImplyLeading: false,),
      body: StoreFuncMainBody(),
    );
  }
}
