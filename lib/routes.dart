import 'package:flutter/widgets.dart';
import 'package:storeoperations_app/screens/sign_in/sign_in_screen.dart';
import 'package:storeoperations_app/screens/splash/splash_screen.dart';
import 'package:storeoperations_app/screens/pos_main/pos_main_screen.dart';
import 'package:storeoperations_app/screens/rescaf_front/rescaf_front_screen.dart';
import 'package:storeoperations_app/screens/rescaf_inv/rescaf_inv_screen.dart';
import 'package:storeoperations_app/screens/rescaf_kitchen/rescaf_kitchen_screen.dart';
import 'package:storeoperations_app/screens/rescaf_pos/rescaf_pos_screen.dart';
import 'package:storeoperations_app/screens/rescaf_sesspos/rescaf_sesspos_screen.dart';

import 'package:storeoperations_app/screens/store_functions/store_funcs_screen.dart';
import 'package:storeoperations_app/screens/retail_pos/retail_pos_screen.dart';
import 'package:storeoperations_app/screens/retail_inv/retail_inv_screen.dart';
import 'package:storeoperations_app/screens/retail_front/retail_front_screen.dart';
import 'package:storeoperations_app/screens/retail_kitchen/retail_kitchen_screen.dart';
import 'package:storeoperations_app/screens/retail_food/retail_food_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  PosMainScreen.routeName: (context) => const PosMainScreen(),
  ResCafFrontMainScreen.routeName: (context) => const ResCafFrontMainScreen(),
  ResCafInvMainScreen.routeName: (context) => const ResCafInvMainScreen(),
  ResCafKitchenMainScreen.routeName: (context) => const ResCafKitchenMainScreen(),
  ResCafPosMainScreen.routeName: (context) => const ResCafPosMainScreen(),
  ResCafSessPosMainScreen.routeName: (context) => const ResCafSessPosMainScreen(),
  
  StoreFuncMainScreen.routeName: (context) => const StoreFuncMainScreen(),
  RetailPosMainScreen.routeName: (context) => const RetailPosMainScreen(),
  RetailInvMainScreen.routeName: (context) => const RetailInvMainScreen(),
  RetailFrontMainScreen.routeName: (context) => const RetailFrontMainScreen(),
  RetailKitchenMainScreen.routeName: (context) => const RetailKitchenMainScreen(),
  RetailFoodMainScreen.routeName: (context) => const RetailFoodMainScreen(),

};

