import 'package:flutter/material.dart';
import 'package:storeoperations_app/app_globals.dart';

import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(300),
      height: getProportionateScreenHeight(60),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(color: kPrimaryColor)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DefButton150 extends StatelessWidget {
  const DefButton150({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(150),
      height: getProportionateScreenHeight(60),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(22)),
              side: const BorderSide(color: kPrimaryColor)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DefButton250 extends StatelessWidget {
  const DefButton250({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(250),
      height: getProportionateScreenHeight(60),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(22)),
              side: const BorderSide(color: kPrimaryColor)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class GreyButton extends StatelessWidget {
  const GreyButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(250),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[500]!),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[500]!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
              side: BorderSide(color: Colors.blueGrey[500]!)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.white ,
          ),
        ),
      ),
    );
  }
}

class GreyButton100 extends StatelessWidget {
  const GreyButton100({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(100),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[500]!),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[500]!),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
              side: BorderSide(color: Colors.blueGrey[500]!)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class FuncButton100 extends StatelessWidget {
  const FuncButton100({
    Key? key,
    required this.text,
    required this.press,
    required this.state,
  }) : super(key: key);
  final String text;
  final VoidCallback press;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(100),
      height: getProportionateScreenHeight(60),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(!state? Colors.blueGrey[500]!: Colors.blue),
          backgroundColor: MaterialStateProperty.all<Color>(!state? Colors.blueGrey[500]!: Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
              side: BorderSide(color: !state? Colors.blueGrey[500]!: Colors.blue)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.white ,
          ),
        ),
      ),
    );
  }
}

class FuncButton250 extends StatelessWidget {
  const FuncButton250({
    Key? key,
    required this.text,
    required this.press,
    required this.state,
  }) : super(key: key);
  final String text;
  final VoidCallback press;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(250),
      height: getProportionateScreenHeight(70),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(!state? Colors.blueGrey[500]!: Colors.blue),
          backgroundColor: MaterialStateProperty.all<Color>(!state? Colors.blueGrey[500]!: Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
              side: BorderSide(color: !state? Colors.blueGrey[500]!: Colors.blue)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.white ,
          ),
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(100),
      height: getProportionateScreenHeight(50),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(5)),
          foregroundColor: MaterialStateProperty.all<Color>(!btnPosStateStart? Colors.blueGrey[500]!: Colors.blue),
          backgroundColor: MaterialStateProperty.all<Color>(!btnPosStateStart? Colors.blueGrey[500]!: Colors.blue),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
              side: BorderSide(color: !btnPosStateStart? Colors.blueGrey[500]!: Colors.blue)
            )
          )
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(16),
            color: Colors.white ,
          ),
        ),
      ),
    );
  }
}


