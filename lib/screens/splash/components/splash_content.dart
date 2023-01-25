import 'package:flutter/material.dart';
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          txtAppTitle,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(39),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
        Image.asset(
          image,
          height: halfScrlHei2b4,
          width: halfScrlWid,
        ),
      ],
    );
  }
}
