// import 'dart:io';
// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; 
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/app_globals.dart';
import 'package:storeoperations_app/helper/keyboard.dart';
import 'package:storeoperations_app/components/default_button.dart';
import 'package:storeoperations_app/components/custom_surfix_icon.dart';
import 'package:new_virtual_keyboard/virtual_keyboard.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:audiofileplayer/audiofileplayer.dart';

class PosMainBody extends StatefulWidget {

  const PosMainBody({Key? key}) : super(key: key);

  @override
  _PosMainBody createState() => _PosMainBody();

}

class _PosMainBody extends State<PosMainBody> with AfterLayoutMixin<PosMainBody> {

final _formKey = GlobalKey<FormState>();
final _cashformKey = GlobalKey<FormState>();
final _startcashformKey = GlobalKey<FormState>();
String prodcode ='';
final List<String> errors = [];
final FocusNode _focusNode = FocusNode();
final FocusNode _focusNodeChg = FocusNode();
final FocusNode _focusNodeCash = FocusNode();
final FocusNode _focusNodeSetup = FocusNode();
pw.Document doc = pw.Document();
late ByteData printfont;
final List<String> _numericchars = ['0','1','2','3','4','5','6','7','8','9',',','.'];
late Uint8List assetLogoATC;
bool logoPdfLoaded = false;

loadPrintFont() async {
  printfont = await rootBundle.load("assets/fonts/open-sans/OpenSans-Regular.ttf");
}

@override
void dispose() {
  _focusNode.dispose();
  _focusNodeChg.dispose();
  _focusNodeSetup.dispose();
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
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: SizedBox(
        width: fullScrlWid,
        height: fullScrlHei,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10), vertical: getProportionateScreenHeight(10)),
          child: Column(children: [
              Row(children: [
                  Column(children: [
                        Container(
                          width: halfScrlWid,
                          height: halfScrlHei,
                          color: kPosBaseColor,
                          padding: EdgeInsets.all(defTxtInpEdge),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: halfScrlWid,
                              maxHeight: halfScrlHei,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    Container(
                                      alignment: Alignment.center,
                                      child: DefaultTextStyle(
                                        style: textTheme.headline4!,
                                        child: RawKeyboardListener(
                                          focusNode: _focusNode,
                                          onKey: _handleKeyEvent,
                                          child: buildProdCodeFormField(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [ 
                                        FuncButton100(
                                          state: btnPosStateEnter,
                                          text: lblEnter,
                                          press: () {
                                            enterBtnPress();
                                          },
                                        ),
                                        SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)),                                                                   
                                        FuncButton100(
                                          state: btnPosStateDelete,
                                          text: lblDelete,
                                          press: () {
                                            deleteBtnPress();
                                          },
                                        ),
                                        SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)),                                                                   
                                      ],
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [ 
                                        FuncButton100(
                                          state: btnPosStateScan,
                                          text: lblScan, 
                                          press: () {
                                            scanBtnPress();
                                          },
                                        ),
                                        SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)),                                                                   
                                        FuncButton100(
                                          state: btnPosStateScanS,
                                          text: lblScanS, 
                                          press: () {
                                            scanSBtnPress();
                                          },
                                        ),
                                        SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)),                                                                   
                                      ],
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  ],
                                ),
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)), 
                                Column(
                                  children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    Container(
                                      alignment: Alignment.center,
                                      child: DefaultTextStyle(
                                        style: textTheme.headline4!,
                                        child: RawKeyboardListener(
                                          focusNode: _focusNodeChg,
                                          onKey: _handleKeyEvent,
                                          child: buildPickItmFormField(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)),                               
                                        FuncButton100(
                                          state: btnPosStateChange,
                                          text: lblChange,
                                          press: () {
                                            changeBtnPress();
                                          },
                                        ),                                      
                                      ],
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],),
                  Column(children: [
                    Container(
                        width: halfScrlWid,
                        height: halfScrlHei,
                        color: kPosBaseColor,
                        padding: EdgeInsets.all(defTxtInpEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: halfScrlHei,
                          ),
                          child: Row(
                            children: [
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    FuncButton100(text: lblSave, state: btnPosStateSave,
                                      press: () {
                                          saveBtnPress();
                                      },
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges05)),
                                    FuncButton100(text: lblLoad, state: btnPosStateLoad,
                                      press: () {
                                          loadBtnPress();
                                      },
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges05)),
                                    FuncButton100(text: lblCash, state: btnPosStateCash,
                                      press: () {
                                          cashBtnPress();
                                      },
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges05)),
                                  ],
                                ),
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    FuncButton100(text: lblSetup, state: btnPosStateSetup,
                                      press: () {
                                          setupBtnPress();
                                      },
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    FuncButton100(text: lblExit, state: btnPosStateExit,
                                      press: () {
                                          saveBtnPress();
                                          showExitDialog(context);
                                      },
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges05)),
                                    FuncButton100(text: lblFind, state: btnPosStateFind,
                                      press: () {
                                          setState(() {
                                            btnPosStateFind = !btnPosStateFind;
                                            btnPosStateKeyb = !btnPosStateFind;
                                          });
                                      },
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges05)),
                                    FuncButton100(text: lblKeyb, state: btnPosStateKeyb,
                                      press: () {
                                          setState(() {
                                            btnPosStateKeyb = !btnPosStateKeyb;
                                            btnPosStateFind = !btnPosStateKeyb;
                                          });
                                      },
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges05)),
                                  ],
                                ), 
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: <Widget>[
                                    Text(txtPosTitle,style: TextStyle(fontSize: getProportionateScreenWidth(39),color: kPrimaryColor,fontWeight: FontWeight.bold,),),
                                    Image.asset("assets/images/BTT-Logo_09.png",height: halfScrlHei1b3,width: halfScrlWid1b3,),
                                    Text(thestore['store_name'],style: TextStyle(fontSize: getProportionateScreenWidth(19),color: kPosNameColor,fontWeight: FontWeight.normal,),),
                                    Text(struser['usr_name'],style: TextStyle(fontSize: getProportionateScreenWidth(19),color: kPosNameColor,fontWeight: FontWeight.normal,),),
                                    Text(struser['name'],style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosNameColor,fontWeight: FontWeight.normal,),),
                                  ],
                                ),
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: <Widget>[
                                    Text(txtPosTax + posCcy.format(curtkttax) + ' ' + thestore['currency'] ,style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosCurNbrColor,fontWeight: FontWeight.normal,),),
                                    Text(txtPosTotal + posCcy.format(curtkttotal) + ' ' + thestore['currency'] ,style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosCurNbrColor,fontWeight: FontWeight.normal,),),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                  ],),
                ],
              ),
              Row(children: [
                  Column(children: [
                    Container(
                        width: halfScrlWid,
                        height: halfScrlHei,
                        color: kPosBaseColor,
                        padding: EdgeInsets.all(defTxtInpEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: halfScrlHei,
                          ),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(children: [
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  getTktItems(),
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                ],
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),
                    Column(children: [
                        Container(
                          width: halfScrlWid,
                          height: halfScrlHei,
                          color: kPosBaseColor,
                          padding: EdgeInsets.all(defTxtInpEdge),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: halfScrlWid,
                              maxHeight: halfScrlHei,
                            ),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: btnPosStateKeyb? Column(children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    Container(color: Colors.grey, child: VirtualKeyboard(type: VirtualKeyboardType.Numeric,onKeyPress: (key) => vkeypress(key)),),
                                  ],
                                ): Column(children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    getSessTkts(),
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  ],
                                ),
                            ),
                          ),
                        ),  
                      ],
                    ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
    
  }

  @override
  void afterFirstLayout(BuildContext context) {
    doPOSProdQryAllCode();
    doPOSProdQryAllId();
    loadPrintFont();
    setState(() {
      prodItmTxtCtrl.text = "1";
      sessstartcashTxtCtrl.text = "0.0 "+thestore['currency'];
      cursessid=0;
      curtktid=cursessid;
      curtktdetid=0;
      curtktdet  = <Product>[]; 
      curtkt = Ticket.fromArray([curtktid,curtktid,curtktdet,new DateTime.now(),new DateTime.now(),curtkttotal,curtkttax,curtkttotal,0.0,new DateTime.now(),1]);
      curtkttotal = 0.0;
      curtkttax = 0.0;
      curtktcash = 0.0;
      curtktchange = 0.0;
      cursess.add(curtkt);
    });
  }

  var shiftEnabled = false;
  vkeypress(key) {
    if (btnPosStateChange) {
      String text = prodItmTxtCtrl.text;
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
        prodItmTxtCtrl.text = text;
      });
    } else if (btnPosStateSetup) {
      String text = sessstartcashTxtCtrl.text;
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
        sessstartcashTxtCtrl.text = text;
      });
    } else {
      String text = prodCodeTxtCtrl.text;
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
        prodCodeTxtCtrl.text = text;
      });
    }
  }

  _handleKeyEvent(RawKeyEvent event) {
      if (btnPosStateChange) {
        String text = prodItmTxtCtrl.text;
        if(event.runtimeType.toString() == 'RawKeyDownEvent'){
          String keybk = event.logicalKey.keyLabel;
          if(_numericchars.contains(keybk)){
            text += keybk;
          }
          if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
            var tmpkeyint = int.tryParse(text)!+1;
            text = tmpkeyint.toString();
          }
          if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
            var tmpkeyint = int.tryParse(text)!-1;
            text = tmpkeyint.toString();
          }
          if (event.physicalKey == PhysicalKeyboardKey.backspace) {
            if (text.isNotEmpty) {
              text = text.substring(0, text.length - 1);
            }
          }
          if (event.physicalKey == PhysicalKeyboardKey.enter) {
            setState(() {
              var tmpkeyint = int.tryParse(text);
              prodItmTxtCtrl.text = tmpkeyint.toString();
              curtktdet[curtktdetid].pickitm = int.tryParse(text)!;
            });
            changeBtnPress();
            text = '1';
          }
        }
        setState(() {
          prodItmTxtCtrl.text = text;
        });
      } else if (btnPosStateCash) {
        if(event.runtimeType.toString() == 'RawKeyDownEvent'){
          String text = tktcashTxtCtrl.text;
          text = text.replaceAll('.0 ' + thestore['currency'], '');
          text = text.replaceAll(',', '');
          String keybk = event.logicalKey.keyLabel;
          if(_numericchars.contains(keybk)){
            text += keybk;
          }
          if (event.physicalKey == PhysicalKeyboardKey.backspace) {
            if (text.isNotEmpty) {
              text = text.substring(0, text.length - 1);
            }
          }
          setState(() {
            tktcash = double.tryParse(text.replaceAll(',', ''))!;
            tktcashTxtCtrl.text = posCcy.format(tktcash) + ' ' + thestore['currency'] ;
              curtktchange = tktcash - curtkttotal;
              curtktcash = tktcash;
              doUpdateTktNbr();
              cashAlertTxt = txtCashAlertTax + posCcy.format(curtkttax) + ' ' + thestore['currency'] + 
                              txtCashAlertTot + posCcy.format(curtkttotal) + ' ' + thestore['currency'] ;
              tktcashchangeTxtCtrl.text = posCcy.format(curtktchange) + ' ' + thestore['currency'] ;
          });
        }
      } else if (btnPosStateSetup) {
        if(event.runtimeType.toString() == 'RawKeyDownEvent'){
          String text = sessstartcashTxtCtrl.text;
          text = text.replaceAll('.0 ' + thestore['currency'], '');
          text = text.replaceAll(',', '');
          String keybk = event.logicalKey.keyLabel;
          if(_numericchars.contains(keybk)){
            text += keybk;
          }
          if (event.physicalKey == PhysicalKeyboardKey.backspace) {
            if (text.isNotEmpty) {
              text = text.substring(0, text.length - 1);
            }
          }
          setState(() {
              sessstartcash = double.tryParse(text.replaceAll(',', ''))!;
              sessstartcashTxtCtrl.text = posCcy.format(sessstartcash) + ' ' + thestore['currency'] ;
          });
        }
      } else {
        String text = prodCodeTxtCtrl.text;
        if(event.runtimeType.toString() == 'RawKeyDownEvent'){
          String keybk = event.logicalKey.keyLabel;
          if(_numericchars.contains(keybk)){
            text += keybk;
          }
          if (event.physicalKey == PhysicalKeyboardKey.arrowUp) {
            var tmpkeyint = int.tryParse(text)!+1;
            text = tmpkeyint.toString();
          }
          if (event.physicalKey == PhysicalKeyboardKey.arrowDown) {
            var tmpkeyint = int.tryParse(text)!-1;
            text = tmpkeyint.toString();
          }
          if (event.physicalKey == PhysicalKeyboardKey.backspace) {
            if (text.isNotEmpty) {
              text = text.substring(0, text.length - 1);
            }
          }
          if (event.physicalKey == PhysicalKeyboardKey.enter) {
            setState(() {
              prodCodeTxtCtrl.text = text;
            });
            enterBtnPress();
            text = '';
          }
        }
        setState(() {
          prodCodeTxtCtrl.text = text;
        });
      }
    }


  void logError(String error) {
    // print("Exception: " + error);
  }

  void picktktitem(int index) {
      setState(() {
        curtktdetid = index;
        if (btnPosStateChange) {
            prodItmTxtCtrl.text = curtktdet[curtktdetid].pickitm.toString();
        }
      });
  }

  void picksessitem(int index) {
      setState(() {
        cursessid = index;
      });
  }

  void refresh(int productid) {
      curprodid = productid;
      setState(() {});
      productqry();
  }

  void refreshonly() {
      setState(() {});
  }

  doUpdateTktNbr() {
    setState(() {
      cashPrintHdrTxt = '';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnHdrStore + thestore['store_name']+'\n';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnHdrPos + struser['usr_name']+ '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + thestore['store_addr'] + '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + thestore['store_addr2']+ '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnBdyTel + thestore['store_phone']+ '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnBdyEmail + thestore['store_email']+ '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + DateFormat.yMd().add_jms().format(DateTime.now()) + '\n';
      cashPrintBodyTxt = '____________________________________\n\n';
      curtkttotal = 0;
      curtkttax = 0;
      for(var i = 0; i < curtktdet.length; i++){
        var tmpdetsubtot = curtktdet[i].prodpricesell * curtktdet[i].pickitm + curtktdet[i].prodpricesell * curtktdet[i].pickitm * curtktdet[i].prodtaxrate / 100.0;
        var tmpdettax = curtktdet[i].prodpricesell * curtktdet[i].pickitm * curtktdet[i].prodtaxrate / 100.0;
        curtkttotal = curtkttotal + curtktdet[i].prodpricesell * curtktdet[i].pickitm + curtktdet[i].prodpricesell * curtktdet[i].pickitm * curtktdet[i].prodtaxrate / 100.0 ;
        curtkttax = curtkttax + curtktdet[i].prodpricesell * curtktdet[i].pickitm * curtktdet[i].prodtaxrate / 100.0 ;
        cashPrintBodyTxt = cashPrintBodyTxt + curtktdet[i].prodname+': x ' + curtktdet[i].pickitm.toString() + '\n';
        cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyPrice + posCcy.format(curtktdet[i].prodpricesell) + ' ' + thestore['currency'] + '   ';
        cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyTax + posCcy.format(tmpdettax) + ' ' + thestore['currency'] + '\n';
        cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdySub + posCcy.format(tmpdetsubtot) + ' ' + thestore['currency'] + '\n\n';
      }
      cashPrintBodyTxt = cashPrintBodyTxt + '____________________________________\n';
      cashPrintFooterTxt = '';
      cashPrintFooterTxt = cashPrintFooterTxt + txtCashPrnBdyTotal + posCcy.format(curtkttotal) + ' ' + thestore['currency'] + '\n';
      cashPrintFooterTxt = cashPrintFooterTxt + txtCashPrnBdyCash + posCcy.format(curtktcash) + ' ' + thestore['currency'] + '\n';
      cashPrintFooterTxt = cashPrintFooterTxt + txtCashPrnBdyChange + posCcy.format(curtktchange) + ' ' + thestore['currency'] + '\n';
      cashPrintFooterTxt = cashPrintFooterTxt + '\n\n';

      curtkt.detail = curtktdet;
      curtkt.lastupd = new DateTime.now();
      curtkt.tkttotal = curtkttotal;
      curtkt.tkttax = curtkttax;
      curtkt.tktcash = curtktcash;
      curtkt.tktchange = curtktchange;
      curtkt.needsave = 1;
      cursess[curtktid]=curtkt;

    });
  }

  void saveByCash() {
    if (cursess.isNotEmpty) {
      setState(() {
        secstartcash = sessstartcash;
        seccurcash = 0.0;
        secendcash = 0.0;
        sectimestart = '';
        seccurtime = '';
        secendtime = '';
        sectotcurtkt = 0;
      });
      cursess.asMap().forEach((tsesidx,tsestkt) => saveSessTkt(tsesidx,tsestkt));
      sessSaveChanges(false);
      setState(() {
      });
    }
  }

  void saveBtnPress() {
    if (cursess.isNotEmpty) {
      setState(() {
        secstartcash = sessstartcash;
        seccurcash = 0.0;
        secendcash = 0.0;
        sectimestart = '';
        seccurtime = '';
        secendtime = '';
        sectotcurtkt = 0;
      });
      cursess.asMap().forEach((tsesidx,tsestkt) => saveSessTkt(tsesidx,tsestkt));
      sessSaveChanges(true);
    }
  }

  sessSaveChanges(bool saveshowdialog) {
    var postdata = {
        "id" : possess['id'].toString(),
        "pos_id" : struser['id'].toString(), 
        "timestart" : sectimestart,
        "curtime" : seccurtime,
        "endtime" : secendtime,
        "startcash" : "$secstartcash",
        "curcash" : "$seccurcash",
        "endcash" : "$secendcash",
        "totcurtkt" : "$sectotcurtkt",
        "totendtkt" : "$sectotendtkt",
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
      };
    http.post(editsessPosEndPoint, body: postdata, headers: posthdr ).then((result) {
        if (result.statusCode == 200) {
          var resary = jsonDecode(result.body);
          if (resary['status'] > 0) {
              setState(() {
                cashSaveAlertTxt = txtCashSavAlrtFrom + DateFormat.yMd().add_jms().format(DateTime.tryParse(sectimestart)!) + '\n'
                                    + txtCashSavAlrtTo + DateFormat.yMd().add_jms().format(DateTime.tryParse(seccurtime)!) + '\n'
                                    + txtCashSavAlrtTks + sectotcurtkt.toString() + '\n'
                                    + txtCashSavAlrtTot + posCcy.format(seccurcash) + ' ' + thestore['currency'] ;
              });
              if (saveshowdialog) {
                showSessSaveDialog(context);
              }
              KeyboardUtil.hideKeyboard(context);
          } else if (resary['status'] == -1) {
             
          } else {
            
          }
        } else {
          throw Exception(productSaveErrMessage);
        }
    }).catchError((error) {});
  }

  void saveSessTkt(tsesidx,Ticket tsestkt) {
    tktSaveChanges(tsesidx,tsestkt);
  }

  tktSaveChanges(tsesidx,Ticket tsestkt) {
    final df = DateFormat('yyyy-MM-dd hh:mm:ss');
    var tmplastupd = df.format(tsestkt.lastupd);
    var tmpcreated = df.format(tsestkt.created);
    var tmpitemcount = tsestkt.detail.length;
    var tmpsubtotal = tsestkt.tkttotal - tsestkt.tkttax;
    var tmpsestktid = (cursess[tsesidx].needsave == 1)? "-1" : "${tsestkt.id}";
    String tmptkttotal = 'Tot: ' + posCcy.format(tsestkt.tkttotal) + ' ' + thestore['currency'];
    setState(() {
      if (sectimestart == '') {
        sectimestart=tmpcreated;
      }
      seccurtime = tmplastupd;
      secendtime = tmplastupd;
      seccurcash += tsestkt.tkttotal;
      secendcash += tsestkt.tkttotal;
      sectotcurtkt++;
      sectotendtkt++;
    });
    var postdata = {
        "id" : tmpsestktid,
        "pos_id" : struser['id'].toString(), 
        "sess_id" : possess['id'].toString(),
        "created" : tmpcreated,
        "modified" : tmplastupd,
        "item_count" : "$tmpitemcount",
        "subtotal" : "$tmpsubtotal",
        "total" : "${tsestkt.tkttotal}",
        "tax" : "${tsestkt.tkttax}",
        "cash" : "${tsestkt.tktcash}",
        "cashchg" : "${tsestkt.tktchange}",
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
      };
    if (tsestkt.needsave > 0) {
      logError("saving Tkt: $tsesidx $tmptkttotal ${tsestkt.tktcash} ${tsestkt.tktchange}...");
      http.post(tkteditPosEndPoint, body: postdata, headers: posthdr ).then((result) {
          if (result.statusCode == 200) {
            var resary = jsonDecode(result.body);
            if (resary['status'] > 0) {
                setState(() {
                  cursess[tsesidx].id=resary['data']['id'];
                  cursess[tsesidx].needsave = 0;
                  cursess[tsesidx].lastsaved = DateTime.now();
                  tsestkt.detail.asMap().forEach((sindex,sdetprod) => saveSessTktDet(sindex,sdetprod,cursess[tsesidx].id,tsestkt,tsesidx));                  
                });
                var tmpsavedtime = df.format(cursess[tsesidx].lastsaved);
                logError("$tsesidx saved, $tmpsavedtime ");
                KeyboardUtil.hideKeyboard(context);
            } else if (resary['status'] == -1) {
               
            } else {
              
            }
          } else {
            throw Exception(productSaveErrMessage);
          }
      }).catchError((error) {});
    } else {
      var tmplastsaved = df.format(tsestkt.lastsaved);
      logError("Tkt saved: $tsesidx $tmptkttotal ${tsestkt.tktcash} ${tsestkt.tktchange} last saved: $tmplastsaved ");
    }
  }

  void saveSessTktDet(sindex,Product sdetprod,tsestktid,tsestkt,tsesidx) {
    final df = DateFormat('yyyy-MM-dd hh:mm:ss');
    var tmptax = sdetprod.prodpricesell * sdetprod.pickitm * (sdetprod.prodtaxrate/100);
    var tmpsubtotal = sdetprod.prodpricesell * sdetprod.pickitm + tmptax;
    var tmplastupd = df.format(tsestkt.lastupd);
    var tmpcreated = df.format(tsestkt.created);
    var tmptktdetid = -1; // always refresh tkt details
    var postdata = {
        "id" : "$tmptktdetid",
        "tkt_id" : "$tsestktid", 
        "sess_id" : possess['id'].toString(),
        "prod_id" : "${sdetprod.id}",
        "prd_name" : sdetprod.prodname,
        "quantity" : "${sdetprod.pickitm}",
        "price" : "${sdetprod.prodpricesell}",
        "tax" : "$tmptax",
        "note" : "POS added",
        "subtotal" : "$tmpsubtotal",
        "created" : tmpcreated,
        "modified" : tmplastupd,
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
      };
    http.post(deteditPosEndPoint, body: postdata, headers: posthdr ).then((result) {
        if (result.statusCode == 200) {
          var resary = jsonDecode(result.body);
          if (resary['status'] > 0) {
              setState(() {
                cursess[tsesidx].detail[sindex]=Product.fromJsonDet(resary['data']);
                cursess[tsesidx].detail[sindex].detid=resary['data']['id'];
              });
              KeyboardUtil.hideKeyboard(context);
          } else if (resary['status'] == -1) {
             
          } else {
            
          }
        } else {
          throw Exception(productSaveErrMessage);
        }
    }).catchError((error) {});
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
                      var postdata = {
                          "id" : possess['id'].toString(),
                          "pos_id" : struser['id'].toString(), 
                          "is_working" : "0",
                          "is_break" : "0",
                          "is_close" : "1",
                        };
                      var posthdr = {
                          'Accept': 'application/json',
                          'Authorization' : 'Bearer $usertoken'
                        };
                      http.post(editsessPosEndPoint, body: postdata, headers: posthdr ).then((result) {
                          if (result.statusCode == 200) {
                            var resary = jsonDecode(result.body);
                            if (resary['status'] > 0) {
                              hideCashDialog(context);
                              setState(() {});
                              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                            } else if (resary['status'] == -1) {
                              
                            } else {
                              
                            }
                          } else {
                            throw Exception(productSaveErrMessage);
                          }
                      }).catchError((error) {});
                  },
                ),
              ],
            );
          },
        );
    },
  );
}

  showSessSaveDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Form(
                    key: _cashformKey,
                    child: AlertDialog(
                    title: Text(cashSaveAlertTxt),
                    actions: <Widget>[
                        Column(
                          children: [
                            SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                            Row(
                              children: [
                                FuncButton100(text: lblContinue, state: btnPosStateCashContinue,
                                  press: () {
                                      hideSessSaveDialog(context);
                                      setState(() {
                                        
                                      });
                                  },
                                ),
                              ],
                            ),
                          ]
                        ),
                    ],
                  ),
              );
            },
          );
      },
    );
  }

  void loadBtnPress() {
    if (cursess.isNotEmpty) {
      setState(() {
        curtktid = cursessid;
        curtkt = cursess[curtktid];
        curtktdet = cursess[curtktid].detail;
        curtkttotal = cursess[curtktid].tkttotal;
        curtkttax = cursess[curtktid].tkttax ;
        doUpdateTktNbr();
      });
    }
  }

  void cashBtnPress() {
    setState(() {
      if (curtktdet.isNotEmpty) {
        curtkt.detail = curtktdet;
        curtkt.lastupd = DateTime.now();
        curtkt.tkttotal = curtkttotal;
        curtkt.tkttax = curtkttax;
        curtkt.tktcash = curtkttotal;
        curtkt.tktchange = 0.0;
        cursess[curtktid]=curtkt;
        tktcash = curtkttotal;
        curtktcash = curtkttotal;
        curtktchange = 0;
        cashAlertTxt = txtCashAlertTax + posCcy.format(curtkttax) + ' ' + thestore['currency'] + 
                        txtCashAlertTot + posCcy.format(curtkttotal) + ' ' + thestore['currency'] ;
        tktcashTxtCtrl.text = posCcy.format(curtkttotal) + ' ' + thestore['currency'] ; 
        tktcashchangeTxtCtrl.text = posCcy.format(curtktchange) + ' ' + thestore['currency'] ;
        _focusNodeCash.requestFocus();
        btnPosStateCash = true;
        doUpdateTktNbr();
        showCashDialog(context);
      } else {
        btnPosStateCash = false;
      }
    });
  }

  void changeBtnPress() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        if (btnPosStateChange && btnPosStateKeyb) {
          curtktdet[curtktdetid].pickitm = int.tryParse(prodItmTxtCtrl.text)!;
        }
        btnPosStateChange = !btnPosStateChange;
      });
      if (curtktdet.isNotEmpty) {
        prodItmTxtCtrl.text = curtktdet[curtktdetid].pickitm.toString();
      }
      doUpdateTktNbr();
      KeyboardUtil.hideKeyboard(context);
      _focusNodeChg.requestFocus();
    }
  }

  void enterBtnPress() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      curprodcode = prodcode;
      doPOSProdCode();
      KeyboardUtil.hideKeyboard(context);
      _focusNode.requestFocus();
    }
  }

  void deleteBtnPress() {
    if (curtktdet.isNotEmpty) {
      setState(() {
        curtktdet.removeAt(curtktdetid);
        curtktdetid = curtktdet.length;
      });
      doUpdateTktNbr();
    }
  }

  void scanBtnPress() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      _focusNode.requestFocus();
      scanProdBarcode();
    }
  }

  Future<void> scanProdBarcode() async {
    String barcodeScanRes;
      try {
        barcodeScanRes = await FlutterBarcodeScanner.scanBarcode("#ff6666", txtBcodeCancel, true, ScanMode.DEFAULT);
      } on PlatformException {
        barcodeScanRes = txtBcodeScanErr;
      }
      if (!mounted) return;
      setBcodePcodevalue(barcodeScanRes);
  }

  setBcodePcodevalue(String barcode) {
      setState(() {
        curprodcode = barcode.trim();
        if (curprodcode != '-1') {
          prodcode = curprodcode;
          prodCodeTxtCtrl.text = curprodcode;
          doPOSProdCode();
          playBeepSound();
        }
      });
  }

  playBeepSound() {
    Audio.load('assets/sounds/beep-read-02.mp3')..play()..dispose();
  }

  void scanSBtnPress() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      KeyboardUtil.hideKeyboard(context);
      _focusNode.requestFocus();
      scanProdBarcodeS();
    }
  }

  Future<void> scanProdBarcodeS() async {
    String barcodeScanRes;
      try {
        FlutterBarcodeScanner.getBarcodeStreamReceiver('#ff6666', txtBcodeCancel, true, ScanMode.BARCODE)!.listen((barcode) => setBcodePcodevalueS(barcode));
      } on PlatformException {
        barcodeScanRes = txtBcodeScanErr;
        logError(barcodeScanRes);
      }
  }

  setBcodePcodevalueS(String barcode) {
      setState(() {
        curprodcode = barcode.trim();
        if (curprodcode != '-1') {
          prodcode = curprodcode;
          prodCodeTxtCtrl.text = curprodcode;
          logError(curprodcode);
          doPOSProdCode();
          playBeepSound();
        }
      });
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

  Widget getTktItems()
  {
    setState(() {
      
    });
    if (null != prodbycode && curtktdet.isNotEmpty) {
      return _tktIemsListView(curtktdet);
    } else {
      return const Text("");
    }
  }

  ListView _tktIemsListView(data) {
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(getProportionateScreenHeight(3)),
          itemCount: data.length,
          itemBuilder: (context, index) {
            int pickitems = data[index].pickitm;
            double prodprice = data[index].prodpricesell;
            double prodtax = (pickitems*prodprice * (data[index].prodtaxrate/100));
            double subtotal = ((pickitems*prodprice) + prodtax);
            int stockunits = data[index].stockunits;
            String currency = thestore['currency'];
            final String subtotaltext = txtTktItmTax + posCcy.format(prodtax) + ' ' + currency + txtTktItmSub + posCcy.format(subtotal) + ' ' + currency ;
            final String subtitletext = txtTktItmPrice + posCcy.format(prodprice) + ' ' + currency + ' X ' + pickitems.toString();
            return _tkttile(index, data[index].prodname, subtitletext , 
              subtotaltext , Icons.card_giftcard, data[index].prodactive , data[index].prodico, data[index].prodimga, stockunits);
          },
        );
  }

  ListTile _tkttile(int index, String title, String subtitle, String catslug, IconData icon, prodactive, prodico, prodimga, stockunits) => ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(14), color: (index == curtktdetid)? kPosDetColorSel : kPosDetColor)),
        subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (index == curtktdetid)? kPosDetColorSel : kPosDetColor)),
        trailing: Text(catslug,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: getProportionateScreenHeight(14),
              color: (index == curtktdetid)? kPosDetColorSel : kPosDetColor,
            )),
        contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5), horizontal: getProportionateScreenWidth(10)),
        dense:true,
        onTap: () => picktktitem(index),
  );


  Widget getSessTkts()
  {
    setState(() {});
    if (cursess.isNotEmpty) {
      return _sessTktsListView(cursess);
    } else {
      return const Text("");
    }
  }

  ListView _sessTktsListView(data) {
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(getProportionateScreenHeight(3)),
          itemCount: data.length,
          itemBuilder: (context, index) {
            String tmptkttotal = txtTktListTot + posCcy.format(data[index].tkttotal) + ' ' + thestore['currency'];
            String tmptkttax = txtTktListTax + posCcy.format(data[index].tkttax) + ' ' + thestore['currency'];
            String timetxt = DateFormat.yMd().add_jms().format(data[index].lastupd) + '\n' + DateFormat.yMd().add_jms().format(data[index].created);
            return _sesstile(index, tmptkttotal , tmptkttax , timetxt , Icons.card_giftcard, tmptkttotal , tmptkttax); 
          },
        );
  }

  ListTile _sesstile(int index, String title, String subtitle, String catslug, IconData icon, tkttotal, tkttax) => ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(14), color: (index == cursessid)? kPosDetColorSel : kPosDetColor)),
        subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (index == cursessid)? kPosDetColorSel : kPosDetColor)),
        trailing: Text(catslug,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: getProportionateScreenHeight(14),
              color: (index == cursessid)? kPosDetColorSel : kPosDetColor,
            )),
        contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5), horizontal: getProportionateScreenWidth(10)),
        dense:true,
        onTap: () => picksessitem(index),
  );


  productqry() {
    var postdata = {
        "qrymode": 'by_id',
        "id": "$curprodid",
        "mobapp" : mobAppVal,
        "store_id" : "${thestore['id']}", 
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
        };
    showAlertDialog(context);
    http.post(
        prodqryPosEndPoint, 
        body: postdata,
        headers: posthdr
      ).then((result) {
          hideAlertDialog(context);
          if (result.statusCode == 200) {
            var resary = jsonDecode(result.body);
            setState(() {
              admcurprod = resary['data'];
              admcurprodid = resary['data']['id'];
              curprodactive = (resary['data']['active'] > 0)? true:false;
            });
          } else {
            throw Exception(kstoreqryErr);
          }
      }).catchError((error) {});
  }

  doPOSProdCode() {
    curprod = null;
    if (null == prodbycode) {
      doPOSProdQryAllCode();
    } else {
      if (prodbycode.containsKey(prodcode)) {
        setState(() {
          curprod = prodbycode[prodcode];
          curprodcode = prodcode;
          curprodid = curprod['id'];
          prodCodeTxtCtrl.text = '';
          curprod['pickitm'] = curpickitm;
          curprod['detid'] = -1 ;
          curtktdet.add(Product.fromArray(curprod));
          doUpdateTktNbr();
        });
      } else {
        logError("product not exist!");
      }
    }
    if (null == prodbyid) {
      doPOSProdQryAllId();
    }
    if (null == prodbycode) {
      var postdata = {
        "qrymode": "by_prodcode",
        "prod_code": prodcode,
        "mobapp": mobAppVal,
      };
      var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
      };
      showAlertDialog(context);
      setState(() {btnPosStateEnter = true;});
      http.post(prodqryPosEndPoint, body: postdata, headers: posthdr).then((result) {
        hideAlertDialog(context);
        setState(() {btnPosStateEnter = false;});
        if (result.statusCode == 200) {
          var resary = jsonDecode(result.body);

          setState(() {
            curprod = resary['data'];
            curprodid = curprod['id'];
            logError(curprod);
          });

          
        } else {
          throw Exception(kPosApiDataError);
        }
      }).catchError((error) {});
    }

  }

  doPOSProdQryAllCode() {
    var postdata = {
      "qrymode": "allbycode",
      "store_id": "${thestore['id']}",
      "mobapp": mobAppVal,
    };
    var posthdr = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer $usertoken'
    };
    showAlertDialog(context);
    setState(() {btnPosStateEnter = true;});
    http.post(prodqryPosEndPoint, body: postdata, headers: posthdr).then((result) {
      hideAlertDialog(context);
      setState(() {btnPosStateEnter = false;});
      if (result.statusCode == 200) {
        var resary = jsonDecode(result.body);
        setState(() {
          prodbycode = resary['data'];
        });
      } else {
        throw Exception(kPosApiDataError);
      }
    }).catchError((error) {});
  }

  doPOSProdQryAllId() {
    var postdata = {
      "qrymode": "allbyid",
      "store_id": "${thestore['id']}",
      "mobapp": mobAppVal,
    };
    var posthdr = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer $usertoken'
    };
    showAlertDialog(context);
    setState(() {btnPosStateEnter = true;});
    http.post(prodqryPosEndPoint, body: postdata, headers: posthdr).then((result) {
      hideAlertDialog(context);
      setState(() {btnPosStateEnter = false;});
      if (result.statusCode == 200) {
        var resary = jsonDecode(result.body);
        setState(() {
          prodbyid = resary['data'];
        });
      } else {
        throw Exception(kPosApiDataError);
      }
    }).catchError((error) {});
  }

  Container buildProdCodeFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth * (3/4),
      color: kPosBaseColor,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth * (3/4),
        ),
        child: TextFormField(
          autofocus: true,
          controller: prodCodeTxtCtrl,
          keyboardType: TextInputType.number,
          obscureText: false,
          readOnly: true,
          onTap: () {
            setState(() {
              btnPosStateChange = false;
            });
          },
          onSaved: (newValue) => prodcode = newValue!,
          onChanged: (value) {
            prodcode = value;
            return;
          },
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblProdCodeText,
            hintText: hintProdCodeText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

  Container buildPickItmFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth/2,
      color: kPosBaseColor,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth/2,
        ),
        child: TextFormField(
          autofocus: false,
          controller: prodItmTxtCtrl,
          keyboardType: TextInputType.number,
          obscureText: false,
          readOnly: true,
          onTap: () {
            setState(() {
              btnPosStateChange = true;
            });
          },
          onSaved: (newValue) => curpickitm = int.tryParse(newValue!)!,
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kPosPickItmNullErr);
            }
            curpickitm = int.tryParse(value)!;
            return;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kPosPickItmNullErr);
              return "";
            }
            return null;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblPickItmsText,
            hintText: hintPickItmsText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

  showCashDialog(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Form(
                    key: _cashformKey,
                    child: AlertDialog(
                    title: Text(cashAlertTxt),
                    actions: <Widget>[
                        Column(
                          children: [
                            SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: DefaultTextStyle(
                                    style: textTheme.headline4!,
                                    child: buildCashChangeFormField(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: DefaultTextStyle(
                                    style: textTheme.headline4!,
                                    child: RawKeyboardListener(
                                      focusNode: _focusNodeCash,
                                      onKey: _handleKeyEvent,
                                      child: buildCashFormField(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                            Row(
                              children: [
                                FuncButton100(text: lblContinue, state: btnPosStateCashContinue,
                                  press: () {
                                      hideCashDialog(context);
                                      setState(() {
                                        
                                        var bkcashPrintHdrTxt = cashPrintHdrTxt;
                                        var bkcashPrintBodyTxt = cashPrintBodyTxt;
                                        var bkcashPrintFooterTxt = cashPrintFooterTxt;
                                        var bktxtCashPrnBdyThks = txtCashPrnBdyThks;

                                        btnPosStateCash = false;
                                        prodItmTxtCtrl.text = '1';
                                        if (curtktdet.isNotEmpty && curtktid == (cursess.length-1)) {
                                          curtktid = cursess.length;
                                          cursessid = curtktid;
                                          curtktdet = <Product>[];
                                          curtkt = new Ticket.fromArray([curtktid,curtktid,curtktdet,new DateTime.now(),new DateTime.now(),0.0,0.0,0.0,0.0,new DateTime.now(),1]);
                                          cursess.add(curtkt);
                                          doUpdateTktNbr();
                                        }

                                        readLogoPdf();
                                        final printttf = pw.Font.ttf(printfont);
                                        doc = pw.Document();
                                        doc.addPage(pw.Page(
                                              pageFormat: PdfPageFormat.roll80,
                                              build: (pw.Context pcontext) {
                                                return pw.Center(
                                                  child: pw.Column(
                                                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                                                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                    children: 
                                                      <pw.Widget>[
                                                          pw.ClipRect(child: pw.Container(width: 60,height: 60,child: pw.Image(pw.MemoryImage(assetLogoATC)))),
                                                          pw.Center(child: pw.Text(bkcashPrintHdrTxt, style: pw.TextStyle(font: printttf, fontSize: 12))),
                                                          pw.Center(child: pw.Text(bkcashPrintBodyTxt, style: pw.TextStyle(font: printttf, fontSize: 10))),
                                                          pw.Center(child: pw.Text(bkcashPrintFooterTxt, style: pw.TextStyle(font: printttf, fontSize: 14))),
                                                          pw.Center(child: pw.Text(bktxtCashPrnBdyThks, style: pw.TextStyle(font: printttf, fontSize: 16))),
                                                        ]
                                                    ),
                                                  );
                                              }));
                                        Printing.layoutPdf(onLayout: (PdfPageFormat format) => doc.save());

                                        saveByCash();

                                      });
                                  },
                                ),
                              ],
                            ),
                          ]
                        ),
                    ],
                  ),
              );
            },
          );
      },
    );
  }

  readLogoPdf() async {
    if (logoPdfLoaded == false) {
      final ByteData logoATCbytes = await rootBundle.load('assets/images/BTT-Logo_09.png');
      assetLogoATC = logoATCbytes.buffer.asUint8List();
      logoPdfLoaded = true;
    }
  }

  Container buildCashChangeFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth * (2/3),
      color: Colors.white,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth * (2/3),
        ),
        child: TextFormField(
          autofocus: false,
          controller: tktcashchangeTxtCtrl,
          keyboardType: TextInputType.number,
          obscureText: false,
          readOnly: true,
          onTap: () {
            
          },
          onSaved: (newValue) => tktcash = double.tryParse(newValue!)!,
          onChanged: (value) {
            return;
          },
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblCashChangeText,
            hintText: hintCashChangeText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

  Container buildCashFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth * (2/3),
      color: Colors.white,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth * (2/3),
        ),
        child: TextFormField(
          autofocus: false,
          controller: tktcashTxtCtrl,
          keyboardType: TextInputType.number,
          obscureText: false,
          readOnly: true,
          onTap: () {
            
          },
          onSaved: (newValue) => tktcash = double.tryParse(newValue!)!,
          onChanged: (value) {
            setState(() {
            });
            return;
          },
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblCashText,
            hintText: hintCashText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

  void setupBtnPress() {
    
      setState(() {
        btnPosStateSetup = true;
      });
      showSetupDialog(context);
    
  }

  btnStateSetupContinuePress() {
      setState(() {
        btnPosStateSetup = false;
      });
  }

  showSetupDialog(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Form(
                    key: _startcashformKey,
                    child: AlertDialog(
                    title: Text(startCashAlertTxt),
                    actions: <Widget>[
                        Column(
                          children: [
                            SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: DefaultTextStyle(
                                    style: textTheme.headline4!,
                                    child: RawKeyboardListener(
                                          focusNode: _focusNodeSetup,
                                          onKey: _handleKeyEvent,
                                          child: buildStartCashFormField(),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                            Row(
                              children: [
                                FuncButton100(text: lblContinue, state: btnPosStateSetupContinue,
                                  press: () {
                                      final df = DateFormat('yyyy-MM-dd hh:mm:ss');
                                      var tmptimestart = df.format(DateTime.now());
                                      var postdata = {
                                          "id" : possess['id'].toString(),
                                          "pos_id" : struser['id'].toString(), 
                                          "is_working" : "1",
                                          "is_break" : "0",
                                          "is_close" : "0",
                                          "startcash" : "$sessstartcash",
                                          "timestart" : tmptimestart,
                                        };
                                      var posthdr = {
                                          'Accept': 'application/json',
                                          'Authorization' : 'Bearer $usertoken'
                                        };
                                        
                                      http.post(editsessPosEndPoint, body: postdata, headers: posthdr ).then((result) {
                                          if (result.statusCode == 200) {
                                            var resary = jsonDecode(result.body);
                                            if (resary['status'] > 0) {
                                              btnStateSetupContinuePress();
                                              hideCashDialog(context);
                                            } else if (resary['status'] == -1) {
                                              
                                            } else {
                                              
                                            }
                                          } else {
                                            throw Exception(productSaveErrMessage);
                                          }
                                      }).catchError((error) {});

                                  },
                                ),
                              ],
                            ),
                          ]
                        ),
                    ],
                  ),
              );
            },
          );
      },
    );
  }


  Container buildStartCashFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth * (2/3),
      color: Colors.white,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth * (2/3),
        ),
        child: TextFormField(
          autofocus: false,
          controller: sessstartcashTxtCtrl,
          keyboardType: TextInputType.number,
          obscureText: false,
          readOnly: true,
          onTap: () {
            
          },
          onSaved: (newValue) => sessstartcash = double.tryParse(newValue!)!,
          onChanged: (value) {
            setState(() {
            });
            return;
          },
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblStartCashText,
            hintText: hintStartCashText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }



}
