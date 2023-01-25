import 'package:flutter/material.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'components/body.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";

  const SignInScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(txtSignInTit),
        automaticallyImplyLeading: false,
      ),
      body: const Body(),
    );
  }
}
