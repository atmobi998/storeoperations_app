import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
import 'package:storeoperations_app/routes.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/screens/splash/splash_screen.dart';
import 'package:storeoperations_app/theme.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
      .then((value) => runApp(const MyApp()));
  
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: txtAppTitle,
      onGenerateTitle: (BuildContext context) => txtAppTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,     
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (
          Locale? locale,
          Iterable<Locale> supportedLocales,
        ) {
          return locale;
        },    
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

