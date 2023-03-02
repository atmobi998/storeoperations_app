// import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeoperations_app/components/custom_surfix_icon.dart';
// import 'package:storeoperations_app/components/form_error.dart';
import 'package:storeoperations_app/helper/keyboard.dart';
// import 'package:storeoperations_app/screens/pos_main/pos_main_screen.dart';
// import 'package:storeoperations_app/screens/rescaf_order/rescaf_order_screen.dart';
import 'package:storeoperations_app/screens/store_functions/store_funcs_screen.dart';
import 'package:storeoperations_app/components/default_button.dart';
import 'package:storeoperations_app/app_globals.dart';
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/appbuildmode.dart';
import 'package:new_virtual_keyboard/virtual_keyboard.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignForm extends StatefulWidget {

  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> with AfterLayoutMixin<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String storecode = '';
  String usrcode = '';
  String passcode = '';
  bool remember = false;
  final List<String> errors = [];
  final FocusNode _focusNodeusrcode = FocusNode();
  final FocusNode _focusNodepasscode = FocusNode();

  @override
  void dispose() {
    _focusNodeusrcode.dispose();
    _focusNodepasscode.dispose();
    super.dispose();
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

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      getLocalSavedLogin();
    });
  }

  Future<void> getLocalSavedLogin() async {
    try {
      var storeoperationsrem = await FlutterKeychain.get(key: "storeoperationsrem");
      var storeoperationslogin = await FlutterKeychain.get(key: "storeoperationslogin");
      var storeoperationspass = await FlutterKeychain.get(key: "storeoperationspass");
      if (null == storeoperationslogin) {
        await FlutterKeychain.put(key: "storeoperationslogin", value: usrcode);
      }
      if (null == storeoperationspass) {
        await FlutterKeychain.put(key: "storeoperationspass", value: passcode);
      }
      if (null == storeoperationsrem) {
        await FlutterKeychain.put(key: "storeoperationsrem", value: remember.toString());
      }
      if (!mounted) return;

      setState(() {
        if (null != storeoperationsrem && storeoperationsrem == 'true') {
          remember = true;
          if (null != storeoperationslogin) {
            poscodeTxtCtrl.text = storeoperationslogin;
          }
          if (null != storeoperationspass) {
            passcodeTxtCtrl.text = storeoperationspass;
          }
        }
      });
      
    } on Exception catch (ae) {
      logError("Exception: " + ae.toString());
    }
  }

  void logError(String error) {
    // print("Exception: " + error);
  }


  Future<void> saveLocalLogin() async {
    try {
      if (remember) {
        await FlutterKeychain.put(key: "storeoperationslogin", value: usrcode);
        await FlutterKeychain.put(key: "storeoperationspass", value: passcode);
        await FlutterKeychain.put(key: "storeoperationsrem", value: remember.toString());
      } else {
        await FlutterKeychain.put(key: "storeoperationslogin", value: '');
        await FlutterKeychain.put(key: "storeoperationspass", value: '');
        await FlutterKeychain.put(key: "storeoperationsrem", value: remember.toString());
      }
      if (!mounted) return;
    } on Exception catch (ae) {
      logError("Exception: " + ae.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: fullScrlWid,
      color: Colors.white,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: defInpFormMaxWidth,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(defFormFieldEdges02)),
              Container(
                alignment: Alignment.center,
                child: DefaultTextStyle(
                  style: textTheme.headlineMedium!,
                  child: RawKeyboardListener(
                    focusNode: _focusNodeusrcode,
                    onKey: _handleKeyEvent,
                    child: buildUserCodeFormField(),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(defFormFieldEdges02)),
              Container(
                alignment: Alignment.center,
                child: DefaultTextStyle(
                  style: textTheme.headlineMedium!,
                  child: RawKeyboardListener(
                    focusNode: _focusNodepasscode,
                    onKey: _handleKeyEvent,
                    child: buildPassCodeFormField(),
                  ),
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(defFormFieldEdges02)),
              Container(
                alignment: Alignment.center,
                width: defTxtInpWidth,
                child: Row(
                  children: [
                    Checkbox(
                      value: remember,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          remember = value!;
                        });
                      },
                    ),
                    Text(lblRememberMe),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: txtGetaTestQR,
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () { launch('https://metroeconomics.com/atcmobile/storeOperations_1024/storeOPTestLoginQR.png');
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(defFormFieldEdges20)),
              Container(
                alignment: Alignment.center,
                width: defTxtInpWidth,
                child: Row(
                  children: [
                    IconButton(
                      icon: Image.asset('assets/images/storeposqr.png'),
                      iconSize: getProportionateScreenHeight(50),
                      onPressed: () {
                        scanUserBarcode();
                      },
                    ),
                    Text(lblScanPass, style: const TextStyle(decoration: TextDecoration.underline)),
                    const Spacer(),
                    DefButton150(
                      text: lblContinue,
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          loginstorecode = storecode;
                          loginusercode = usrcode;
                          loginpasscode = passcode;
                          doPOSLogin();
                          KeyboardUtil.hideKeyboard(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(defFormFieldEdges20)),
              Container(color: Colors.grey, child: VirtualKeyboard(type: VirtualKeyboardType.Alphanumeric,onKeyPress: (key) => vkeypress(key)),),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanUserBarcode() async {
    String barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", txtBcodeCancel, true, ScanMode.DEFAULT);
      } on PlatformException {
        barcodeScanRes = txtBcodeScanErr;
      }
      if (!mounted) return;
      setBcodePassvalue(barcodeScanRes);
  }

  setBcodePassvalue(String barcode) {
      setState(() {
        String bcodepass = stringToBase64.decode(barcode);
        var passary = bcodepass.split('|||');
        if (passary.length == 3) {
          storecodeTxtCtrl.text = passary[0];
          poscodeTxtCtrl.text = passary[1];
          passcodeTxtCtrl.text = passary[2];
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            loginstorecode = storecode;
            loginusercode = usrcode;
            loginpasscode = passcode;
            doPOSLogin();
            KeyboardUtil.hideKeyboard(context);
          }
        }
      });
  }

    _handleKeyEvent(RawKeyEvent event) {
      if(event.runtimeType.toString() == 'RawKeyDownEvent'){
        if (poscodeState) {
          String text = poscodeTxtCtrl.text;
            String key = event.logicalKey.keyLabel;
            if(key != ''){
              text += key;
            }
            if (event.physicalKey == PhysicalKeyboardKey.backspace) {
              if (text.isNotEmpty) {
                text = text.substring(0, text.length - 1);
              }
            }
            if (event.physicalKey == PhysicalKeyboardKey.enter) {
              setState(() {
                poscodeTxtCtrl.text = text;
              });
            }
          setState(() {
            poscodeTxtCtrl.text = text;
          });
        } else if (passcodeState) {
          String text = passcodeTxtCtrl.text;
            String key = event.logicalKey.keyLabel;
            if(key != ''){
              text += key;
            }
            if (event.physicalKey == PhysicalKeyboardKey.backspace) {
              if (text.isNotEmpty) {
                text = text.substring(0, text.length - 1);
              }
            }
            if (event.physicalKey == PhysicalKeyboardKey.enter) {
              setState(() {
                passcodeTxtCtrl.text = text;
              });
            }
          setState(() {
            passcodeTxtCtrl.text = text;
          });
        }
      }
    }

  var shiftEnabled = false;
  vkeypress(key) {
    if (poscodeState) {
      String text = poscodeTxtCtrl.text;
      if (key.keyType == VirtualKeyboardKeyType.String) {
        text = text + (shiftEnabled ? key.capsText : key.text);
      } else if (key.keyType == VirtualKeyboardKeyType.Action) {
        switch (key.action) {
          case VirtualKeyboardKeyAction.Backspace:
            if (text.isEmpty) return;
            text = text.substring(0, text.length - 1);
            break;
          case VirtualKeyboardKeyAction.Return:
            text = text + '\n';
            break;
          case VirtualKeyboardKeyAction.Space:
            text = text + key.text;
            break;
          case VirtualKeyboardKeyAction.Shift:
            shiftEnabled = !shiftEnabled;
            break;
          default:
        }
      }
      setState(() {
        poscodeTxtCtrl.text = text;
      });
    } else if (passcodeState) {
      String text = passcodeTxtCtrl.text;
      if (key.keyType == VirtualKeyboardKeyType.String) {
        text = text + (shiftEnabled ? key.capsText : key.text);
      } else if (key.keyType == VirtualKeyboardKeyType.Action) {
        switch (key.action) {
          case VirtualKeyboardKeyAction.Backspace:
            if (text.isEmpty) return;
            text = text.substring(0, text.length - 1);
            break;
          case VirtualKeyboardKeyAction.Return:
            text = text + '\n';
            break;
          case VirtualKeyboardKeyAction.Space:
            text = text + key.text;
            break;
          case VirtualKeyboardKeyAction.Shift:
            shiftEnabled = !shiftEnabled;
            break;
          default:
        }
      }
      setState(() {
        passcodeTxtCtrl.text = text;
      });
    }
  }

  doPOSLogin() {
    var postdata = {
      "usr_code": loginusercode,
      "usr_passcode": loginpasscode,
      "mobapp": mobAppVal,
      "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
    };
    var posthdr = {'Accept': 'application/json'};
    showLoginDialog(context);
    http
        .post(loginPosEndPoint, body: postdata, headers: posthdr)
        .then((result) {
      hideAlertDialog(context);
      if (result.statusCode == 200) {
        var resary = jsonDecode(result.body);
        if (resary['data']['token'] != '') {
          setState(() {
            usertoken = resary['data']['token'];
            struser = resary['data']['struser'];
            thestore = resary['data']['thestore'];
            possess = resary['data']['possess'];
            isLoggedIn = true;
            saveLocalLogin();
          });
          removeError(error: kwrongPosLoginInfo);
          if (isLoggedIn) {
            Navigator.pushNamed(context, StoreFuncMainScreen.routeName);
          }

        } else {
          addError(error: kwrongPosLoginInfo);
        }
      } else {
        throw Exception(kcannotLogin);
      }
    }).catchError((error) {});
  }
  
  Container buildUserCodeFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth,
      color: Colors.white,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth,
        ),
        child: TextFormField(
          controller: poscodeTxtCtrl,
          obscureText: true,
          autofocus: false,
          readOnly: true,
          onSaved: (newValue) => usrcode = newValue!,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kPosLoginUserCodeNullErr);
            }
            usrcode = value;
            return;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kPosLoginUserCodeNullErr);
              return "";
            }
            return null;
          },
          onTap: () {
            poscodeState = true;
            passcodeState = false;
            if (appbuildmode == 'Testing') {
              poscodeTxtCtrl.text = testposcode;
            }
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblUserCodeText,
            hintText: hintUserCodeText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
        ),
      ),
    );
  }

  Container buildPassCodeFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth,
      color: Colors.white,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth,
        ),
        child: TextFormField(
          controller: passcodeTxtCtrl,
          obscureText: true,
          autofocus: false,
          readOnly: true,
          onSaved: (newValue) => passcode = newValue!,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kPosLoginPassCodeNullErr);
            }
            passcode = value;
            return;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kPosLoginPassCodeNullErr);
              return "";
            }
            return null;
          },
          onTap: () {
            poscodeState = false;
            passcodeState = true;
            if (appbuildmode == 'Testing') {
              passcodeTxtCtrl.text = testpasscode;
            }
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblPassCodeText,
            hintText: hintPassCodeText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          ),
        ),
      ),
    );
  }
}
