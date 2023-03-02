// import 'dart:io';

import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:pdf/pdf.dart';
// import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; 
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/app_globals.dart';
// import 'package:storeoperations_app/helper/keyboard.dart';
import 'package:storeoperations_app/components/default_button.dart';
import 'package:storeoperations_app/components/custom_surfix_icon.dart';
// import 'package:new_virtual_keyboard/virtual_keyboard.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:audiofileplayer/audiofileplayer.dart';

class RetailKitchenMainBody extends StatefulWidget {

  const RetailKitchenMainBody({Key? key}) : super(key: key);

  @override
  _RetailKitchenMainBody createState() => _RetailKitchenMainBody();

}

class _RetailKitchenMainBody extends State<RetailKitchenMainBody> with AfterLayoutMixin<RetailKitchenMainBody> {

  final _formKey = GlobalKey<FormState>();
  final _cashformKey = GlobalKey<FormState>();
  String prodcode ='';
  final List<String> errors = [];
  final FocusNode _focusNode = FocusNode();
  pw.Document doc = pw.Document();
  late ByteData printfont;
  // final List<String> _numericchars = ['0','1','2','3','4','5','6','7','8','9',',','.'];
  late Uint8List assetLogoATC;
  bool logoPdfLoaded = false;

  loadPrintFont() async {
    printfont = await rootBundle.load("assets/fonts/open-sans/OpenSans-Regular.ttf");
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    // final TextTheme textTheme = Theme.of(context).textTheme;
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
                            Column(
                              children: [
                                SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                              ],
                            ),
                            SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)), 
                            Column(
                              children: [
                                SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
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
                            children: [
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: <Widget>[
                                    Text(txtRetailKitchenTitle,style: TextStyle(fontSize: getProportionateScreenWidth(39),color: kPrimaryColor,fontWeight: FontWeight.bold,),),
                                    Image.asset("assets/images/BTT-Logo_09.png",height: pct10ScrlHei,width: pct10ScrlWid,),
                                  ],
                                ),
                                SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                                Column(
                                  children: <Widget>[
                                    Text(thestore['store_name'],style: TextStyle(fontSize: getProportionateScreenWidth(19),color: kPosNameColor,fontWeight: FontWeight.normal,),),
                                    Text(struser['usr_name'],style: TextStyle(fontSize: getProportionateScreenWidth(19),color: kPosNameColor,fontWeight: FontWeight.normal,),),
                                    Text(struser['name'],style: TextStyle(fontSize: getProportionateScreenWidth(16),color: kPosNameColor,fontWeight: FontWeight.normal,),),
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
                        padding: EdgeInsets.all(defTxtInpEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: pct77ScrlHei,
                          ),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(children: [
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
                          height: pct77ScrlHei,
                          color: kPosBaseColor,
                          padding: EdgeInsets.all(defTxtInpEdge),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: halfScrlWid,
                              maxHeight: pct77ScrlHei,
                            ),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  ],
                                ),
                            ),
                          ),
                        ),  
                      ],
                    ),
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
      
    });
  }

  var shiftEnabled = false;

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

    });
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
                          "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
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
        "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
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


  doPOSProdQryAllCode() {
    var postdata = {
      "qrymode": "allbycode",
      "store_id": "${thestore['id']}",
      "mobapp": mobAppVal,
      "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
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
      "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
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







}
