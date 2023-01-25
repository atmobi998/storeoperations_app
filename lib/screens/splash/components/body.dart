import 'package:flutter/material.dart';
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/screens/sign_in/sign_in_screen.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/app_globals.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Body extends StatefulWidget {
  
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with AfterLayoutMixin<Body> {
  int currentPage = 0;
  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      checkLocalSavedLogin();
    });
  }

  Future<void> checkLocalSavedLogin() async {
    try {
      var storeoperationslogin = await FlutterKeychain.get(key: "storeoperationslogin");
      if (null != storeoperationslogin) {
        Navigator.pushNamed(context, SignInScreen.routeName);
      }
      if (!mounted) return;

      setState(() {
        
      });
      
    } on Exception catch (ae) {
      logError("Exception: " + ae.toString());
    }
  }

  void logError(String error) {
    // print("Exception: " + error);
  }


  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    List<Map<String, String>> splashData = [
      {
        "text": txtSplash01,
        "image": "assets/images/atc06.png"
      },
      {
        "text": txtSplash02,
        "image": "assets/images/atc08.png"
      },
      {
        "text": txtSplash03,
        "image": "assets/images/BTT-Logo_01.png"
      },
    ];

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"]!,
                  text: splashData[index]['text']!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    DefaultButton(
                      text: lblContinue,
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
