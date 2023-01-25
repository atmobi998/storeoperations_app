// import 'dart:io';

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:intl/intl.dart'; 
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/app_globals.dart';
// import 'package:storeoperations_app/helper/keyboard.dart';
import 'package:storeoperations_app/components/default_button.dart';
// import 'package:storeoperations_app/components/custom_surfix_icon.dart';
// import 'package:new_virtual_keyboard/virtual_keyboard.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:audiofileplayer/audiofileplayer.dart';
// import 'package:storeoperations_app/screens/pos_main/pos_main_screen.dart';
import 'package:storeoperations_app/screens/rescaf_front/rescaf_front_screen.dart';
import 'package:storeoperations_app/screens/rescaf_inv/rescaf_inv_screen.dart';
import 'package:storeoperations_app/screens/rescaf_kitchen/rescaf_kitchen_screen.dart';
import 'package:storeoperations_app/screens/rescaf_pos/rescaf_pos_screen.dart';
import 'package:storeoperations_app/screens/rescaf_sesspos/rescaf_sesspos_screen.dart';

import 'package:storeoperations_app/screens/retail_pos/retail_pos_screen.dart';
import 'package:storeoperations_app/screens/retail_inv/retail_inv_screen.dart';
import 'package:storeoperations_app/screens/retail_front/retail_front_screen.dart';
import 'package:storeoperations_app/screens/retail_kitchen/retail_kitchen_screen.dart';
import 'package:storeoperations_app/screens/retail_food/retail_food_screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StoreFuncMainBody extends StatefulWidget {

  const StoreFuncMainBody({Key? key}) : super(key: key);

  @override
  _StoreFuncMainBody createState() => _StoreFuncMainBody();

}

class _StoreFuncMainBody extends State<StoreFuncMainBody> with AfterLayoutMixin<StoreFuncMainBody> {

  final _formKey = GlobalKey<FormState>();
  String prodcode ='';
  final List<String> errors = [];
  final FocusNode _focusNode = FocusNode();
  pw.Document doc = pw.Document();
  late ByteData printfont;
  late Uint8List assetLogoATC;
  bool logoPdfLoaded = false;

  loadPrintFont() async {
    printfont = await rootBundle.load("assets/fonts/open-sans/OpenSans-Regular.ttf");
  }

  @override
  void dispose() {
    _focusNode.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    return Form(
      key: _formKey,
      child: SizedBox(
        width: fullScrlWid,
        height: fullScrlHei,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10), vertical: getProportionateScreenHeight(10)),
          child: 
            Column(children: [
                Row(children: [
                  Column(children: [
                    Container(
                      width: halfScrlWid,
                      height: pct20ScrlHei,
                      color: kPosBaseColor,
                      padding: EdgeInsets.all(defTxtInpEdge),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: halfScrlWid,
                          maxHeight: pct20ScrlHei,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: <Widget>[
                                    Text(txtStoreResCafFunctionsTitle,style: TextStyle(fontSize: getProportionateScreenWidth(26),color: kPrimaryColor,fontWeight: FontWeight.bold)),
                                    Text(thestore['store_name'],style: TextStyle(fontSize: getProportionateScreenWidth(18),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                    Text(struser['usr_name'],style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                    Text(struser['name'],style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ],
                          ),
                      ),
                    ),
                  ]),
                  Column(children: [ 
                    Container(
                        width: halfScrlWid,
                        height: pct20ScrlHei,
                        color: kPosBaseColor,
                        padding: EdgeInsets.all(defTxtInpEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: pct20ScrlHei,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: <Widget>[
                                    Text(txtStoreRetailFunctionsTitle,style: TextStyle(fontSize: getProportionateScreenWidth(26),color: kPrimaryColor,fontWeight: FontWeight.bold)),
                                    Text(thestore['store_name'],style: TextStyle(fontSize: getProportionateScreenWidth(18),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                    Text(struser['usr_name'],style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                    Text(struser['name'],style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                  ]),
                ]),
                Row(children: [
                  Column(children: [
                    Container(
                        width: halfScrlWid,
                        height: pct77ScrlHei,
                        color: kPosBaseColor,
                        padding: EdgeInsets.all(defNavBoxEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: pct77ScrlHei,
                          ),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: (enableResCaf)? Column(children: [
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblResCafFront,
                                    state: btnStateResCafFront,
                                    press: () {
                                      if (btnStateResCafFront) {
                                        Navigator.pushNamed(context, ResCafFrontMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblResCafInventory,
                                    state: btnStateResCafInventory,
                                    press: () {
                                      if (btnStateResCafInventory) {
                                        Navigator.pushNamed(context, ResCafInvMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblResCafKitchen,
                                    state: btnStateResCafKitchen,
                                    press: () {
                                      if (btnStateResCafKitchen) {
                                        Navigator.pushNamed(context, ResCafKitchenMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblResCafPOS,
                                    state: btnStateResCafPOS,
                                    press: () {
                                      if (btnStateResCafPOS) {
                                        Navigator.pushNamed(context, ResCafPosMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblResCafPOSSess,
                                    state: btnStateResCafSessPOS,
                                    press: () {
                                      if (btnStateResCafSessPOS) {
                                        Navigator.pushNamed(context, ResCafSessPosMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                ],
                              ):Container(),
                          ),
                        ),
                      ),
                  ]),
                  Column(children: [
                    Container(
                        width: halfScrlWid,
                        height: pct77ScrlHei,
                        color: kPosBaseColor,
                        padding: EdgeInsets.all(defNavBoxEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: pct77ScrlHei,
                          ),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: (enableRetailer)? Column(children: [
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblRetailFront,
                                    state: btnStateRetailFront,
                                    press: () {
                                      if (btnStateRetailFront) {
                                        Navigator.pushNamed(context, RetailFrontMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblRetailInventory,
                                    state: btnStateRetailInventory,
                                    press: () {
                                      if (btnStateRetailInventory) {
                                        Navigator.pushNamed(context, RetailInvMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblRetailKitchen,
                                    state: btnStateRetailKitchen,
                                    press: () {
                                      if (btnStateRetailKitchen) {
                                        Navigator.pushNamed(context, RetailKitchenMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblRetailFood,
                                    state: btnStateRetailFood,
                                    press: () {
                                      if (btnStateRetailFood) {
                                        Navigator.pushNamed(context, RetailFoodMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton250(
                                    text: lblRetailPOS,
                                    state: btnStateRetailPOS,
                                    press: () {
                                      if (btnStateRetailPOS) {
                                        Navigator.pushNamed(context, RetailPosMainScreen.routeName);
                                      }
                                    },
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                ],
                              ):Container(),
                          ),
                        ),
                      ),
                  ]),
                ]),
            ]),
        ),
      ),
    );
    
  }

  @override
  void afterFirstLayout(BuildContext context) {
    loadPrintFont();
    setState(() {
      if (struser['is_pos']! == 1) {
        btnStateResCafSessPOS = true;
        btnStateResCafPOS = true;
        btnStateRetailPOS = true;
      }
      if (struser['is_inv']! == 1) {
        btnStateResCafInventory = true;
        btnStateRetailInventory = true;
      }
      if (struser['is_kitchen']! == 1) {
        btnStateResCafInventory = true;
        btnStateResCafKitchen = true;
        btnStateRetailInventory = true;
        btnStateRetailKitchen = true;
        btnStateRetailFood = true;
      }
      if (struser['is_frontst']! == 1) {
        btnStateResCafFront = true;
        btnStateRetailFront = true;
      }
    });
  }

  var shiftEnabled = false;

  void logError(String error) {
    // print("Exception: " + error);
  }

  showExitDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(txtAlertExit),
                actions: <Widget>[
                  FuncButton100(text: lblCancel, state: btnPosStateCancel,
                    press: () {
                        hideCashDialog(context);
                        setState(() {});
                    },
                  ),
                  FuncButton100(text: lblExit, state: btnPosStateExit,
                    press: () {
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    },
                  ),
                ],
              );
            },
          );
      },
    );
  }


  playBeepSound() {
    Audio.load('assets/sounds/beep-read-02.mp3')..play()..dispose();
  }



  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  readLogoPdf() async {
    if (logoPdfLoaded == false) {
      final ByteData logoATCbytes = await rootBundle.load('assets/images/BTT-Logo_09.png');
      assetLogoATC = logoATCbytes.buffer.asUint8List();
      logoPdfLoaded = true;
    }
  }


}
