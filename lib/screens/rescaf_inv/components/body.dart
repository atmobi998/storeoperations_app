// import 'dart:io';

import 'dart:convert';
import 'dart:async';
// import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:pdf/pdf.dart';
// import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; 
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/screens/store_functions/store_funcs_screen.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/app_globals.dart';
// import 'package:storeoperations_app/helper/keyboard.dart';
import 'package:storeoperations_app/components/default_button.dart';
import 'package:storeoperations_app/components/custom_surfix_icon.dart';
// import 'package:new_virtual_keyboard/virtual_keyboard.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:storeoperations_app/screens/rescaf_inv/components/product_list.dart';
import 'package:storeoperations_app/screens/rescaf_inv/components/stock_in.dart';
import 'package:storeoperations_app/screens/rescaf_inv/components/stock_out.dart';

class ResCafInvMainBody extends StatefulWidget {

  const ResCafInvMainBody({Key? key}) : super(key: key);

  @override
  _ResCafInvMainBody createState() => _ResCafInvMainBody();

}

class _ResCafInvMainBody extends State<ResCafInvMainBody> with AfterLayoutMixin<ResCafInvMainBody> {

final _formKey = GlobalKey<FormState>();
final _prodscafoldKey = GlobalKey<FormState>();
String prodcode ='';
final List<String> errors = [];
final FocusNode _focusNode = FocusNode();
pw.Document doc = pw.Document();
late ByteData printfont;
late Uint8List assetLogoATC;
bool logoPdfLoaded = false;
Timer? timer;
Timer? timerProdUpd;
int itmaddquantity = 1;
String itmaddcomment = '';
bool needkitchen = true;
bool needinventory = false;

@override
void dispose() {
  timer?.cancel();
  timerProdUpd?.cancel();
  _focusNode.dispose();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  super.dispose();
}

@override
void initState() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  super.initState();
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
                      height: pct12ScrlHei,
                      color: kPosBaseColor,
                      padding: EdgeInsets.all(defTxtInpEdge),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: halfScrlWid,
                          maxHeight: pct12ScrlHei,
                        ),
                        child: Row(
                          children: [
                              SizedBox(width: getProportionateScreenWidth(defFormFieldEdges05)),
                              Column(
                                children: <Widget>[
                                  Text(txtResCafInvTitle,style: TextStyle(fontSize: getProportionateScreenWidth(18),color: kPrimaryColor,fontWeight: FontWeight.bold)),
                                  Text(thestore['store_name'],style: TextStyle(fontSize: getProportionateScreenWidth(14),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                  Text(struser['name'],style: TextStyle(fontSize: getProportionateScreenWidth(14),color: kPosNameColor,fontWeight: FontWeight.normal)),
                                ],
                              ),
                              SizedBox(width: getProportionateScreenWidth(defFormFieldEdges20)),
                              FuncButton100(text: lblBack, state: btnStateResCafBack,
                                press: () {
                                  Navigator.pushNamed(context, StoreFuncMainScreen.routeName);
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(defFormFieldEdges20)),
                              FuncButton100(text: lblStockIn, state: btnStateResCafStkIn,
                                press: () {
                                  showStkInDialog(context);  
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(defFormFieldEdges20)),
                              FuncButton100(text: lblStockOut, state: btnStateResCafStkOut,
                                press: () {
                                  showStkOutDialog(context);  
                                },
                              ),
                            ]),
                      ),
                    ),
                  ]),
                  Column(children: [
                    Container(
                        width: halfScrlWid,
                        height: pct12ScrlHei,
                        color: kPosBaseColor,
                        padding: EdgeInsets.all(defTxtInpEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: pct12ScrlHei,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton100(
                                    state: btnStateInvAccept,
                                    text: txtResCafAcceptItem,
                                    press: () {
                                      if (btnStateInvAccept) {
                                        acceptItem();
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)), 
                              Column(
                                children: [
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  FuncButton100(
                                    state: btnStateInvDone,
                                    text: txtResCafDoneItem,
                                    press: () {
                                      if (btnStateInvDone) {
                                        doneItem();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ]),
                ]),
                Row(children: [
                  Column(children: [
                    Container(
                        width: halfScrlWid*2*(1/4),
                        height: pct85ScrlHei,
                        color: kPosBaseColor,
                        padding: EdgeInsets.all(defTxtInpEdge),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: halfScrlWid,
                            maxHeight: pct85ScrlHei,
                          ),
                          child: SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(children: [
                                  SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                  getTablesList(),
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
                          width: halfScrlWid*2*(3/4),
                          height: pct85ScrlHei,
                          color: kPosBaseColor,
                          padding: EdgeInsets.all(defTxtInpEdge),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: halfScrlWid,
                              maxHeight: pct85ScrlHei,
                            ),
                            child: SingleChildScrollView(
                              physics: const ScrollPhysics(),
                              child: Column(children: [
                                    SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    getTabOrders(),
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
    readLogoPdf();
    doProdQryAll();
    updateTabs();
    setState(() {
      timer = Timer.periodic(const Duration(seconds: 6), (Timer t) => updateTabs());
      timerProdUpd = Timer.periodic(const Duration(seconds: 90), (Timer t) => doProdQryAll());
    });
  }
 
  var shiftEnabled = false;
  
  void logError(error) {
    // print(error);
  }

  void logMessage(String message) {
    // print(message);
  }

  loadPrintFont() async {
    printfont = await rootBundle.load("assets/fonts/open-sans/OpenSans-Regular.ttf");
  }

  playBeepSound() {
    Audio.load('assets/sounds/beep-read-02.mp3')..play()..dispose();
  }

  readLogoPdf() async {
    if (logoPdfLoaded == false) {
      final ByteData logoATCbytes = await rootBundle.load('assets/images/BTT-Logo_09.png');
      assetLogoATC = logoATCbytes.buffer.asUint8List();
      logoPdfLoaded = true;
    }
  }

  dateFmtLong(DateTime dtstring) {
    return DateFormat.yMd().add_jms().format(dtstring);
  }

  ccyFormat(double amount) {
    return posCcy.format(amount) + ' ' + thestore['currency'];
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

  doProdQryAll() {
    List<ResCafProduct> tmprescafprods = [];
    var postdata = {
      "qrymode": "allbystore",
      "store_id": "${thestore['id']}",
      "mobapp": mobAppVal,
      "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
    };
    var posthdr = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer $usertoken'
    };
    // showAlertDialog(context);
    http.post(prodqryPosEndPoint, body: postdata, headers: posthdr).then((result) {
      // hideAlertDialog(context);
      if (result.statusCode == 200) {
        var resary = jsonDecode(result.body);
        setState(() {
          resary['data'].asMap().forEach((i, v) {
            tmprescafprods.add(ResCafProduct.fromJsonDet(v));
          });
          tmprescafprods.asMap().forEach((pk, pv) {
            if (rescafprods.where((prodelem) => (prodelem.id == pv.id)).isNotEmpty) {
              syncProdList(pv,rescafprods.indexWhere((prodelem) => (prodelem.id == pv.id)));
            } else {
              rescafprods.add(pv);
            }
          });
        });
        // logMessage(rescafprods.toString());
      } else {
        throw Exception(kPosApiDataError);
      }
    }).catchError((error) {
      // logError(error);
    });
  }

  syncProdList(ResCafProduct fromProd, int toProdIdx) {
    setState(() {
      rescafprods[toProdIdx].id = fromProd.id;
      rescafprods[toProdIdx].storeid = fromProd.storeid;
      rescafprods[toProdIdx].storename = fromProd.storename;
      rescafprods[toProdIdx].catid = fromProd.catid;
      rescafprods[toProdIdx].catname = fromProd.catname;
      rescafprods[toProdIdx].prodname = fromProd.prodname;
      rescafprods[toProdIdx].prodcode = fromProd.prodcode;
      rescafprods[toProdIdx].prodslug = fromProd.prodslug;
      rescafprods[toProdIdx].proddesc = fromProd.proddesc;
      rescafprods[toProdIdx].prodsort = fromProd.prodsort;
      rescafprods[toProdIdx].prodico = fromProd.prodico;
      rescafprods[toProdIdx].prodimga = fromProd.prodimga;
      rescafprods[toProdIdx].prodimgb = fromProd.prodimgb;
      rescafprods[toProdIdx].prodimgc = fromProd.prodimgc;
      rescafprods[toProdIdx].prodpricesell = fromProd.prodpricesell;
      rescafprods[toProdIdx].prodpricebuy = fromProd.prodpricebuy;
      rescafprods[toProdIdx].prodtaxrate = fromProd.prodtaxrate;
      rescafprods[toProdIdx].prodactive = fromProd.prodactive;
      rescafprods[toProdIdx].stockunits = fromProd.stockunits;
      rescafprods[toProdIdx].minstock = fromProd.minstock;
    });
  }

  syncTabOrder(RescafOrder fromOrd, int rescaftab, int tabidx) {
    setState(() {
      strtabs[rescaftab].orders[tabidx].id=fromOrd.id;
      strtabs[rescaftab].orders[tabidx].storeid=fromOrd.storeid;
      strtabs[rescaftab].orders[tabidx].storename=fromOrd.storename;
      strtabs[rescaftab].orders[tabidx].detail=fromOrd.detail;
      strtabs[rescaftab].orders[tabidx].sessid=fromOrd.sessid;
      strtabs[rescaftab].orders[tabidx].posid=fromOrd.posid;
      strtabs[rescaftab].orders[tabidx].frontid=fromOrd.frontid;
      strtabs[rescaftab].orders[tabidx].kitchenid=fromOrd.kitchenid;
      strtabs[rescaftab].orders[tabidx].invid=fromOrd.invid;
      strtabs[rescaftab].orders[tabidx].secposid=fromOrd.secposid;
      strtabs[rescaftab].orders[tabidx].secfrontid=fromOrd.secfrontid;
      strtabs[rescaftab].orders[tabidx].seckitid=fromOrd.seckitid;
      strtabs[rescaftab].orders[tabidx].secinvid=fromOrd.secinvid;
      strtabs[rescaftab].orders[tabidx].rescaf=fromOrd.rescaf;
      strtabs[rescaftab].orders[tabidx].rescaftab=fromOrd.rescaftab;
      strtabs[rescaftab].orders[tabidx].rescaftake=fromOrd.rescaftake;
      strtabs[rescaftab].orders[tabidx].itemcount=fromOrd.itemcount;
      strtabs[rescaftab].orders[tabidx].subtotal=fromOrd.subtotal;
      strtabs[rescaftab].orders[tabidx].tax=fromOrd.tax;
      strtabs[rescaftab].orders[tabidx].total=fromOrd.total;
      strtabs[rescaftab].orders[tabidx].cash=fromOrd.cash;
      strtabs[rescaftab].orders[tabidx].cashchg=fromOrd.cashchg;
      strtabs[rescaftab].orders[tabidx].shipfee=fromOrd.shipfee;
      strtabs[rescaftab].orders[tabidx].status=fromOrd.status;
      strtabs[rescaftab].orders[tabidx].rescafcheckout=fromOrd.rescafcheckout;
      strtabs[rescaftab].orders[tabidx].rescafcheckoutlog=fromOrd.rescafcheckoutlog;
      strtabs[rescaftab].orders[tabidx].rescafpaid=fromOrd.rescafpaid;
      strtabs[rescaftab].orders[tabidx].rescafpaidlog=fromOrd.rescafpaidlog;
      strtabs[rescaftab].orders[tabidx].shipped=fromOrd.shipped;
    });
  }

  syncDetData(RescafOrdProd fromProd, int detidx) {
    setState(() {
      strtabordprods[detidx].id = fromProd.id;
      strtabordprods[detidx].orderid = fromProd.orderid;
      strtabordprods[detidx].prodid = fromProd.prodid;
      strtabordprods[detidx].prodcode = fromProd.prodcode;
      strtabordprods[detidx].prdname = fromProd.prdname;
      strtabordprods[detidx].quantity = fromProd.quantity;
      strtabordprods[detidx].price = fromProd.price;
      strtabordprods[detidx].tax = fromProd.tax;
      strtabordprods[detidx].subtotal = fromProd.subtotal;
      strtabordprods[detidx].kitchenneed = fromProd.kitchenneed;
      strtabordprods[detidx].kitchenaccept = fromProd.kitchenaccept;
      strtabordprods[detidx].kitchendone = fromProd.kitchendone;
      strtabordprods[detidx].kitchenstatus = fromProd.kitchenstatus;
      strtabordprods[detidx].kitchenid = fromProd.kitchenid;
      strtabordprods[detidx].invneed = fromProd.invneed;
      strtabordprods[detidx].invaccept = fromProd.invaccept;
      strtabordprods[detidx].invdone = fromProd.invdone;
      strtabordprods[detidx].invstatus = fromProd.invstatus;
      strtabordprods[detidx].invid = fromProd.invid;
      strtabordprods[detidx].delivered = fromProd.delivered;
      strtabordprods[detidx].frontstatus = fromProd.frontstatus;
      strtabordprods[detidx].frontid = fromProd.frontid;
      strtabordprods[detidx].rescaf = fromProd.rescaf;
      strtabordprods[detidx].rescaftab = fromProd.rescaftab;
      strtabordprods[detidx].rescaftake = fromProd.rescaftake;
      strtabordprods[detidx].secfrontid = fromProd.secfrontid;
      strtabordprods[detidx].secfrontstatus = fromProd.secfrontstatus;
      strtabordprods[detidx].seckitid = fromProd.seckitid;
      strtabordprods[detidx].seckitstatus = fromProd.seckitstatus;
      strtabordprods[detidx].secinvid = fromProd.secinvid;
      strtabordprods[detidx].secinvstatus = fromProd.secinvstatus;
      strtabordprods[detidx].secposid = fromProd.secposid;
      strtabordprods[detidx].secposstatus = fromProd.secposstatus;
      strtabordprods[detidx].created = fromProd.created;
    });
  }


  updateTabs() {
    if (strtabs.isEmpty) {
      List<RescafOrder> tmporders = [];
      RescafTable tmptable = RescafTable.fromArray([0,thestore['id'] as int,thestore['store_name'] as String,tmporders,txtResCafTabTake]);
      strtabs.add(tmptable);
      for (var tabid = 1;tabid<=thestore['rescaf_tabs']+1;tabid++) {
        List<RescafOrder> tmporders = [];
        RescafTable tmptable = RescafTable.fromArray([tabid,thestore['id'] as int,thestore['store_name'] as String,tmporders,txtResCafTabPrefix+(tabid).toString().padLeft(3,'0')]);
        strtabs.add(tmptable);
      }
    }
    var postdata = {
        "qrymode": 'all_by_store',
        "mobapp" : mobAppVal,
        "store_id" : "${thestore['id']}",
        "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
        };
    // showAlertDialog(context);
    http.post(
        rescafOrdQryEndPoint, 
        body: postdata,
        headers: posthdr
      ).then((result) {
          // hideAlertDialog(context);
          if (result.statusCode == 200) {
            var resary = jsonDecode(result.body);
            setState(() {
              strtaborders = [];
              List<RescafOrdProd> tmpchkordprods = [];
              resary['data'].asMap().forEach((i, v) {
                var tmpord = RescafOrder.fromJsonDet(v);
                if (strtabs[v['rescaf_tab']].orders.where((element) => element.id == tmpord.id).isNotEmpty) {
                  syncTabOrder(tmpord, v['rescaf_tab'], strtabs[v['rescaf_tab']].orders.indexWhere((element) => element.id == tmpord.id));
                } else {
                  strtabs[v['rescaf_tab']].orders.add(tmpord);
                }
                strtaborders.add(tmpord);
              });
              for (var tabid = 0;tabid<=thestore['rescaf_tabs']+1;tabid++) {
                strtabs[tabid].orders.removeWhere((element) => (strtaborders.where((bkelement) => bkelement.id == element.id).isEmpty));
              }
              strtaborders.asMap().forEach((oi, ov) {
                ov.detail.asMap().forEach((di, dv) {
                  if (strtabordprods.where((element) => element.id == dv.id).isNotEmpty) {
                    syncDetData(dv,strtabordprods.indexWhere((element) => element.id == dv.id));
                  } else {
                    strtabordprods.add(dv);
                  }
                  tmpchkordprods.add(dv);
                });
              });
              strtabordprods.removeWhere((element) => (tmpchkordprods.where((tmpelement) => tmpelement.id == element.id).isEmpty));
              strtabordprods.sort((b, a) => a.created.compareTo(b.created));
              List<RescafOrdProd> tmpkitordprods = strtabordprods.where((element) => (element.delivered<1 && element.kitchenneed>0)).toList();
              List<RescafOrdProd> tmpinvordprods = strtabordprods.where((element) => (element.delivered<1 && element.invneed>0)).toList();
              List<RescafOrdProd> tmpfrontordprods = strtabordprods.where((element) => (element.delivered<1)).toList();
              List<RescafOrdProd> tmpposordprods = strtabordprods.where((element) => (element.delivered<1)).toList();
              tmpkitordprods.asMap().forEach((pi, pv) {
                if (strallkitordprods.where((pelem) => pelem.id == pv.id).isNotEmpty) {
                  syncKitDetData(pv,strallkitordprods.indexWhere((elem) => elem.id == pv.id));
                } else {
                  strallkitordprods.add(pv);
                }
              });
              strallkitordprods.removeWhere((element) => (tmpkitordprods.where((tmpelement) => tmpelement.id == element.id).isEmpty));

              tmpinvordprods.asMap().forEach((pi, pv) {
                if (strallinvordprods.where((pelem) => pelem.id == pv.id).isNotEmpty) {
                  syncInvDetData(pv,strallinvordprods.indexWhere((elem) => elem.id == pv.id));
                } else {
                  strallinvordprods.add(pv);
                }
              });
              strallinvordprods.removeWhere((element) => (tmpinvordprods.where((tmpelement) => tmpelement.id == element.id).isEmpty));

              tmpfrontordprods.asMap().forEach((pi, pv) {
                if (strallfrontordprods.where((pelem) => pelem.id == pv.id).isNotEmpty) {
                  syncFrontDetData(pv,strallfrontordprods.indexWhere((elem) => elem.id == pv.id));
                } else {
                  strallfrontordprods.add(pv);
                }
              });
              strallfrontordprods.removeWhere((element) => (tmpfrontordprods.where((tmpelement) => tmpelement.id == element.id).isEmpty));

              tmpposordprods.asMap().forEach((pi, pv) {
                if (strallposordprods.where((pelem) => pelem.id == pv.id).isNotEmpty) {
                  syncPosDetData(pv,strallposordprods.indexWhere((elem) => elem.id == pv.id));
                } else {
                  strallposordprods.add(pv);
                }
              });
              strallposordprods.removeWhere((element) => (tmpposordprods.where((tmpelement) => tmpelement.id == element.id).isEmpty));

              tmpkitordprods = [];
              tmpinvordprods = [];
              tmpfrontordprods = [];
              tmpposordprods = [];

              if (rescafcurorderid>0) {
                if (strtaborders.where((oelm) => (oelm.id == rescafcurorderid)).first.rescafcheckout>0 && strtaborders.where((oelm) => (oelm.id == rescafcurorderid)).first.rescafpaid == 0) {
                  btnStateResCafPosPaid = true;
                }
                if (rescafcurtableid != 9999 && strtaborders.where((oelm) => (oelm.id == rescafcurorderid)).first.detail.isNotEmpty && strtaborders.where((oelm) => (oelm.id == rescafcurorderid)).first.detail.where((de) => de.delivered==0).isEmpty) {
                  btnStateResCafPosChkout = true;
                }
              }
              // logMessage(strtabordprods.toString());
            });
          } else {
            throw Exception(kstoreqryErr);
          }
      }).catchError((error) {
        // logError(error);
      });
  }

  syncPosDetData(RescafOrdProd fromProd, int detidx) {
    setState(() {
      strallposordprods[detidx].id = fromProd.id;
      strallposordprods[detidx].orderid = fromProd.orderid;
      strallposordprods[detidx].prodid = fromProd.prodid;
      strallposordprods[detidx].prodcode = fromProd.prodcode;
      strallposordprods[detidx].prdname = fromProd.prdname;
      strallposordprods[detidx].quantity = fromProd.quantity;
      strallposordprods[detidx].price = fromProd.price;
      strallposordprods[detidx].tax = fromProd.tax;
      strallposordprods[detidx].subtotal = fromProd.subtotal;
      strallposordprods[detidx].kitchenneed = fromProd.kitchenneed;
      strallposordprods[detidx].kitchenaccept = fromProd.kitchenaccept;
      strallposordprods[detidx].kitchendone = fromProd.kitchendone;
      strallposordprods[detidx].kitchenstatus = fromProd.kitchenstatus;
      strallposordprods[detidx].kitchenid = fromProd.kitchenid;
      strallposordprods[detidx].invneed = fromProd.invneed;
      strallposordprods[detidx].invaccept = fromProd.invaccept;
      strallposordprods[detidx].invdone = fromProd.invdone;
      strallposordprods[detidx].invstatus = fromProd.invstatus;
      strallposordprods[detidx].invid = fromProd.invid;
      strallposordprods[detidx].delivered = fromProd.delivered;
      strallposordprods[detidx].frontstatus = fromProd.frontstatus;
      strallposordprods[detidx].frontid = fromProd.frontid;
      strallposordprods[detidx].rescaf = fromProd.rescaf;
      strallposordprods[detidx].rescaftab = fromProd.rescaftab;
      strallposordprods[detidx].rescaftake = fromProd.rescaftake;
      strallposordprods[detidx].secfrontid = fromProd.secfrontid;
      strallposordprods[detidx].secfrontstatus = fromProd.secfrontstatus;
      strallposordprods[detidx].seckitid = fromProd.seckitid;
      strallposordprods[detidx].seckitstatus = fromProd.seckitstatus;
      strallposordprods[detidx].secinvid = fromProd.secinvid;
      strallposordprods[detidx].secinvstatus = fromProd.secinvstatus;
      strallposordprods[detidx].secposid = fromProd.secposid;
      strallposordprods[detidx].secposstatus = fromProd.secposstatus;
      strallposordprods[detidx].created = fromProd.created;
    });
  }

  syncFrontDetData(RescafOrdProd fromProd, int detidx) {
    setState(() {
      strallfrontordprods[detidx].id = fromProd.id;
      strallfrontordprods[detidx].orderid = fromProd.orderid;
      strallfrontordprods[detidx].prodid = fromProd.prodid;
      strallfrontordprods[detidx].prodcode = fromProd.prodcode;
      strallfrontordprods[detidx].prdname = fromProd.prdname;
      strallfrontordprods[detidx].quantity = fromProd.quantity;
      strallfrontordprods[detidx].price = fromProd.price;
      strallfrontordprods[detidx].tax = fromProd.tax;
      strallfrontordprods[detidx].subtotal = fromProd.subtotal;
      strallfrontordprods[detidx].kitchenneed = fromProd.kitchenneed;
      strallfrontordprods[detidx].kitchenaccept = fromProd.kitchenaccept;
      strallfrontordprods[detidx].kitchendone = fromProd.kitchendone;
      strallfrontordprods[detidx].kitchenstatus = fromProd.kitchenstatus;
      strallfrontordprods[detidx].kitchenid = fromProd.kitchenid;
      strallfrontordprods[detidx].invneed = fromProd.invneed;
      strallfrontordprods[detidx].invaccept = fromProd.invaccept;
      strallfrontordprods[detidx].invdone = fromProd.invdone;
      strallfrontordprods[detidx].invstatus = fromProd.invstatus;
      strallfrontordprods[detidx].invid = fromProd.invid;
      strallfrontordprods[detidx].delivered = fromProd.delivered;
      strallfrontordprods[detidx].frontstatus = fromProd.frontstatus;
      strallfrontordprods[detidx].frontid = fromProd.frontid;
      strallfrontordprods[detidx].rescaf = fromProd.rescaf;
      strallfrontordprods[detidx].rescaftab = fromProd.rescaftab;
      strallfrontordprods[detidx].rescaftake = fromProd.rescaftake;
      strallfrontordprods[detidx].secfrontid = fromProd.secfrontid;
      strallfrontordprods[detidx].secfrontstatus = fromProd.secfrontstatus;
      strallfrontordprods[detidx].seckitid = fromProd.seckitid;
      strallfrontordprods[detidx].seckitstatus = fromProd.seckitstatus;
      strallfrontordprods[detidx].secinvid = fromProd.secinvid;
      strallfrontordprods[detidx].secinvstatus = fromProd.secinvstatus;
      strallfrontordprods[detidx].secposid = fromProd.secposid;
      strallfrontordprods[detidx].secposstatus = fromProd.secposstatus;
      strallfrontordprods[detidx].created = fromProd.created;
    });
  }

  syncInvDetData(RescafOrdProd fromProd, int detidx) {
    setState(() {
      strallinvordprods[detidx].id = fromProd.id;
      strallinvordprods[detidx].orderid = fromProd.orderid;
      strallinvordprods[detidx].prodid = fromProd.prodid;
      strallinvordprods[detidx].prodcode = fromProd.prodcode;
      strallinvordprods[detidx].prdname = fromProd.prdname;
      strallinvordprods[detidx].quantity = fromProd.quantity;
      strallinvordprods[detidx].price = fromProd.price;
      strallinvordprods[detidx].tax = fromProd.tax;
      strallinvordprods[detidx].subtotal = fromProd.subtotal;
      strallinvordprods[detidx].kitchenneed = fromProd.kitchenneed;
      strallinvordprods[detidx].kitchenaccept = fromProd.kitchenaccept;
      strallinvordprods[detidx].kitchendone = fromProd.kitchendone;
      strallinvordprods[detidx].kitchenstatus = fromProd.kitchenstatus;
      strallinvordprods[detidx].kitchenid = fromProd.kitchenid;
      strallinvordprods[detidx].invneed = fromProd.invneed;
      strallinvordprods[detidx].invaccept = fromProd.invaccept;
      strallinvordprods[detidx].invdone = fromProd.invdone;
      strallinvordprods[detidx].invstatus = fromProd.invstatus;
      strallinvordprods[detidx].invid = fromProd.invid;
      strallinvordprods[detidx].delivered = fromProd.delivered;
      strallinvordprods[detidx].frontstatus = fromProd.frontstatus;
      strallinvordprods[detidx].frontid = fromProd.frontid;
      strallinvordprods[detidx].rescaf = fromProd.rescaf;
      strallinvordprods[detidx].rescaftab = fromProd.rescaftab;
      strallinvordprods[detidx].rescaftake = fromProd.rescaftake;
      strallinvordprods[detidx].secfrontid = fromProd.secfrontid;
      strallinvordprods[detidx].secfrontstatus = fromProd.secfrontstatus;
      strallinvordprods[detidx].seckitid = fromProd.seckitid;
      strallinvordprods[detidx].seckitstatus = fromProd.seckitstatus;
      strallinvordprods[detidx].secinvid = fromProd.secinvid;
      strallinvordprods[detidx].secinvstatus = fromProd.secinvstatus;
      strallinvordprods[detidx].secposid = fromProd.secposid;
      strallinvordprods[detidx].secposstatus = fromProd.secposstatus;
      strallinvordprods[detidx].created = fromProd.created;
    });
  }

  syncKitDetData(RescafOrdProd fromProd, int detidx) {
    setState(() {
      strallkitordprods[detidx].id = fromProd.id;
      strallkitordprods[detidx].orderid = fromProd.orderid;
      strallkitordprods[detidx].prodid = fromProd.prodid;
      strallkitordprods[detidx].prodcode = fromProd.prodcode;
      strallkitordprods[detidx].prdname = fromProd.prdname;
      strallkitordprods[detidx].quantity = fromProd.quantity;
      strallkitordprods[detidx].price = fromProd.price;
      strallkitordprods[detidx].tax = fromProd.tax;
      strallkitordprods[detidx].subtotal = fromProd.subtotal;
      strallkitordprods[detidx].kitchenneed = fromProd.kitchenneed;
      strallkitordprods[detidx].kitchenaccept = fromProd.kitchenaccept;
      strallkitordprods[detidx].kitchendone = fromProd.kitchendone;
      strallkitordprods[detidx].kitchenstatus = fromProd.kitchenstatus;
      strallkitordprods[detidx].kitchenid = fromProd.kitchenid;
      strallkitordprods[detidx].invneed = fromProd.invneed;
      strallkitordprods[detidx].invaccept = fromProd.invaccept;
      strallkitordprods[detidx].invdone = fromProd.invdone;
      strallkitordprods[detidx].invstatus = fromProd.invstatus;
      strallkitordprods[detidx].invid = fromProd.invid;
      strallkitordprods[detidx].delivered = fromProd.delivered;
      strallkitordprods[detidx].frontstatus = fromProd.frontstatus;
      strallkitordprods[detidx].frontid = fromProd.frontid;
      strallkitordprods[detidx].rescaf = fromProd.rescaf;
      strallkitordprods[detidx].rescaftab = fromProd.rescaftab;
      strallkitordprods[detidx].rescaftake = fromProd.rescaftake;
      strallkitordprods[detidx].secfrontid = fromProd.secfrontid;
      strallkitordprods[detidx].secfrontstatus = fromProd.secfrontstatus;
      strallkitordprods[detidx].seckitid = fromProd.seckitid;
      strallkitordprods[detidx].seckitstatus = fromProd.seckitstatus;
      strallkitordprods[detidx].secinvid = fromProd.secinvid;
      strallkitordprods[detidx].secinvstatus = fromProd.secinvstatus;
      strallkitordprods[detidx].secposid = fromProd.secposid;
      strallkitordprods[detidx].secposstatus = fromProd.secposstatus;
      strallkitordprods[detidx].created = fromProd.created;
    });
  }

  Widget getTablesList()
  {
    setState(() {
      
    });
      if (strtabs.isNotEmpty) {
        return _tableCardView(strtabs);
      } else {
        return const Text("");
      }
  }

  ListView _tableCardView(List<RescafTable> data) {
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          reverse: false,
          shrinkWrap: true,
          padding: EdgeInsets.all(getProportionateScreenHeight(3)),
          itemCount: data.length,
          itemBuilder: (context, index) {
            String actorders = txtResCafActOrders + strtabs[index].orders.length.toString();
            return _tabletile(index, strtabs[index].tablename, actorders , '' , Icons.card_giftcard);
          },
      );
  }

  Card _tabletile(int index, String title, String subtitle, String trailing, IconData icon) => Card(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(16), color: (index == rescafcurtableid)? kResCafColorSel : kResCafColor)),
              subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(11), color: (index == rescafcurtableid)? kResCafColorSel : kResCafColor)),
              trailing: Text(trailing),
              contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5), horizontal: getProportionateScreenWidth(10)),
              dense:false,
              onTap: () => picktableitem(index)
          ),
          ButtonTheme( // make buttons use the appropriate styles for cards
              child: const ButtonBar(
                children: <Widget>[
                  Text(""),
                  Text(""),
                ]
              ),
            ),
        ]),
    );

  Widget getTabOrders()
  {
    setState(() {
      
    });
    if (rescafcurtableid != 9999) {
      return _tabOrdersListView();
    } else {
      return _tabAllItemsListView();
    }
  }

  ListView _tabOrdersListView() {
    var tmptabid = rescafcurtableid;
    var data = strtabs[tmptabid].orders;
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(getProportionateScreenHeight(3)),
          itemCount: data.length,
          itemBuilder: (context, index) {
            int itemcount = data[index].itemcount;
            double total = data[index].total;
            double tax = data[index].tax;
            String currency = thestore['currency'];
            final String titletext = txtOrdNbrTile + "${data[index].id}" + ' ^[' + dateDbFormat.format(data[index].created) + ']';
            final String orderstatus = ' ^ Status: ' + ((data[index].rescafcheckout == 0)? 'ChkOut-waiting' : 'ChkOut-checkedout') + ' / ' + ((data[index].rescafpaid == 0)? 'Pay-waiting' : 'Pay-paided');
            final String subtitletext = txtOrdListTot + posCcy.format(total) + ' ' + currency + ', ' + txtOrdItemCount + "$itemcount" + orderstatus;
            final String taxtext = txtOrdTax + posCcy.format(tax) + ' ' + currency;
            return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _ordertile(tmptabid, index, titletext , subtitletext , taxtext , Icons.shopping_cart, data[index].id),
                    (rescafcurorderid == data[index].id)?
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        reverse: true,
                        shrinkWrap: true,
                        padding: EdgeInsets.all(getProportionateScreenHeight(3)),
                        itemCount: data[index].detail.length,
                        itemBuilder: (BuildContext context, int detidx) {
                          var detdata = data[index].detail;
                          int theorderid = data[index].id;
                          int detquantity = detdata[detidx].quantity;
                          int detorddetid = detdata[detidx].id;
                          double dettotal = detdata[detidx].subtotal;
                          double dettax = detdata[detidx].tax;
                          double detprice = detdata[detidx].price;
                          String detfrontstatus =  ((detdata[detidx].frontstatus.isNotEmpty)? txtResCafNote + detdata[detidx].frontstatus.trim() + ')' : '');
                          String detkitstatus = (detdata[detidx].kitchenneed>0)? txtResCafKitchen + ((detdata[detidx].kitchenaccept>0)? txtResCafaccepted : txtResCaflisting) + '/' + ((detdata[detidx].kitchendone>0)? txtResCafdone : txtResCafdoing) : '';
                          String detinvstatus = (detdata[detidx].invneed>0)? txtResCafInv + ((detdata[detidx].invaccept>0)? txtResCafaccepteds : txtResCaflistings) + '/' + ((detdata[detidx].invdone>0)? txtResCafdones : txtResCafdoings) : '';
                          String detdelivered = txtResCafStat + ((detdata[detidx].delivered>0)? txtResCafdelivered : txtResCafwaiting);
                          String itemstatus = detfrontstatus + '\n' + detkitstatus + '' + detinvstatus + ', ' + detdelivered;
                          final String dettitletext = txtOrdDetItmName + detdata[detidx].prdname + txtOrdDetItemCount + "$detquantity" + ' [' + detdata[detidx].prodcode + ']';
                          final String dettaxtext = txtOrdDetTax + posCcy.format(dettax) + ' ' + currency;
                          final String detcreated = dateDbFormat.format(detdata[detidx].created);
                          final String detsubtitletext = txtOrdDetSubTot + posCcy.format(dettotal) + ' ' + currency + ', ' + txtOrdDetItmPrice + posCcy.format(detprice) + ' ' + currency + '\n' + dettaxtext + txtResCafTime + detcreated;
                          return _orderitemtile(tmptabid, theorderid, index, detidx, detorddetid, dettitletext, detsubtitletext, itemstatus, Icons.shopping_cart_sharp);
                        }) : Container(),
                  ],
            );
          },
        );
  }

  ListTile _ordertile(int tabid, int index, String title, String subtitle, String trailtext, IconData icon, int orderid) => ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(14), color: (tabid == rescafcurtableid && rescafcurorderidx == index)? kResCafDetColorSel : kResCafDetColor)),
        subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (tabid == rescafcurtableid && rescafcurorderidx == index)? kResCafDetColorSel : kResCafDetColor)),
        trailing: Text(trailtext,style: TextStyle(fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(12), color: (tabid == rescafcurtableid && rescafcurorderidx == index)? kResCafDetColorSel : kResCafDetColor)),
        contentPadding: EdgeInsets.fromLTRB(getProportionateScreenWidth(5), getProportionateScreenHeight(1), getProportionateScreenHeight(1), getProportionateScreenHeight(1)),
        dense:true,
        onTap: () => pickorder(tabid,index,orderid),
  );

  ListTile _orderitemtile(int tabid, int orderid, int index, int detidx, detorddetid, String title, String subtitle, String trailtext, IconData icon) => ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(14), color: (tabid == rescafcurtableid && rescafcurorderidx == index && rescafcurorddetidx == detidx)? kResCafDetColorSel : kResCafDetColor)),
        subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(13), color: (tabid == rescafcurtableid && rescafcurorderidx == index && rescafcurorddetidx == detidx)? kResCafDetColorSel : kResCafDetColor)),
        trailing: Text(trailtext,style: TextStyle(fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (tabid == rescafcurtableid && rescafcurorderidx == index && rescafcurorddetidx == detidx)? kResCafDetStatusColor : kResCafDetStatusColorSel)),
        contentPadding: EdgeInsets.fromLTRB(getProportionateScreenWidth(20), getProportionateScreenHeight(1), getProportionateScreenHeight(1), getProportionateScreenHeight(1)),
        dense:true,
        onTap: () => pickorderitem(tabid,orderid,index,detidx,detorddetid),
  );

  ListView _tabAllItemsListView() {
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          reverse: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(getProportionateScreenHeight(3)),
          itemCount: strallinvordprods.length,
          itemBuilder: (context, index) {
            String currency = thestore['currency'];
            var detdata = strallinvordprods[index];
            var dettabid = detdata.rescaftab;
            int detquantity = detdata.quantity;
            int detorderid = detdata.orderid;
            int detorddetid = detdata.id;
            double dettotal = detdata.subtotal;
            double dettax = detdata.tax;
            double detprice = detdata.price;
            String detfrontstatus =  ((detdata.frontstatus.isNotEmpty)? txtResCafNote + detdata.frontstatus.trim() + ')' : '');
            String detkitstatus = (detdata.kitchenneed>0)? txtResCafKitchen + ((detdata.kitchenaccept>0)? txtResCafaccepted : txtResCaflisting) + '/' + ((detdata.kitchendone>0)? txtResCafdone : txtResCafdoing) : '';
            String detinvstatus = (detdata.invneed>0)? txtResCafInv + ((detdata.invaccept>0)? txtResCafaccepteds : txtResCaflistings) + '/' + ((detdata.invdone>0)? txtResCafdones : txtResCafdoings) : '';
            String detdelivered = txtResCafStat + ((detdata.delivered>0)? txtResCafdelivered : txtResCafwaiting);
            String itemstatus = detfrontstatus + '\n' + detkitstatus + '' + detinvstatus + ', ' + detdelivered;
            final String dettitletext = txtOrdDetItmName + detdata.prdname + txtOrdDetItemCount + "$detquantity" + ' [' + detdata.prodcode + ']';
            final String dettaxtext = txtOrdDetTax + posCcy.format(dettax) + ' ' + currency;
            final String detcreated = dateDbFormat.format(detdata.created) + txtResCafTable + ((dettabid==0)? txtResCafTakeAway : dettabid.toString().padLeft(3,'0'));
            final String detsubtitletext = txtOrdDetSubTot + posCcy.format(dettotal) + ' ' + currency + ', ' + txtOrdDetItmPrice + posCcy.format(detprice) + ' ' + currency + '\n' + dettaxtext + txtResCafTime + detcreated;
            return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _allorderitemtile(dettabid, detorderid, index, detorddetid, dettitletext, detsubtitletext, itemstatus, Icons.shopping_cart_sharp),
                  ],
            );
          },
        );
  }

  ListTile _allorderitemtile(int tabid, int detorderid, int detidx, detorddetid, String title, String subtitle, String trailtext, IconData icon) => ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(14), color: (rescafcurorddetid == detorddetid)? kResCafDetColorSel : kResCafDetColor)),
        subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(13), color: (rescafcurorddetid == detorddetid)? kResCafDetColorSel : kResCafDetColor)),
        trailing: Text(trailtext,style: TextStyle(fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (rescafcurorddetid == detorddetid)? kResCafDetStatusColor : kResCafDetStatusColorSel)),
        contentPadding: EdgeInsets.fromLTRB(getProportionateScreenWidth(20), getProportionateScreenHeight(1), getProportionateScreenHeight(1), getProportionateScreenHeight(1)),
        dense:true,
        onTap: () => pickitemallorders(tabid,detorderid,detidx,detorddetid),
  );

  pickitemallorders(tabid,orderid,detidx,detorddetid) {
    setState(() {
      rescafcurorderid = orderid;
      rescafcurorddetid = detorddetid;
      btnStateDelivered = true;
      if (orderid>0 && detorddetid>0 && (strtabs[tabid].orders.where((ol) => (ol.id == orderid)).first.detail.where((de) => (de.id == detorddetid)).first.invneed>0)) {
        btnStateInvAccept = true;
        btnStateInvDone = true;
        btnStateKitchenAccept = false;
        btnStateKitchenDone = false;
      } else if (orderid>0 && detorddetid>0 && (strtabs[tabid].orders.where((ol) => (ol.id == orderid)).first.detail.where((de) => (de.id == detorddetid)).first.kitchenneed>0)) {
        btnStateKitchenAccept = true;
        btnStateKitchenDone = true;
        btnStateInvAccept = false;
        btnStateInvDone = false;
      }
    });
  }

  pickorderitem(tabid,orderid,ordindex,detidx,detorddetid) {
    setState(() {
      rescafcurtableid = tabid;
      rescafcurorderid = orderid;
      rescafcurorderidx = ordindex;
      rescafcurorddetidx = detidx;
      rescafcurorddetid = detorddetid;
      btnStateDelivered = true;
      if (rescafcurorderid>0 && rescafcurorddetid>0 && strtabs[rescafcurtableid].orders[rescafcurorderidx].detail[rescafcurorddetidx].invneed>0) {
        btnStateInvAccept = true;
        btnStateInvDone = true;
        btnStateKitchenAccept = false;
        btnStateKitchenDone = false;
      } else if (rescafcurorderid>0 && rescafcurorddetid>0 && strtabs[rescafcurtableid].orders[rescafcurorderidx].detail[rescafcurorddetidx].kitchenneed>0) {
        btnStateKitchenAccept = true;
        btnStateKitchenDone = true;
        btnStateInvAccept = false;
        btnStateInvDone = false;
      }
      if (rescafcurtableid != 9999 && strtabs[rescafcurtableid].orders[rescafcurorderidx].detail.isNotEmpty && (strtabs[rescafcurtableid].orders[rescafcurorderidx].detail.where((element) => element.delivered==0)).isEmpty) {
        btnStateResCafPosChkout = true;
      }
      if (rescafcurtableid != 9999 && strtabs[rescafcurtableid].orders[rescafcurorderidx].rescafcheckout > 0) {
        btnStateResCafPosPaid = true;
      }
    });
  }

  pickorder(tabid,ordindex,orderid) {
    setState(() {
      rescafcurtableid = tabid;
      rescafcurorderidx = ordindex;
      rescafcurorderid = orderid;
      if (rescafcurtableid != 9999 && strtabs[rescafcurtableid].orders[rescafcurorderidx].detail.isNotEmpty && (strtabs[rescafcurtableid].orders[rescafcurorderidx].detail.where((element) => element.delivered==0)).isEmpty) {
        btnStateResCafPosChkout = true;
      }
      if (rescafcurtableid != 9999 && strtabs[rescafcurtableid].orders[rescafcurorderidx].rescafcheckout > 0) {
        btnStateResCafPosPaid = true;
      }
    });
  }

  picktableitem(tabid) {
    setState(() {
      if (rescafcurtableid == tabid) {
        rescafcurtableid = 9999;
        rescafcurorderid = 0;
        rescafcurorderidx = 0;
        rescafcurorddetid = 0;
        rescafcurorddetidx = 0;
        rescafcurprodid = 0;
        btnStateDelivered = false;
        btnStateResCafPosChkout = false;
        btnStateResCafPosPaid = false;
      } else {
        rescafcurtableid = tabid;
        rescafcurorderid = 0;
        rescafcurorderidx = 0;
        rescafcurorddetid = 0;
        rescafcurorddetidx = 0;
        rescafcurprodid = 0;
      }
    });
  }

  dbAddOrder(tabid) {
    setState(() {
      rescafcurtableid = tabid;
    });
    var postdata = {
        "mobapp" : mobAppVal,
        "store_id" : "${thestore['id']}",
        "store_name" : "${thestore['store_name']}",
        "front_id" : "${struser['id']}",
        "secfront_id" : "${struser['id']}",
        "rescaf" : "1",
        "rescaf_tab" : "$tabid",
        "rescaf_take" : (tabid == 0)? "1" : "0",
        "status" : "FrontInit",
        "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
        };
    showAlertDialog(context);
    http.post(
        rescafOrdAddEndPoint, 
        body: postdata,
        headers: posthdr
      ).then((result) {
          hideAlertDialog(context);
          if (result.statusCode == 200) {
            var resary = jsonDecode(result.body);
            setState(() {
              if (resary['data']['id'] > 0) {
                RescafOrder tmporder = RescafOrder.fromJsonDet(resary['data']);
                strtabs[tabid].orders.add(tmporder);
                btnStateDelivered = false;
                btnStateResCafPosChkout = false;
                btnStateResCafPosPaid = false;
                timer!.cancel();
                timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => updateTabs());
              }
            });
          } else {
            throw Exception(krescafOrdAddqryErr);
          }
      }).catchError((error) {
        // print(error);
      });
  }

  openAddItem(tabid) {
    setState(() {
      rescafcurtableid = tabid;
      if (strtabs[tabid].orders.isNotEmpty && strtabs[tabid].orders.where((element) => element.id == rescafcurorderid).isNotEmpty) {
        showItemAddDialog(context);
      }
    });
  }

  acceptItem() {
    var postdata = {
        "mobapp" : mobAppVal,
        "id" : "$rescafcurorddetid",
        "order_id" : "$rescafcurorderid",
        "qrymode" : "inventoryaccept",
        "inv_id" : "${struser['id']}",
        "inv_status" : "inventoryaccepted",
        "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
        };
    showAlertDialog(context);
    http.post(
        rescafOrdDetEditEndPoint, 
        body: postdata,
        headers: posthdr
      ).then((result) {
          hideAlertDialog(context);
          if (result.statusCode == 200) {
            // var resary = jsonDecode(result.body);
            setState(() {
              
            });
          } else {
            throw Exception(krescafOrdItmqryErr);
          }
      }).catchError((error) {
        // print(error);
      });
  }

  doneItem() {
    var postdata = {
        "mobapp" : mobAppVal,
        "id" : "$rescafcurorddetid",
        "order_id" : "$rescafcurorderid",
        "qrymode" : "inventorydone",
        "inv_id" : "${struser['id']}",
        "inv_status" : "inventorydone",
        "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
        };
    showAlertDialog(context);
    http.post(
        rescafOrdDetEditEndPoint, 
        body: postdata,
        headers: posthdr
      ).then((result) {
          hideAlertDialog(context);
          if (result.statusCode == 200) {
            // var resary = jsonDecode(result.body);
            setState(() {
              
            });
          } else {
            throw Exception(krescafOrdItmqryErr);
          }
      }).catchError((error) {
        // print(error);
      });
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

  showExitDialog(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text(txtAlertExitResCaf),
                actions: <Widget>[
                  FuncButton100(text: lblCancel, state: btnStateResCafExitCancel,
                    press: () {
                        hideExitDialog(context);
                        setState(() {});
                    },
                  ),
                  FuncButton100(text: lblExit, state: btnStateResCafExitConfirm,
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

  showItemAddDialog(BuildContext context) {
    rescafcurprodid = 0;
    itmaddquantity = 1;
    resCafProdItmTxtCtrl.text = "$itmaddquantity";
    resCafProdItmCommentTxtCtrl.text = '';
    itmaddcomment = '';
    needkitchen = true;
    needinventory = false;
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                    key: _prodscafoldKey,
                    body: const ProdFormBody(),
                  );
              },
          );
      },
    );
  }

  showStkInDialog(BuildContext context) {
    rescafcurprodid = 0;
    itmaddquantity = 1;
    resCafProdItmTxtCtrl.text = "$itmaddquantity";
    resCafProdItmCommentTxtCtrl.text = '';
    itmaddcomment = '';
    needkitchen = true;
    needinventory = false;
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                    key: _prodscafoldKey,
                    body: const StockInBody(),
                  );
              },
          );
      },
    );
  }

  showStkOutDialog(BuildContext context) {
    rescafcurprodid = 0;
    itmaddquantity = 1;
    resCafProdItmTxtCtrl.text = "$itmaddquantity";
    resCafProdItmCommentTxtCtrl.text = '';
    itmaddcomment = '';
    needkitchen = true;
    needinventory = false;
    showDialog(
      barrierDismissible: false,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                    key: _prodscafoldKey,
                    body: const StockOutBody(),
                  );
              },
          );
      },
    );
  }


}



