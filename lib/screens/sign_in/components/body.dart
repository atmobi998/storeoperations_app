// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';
import 'sign_form.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    height: getProportionateScreenHeight(defFormFieldEdges20)),
                Text(txtAppTitAtc,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(defFormFieldEdges01)),
                new RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: txtSignInHintCreds,
                        style: const TextStyle(color: Colors.blue),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () { launch('https://metroeconomics.com/atcmobile/StoreOpApp_Instructions.html');
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(defFormFieldEdges20)),
                const SignForm(),
                SizedBox(height: getProportionateScreenHeight(defFormFieldEdges20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
