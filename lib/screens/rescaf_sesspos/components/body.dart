// import 'dart:io';

import 'dart:convert';
import 'dart:async';
// import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
// import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
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
// import 'package:storeoperations_app/components/custom_surfix_icon.dart';
// import 'package:new_virtual_keyboard/virtual_keyboard.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:audiofileplayer/audiofileplayer.dart';
// import 'package:storeoperations_app/screens/rescaf_pos/components/product_list.dart';
import 'package:storeoperations_app/screens/rescaf_pos/rescaf_pos_screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResCafSessPosMainBody extends StatefulWidget {

  const ResCafSessPosMainBody({Key? key}) : super(key: key);

  @override
  _ResCafSessPosMainBody createState() => _ResCafSessPosMainBody();

}

class _ResCafSessPosMainBody extends State<ResCafSessPosMainBody> with AfterLayoutMixin<ResCafSessPosMainBody> {

final _formKey = GlobalKey<FormState>();
String prodcode ='';
final List<String> errors = [];
final FocusNode _focusNode = FocusNode();
pw.Document doc = pw.Document();
late ByteData printfont;
late Uint8List assetLogoATC;
bool logoPdfLoaded = false;
Timer? timer;
Timer? timerPaidOrder;
Timer? timerProdUpd;
int itmaddquantity = 1;
String itmaddcomment = '';
bool needkitchen = true;
bool needinventory = false;

@override
void dispose() {
  timer?.cancel();
  timerProdUpd?.cancel();
  timerPaidOrder?.cancel();
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
                                  Text(txtResCafPOSTitle,style: TextStyle(fontSize: getProportionateScreenWidth(18),color: kPrimaryColor,fontWeight: FontWeight.bold)),
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
                                    state: btnStateGoToPOS,
                                    text: txtResCafGoToPOS,
                                    press: () {
                                      if (btnStateGoToPOS) {
                                        Navigator.pushNamed(context, ResCafPosMainScreen.routeName);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(width: getProportionateScreenWidth(defFormFieldEdges10)), 
                            ],
                          ),
                        ),
                      ),
                  ]),
                ]),
                Row(children: [
                  Column(children: [
                    Container(
                        width: halfScrlWid*2*(1/3),
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
                                  getFinishedSess(),
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
                          width: halfScrlWid*2*(2/3),
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
                                    getSessOrdersList(),
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
    doSessQryAll();
    setState(() {
      timer = Timer.periodic(const Duration(seconds: 600), (Timer t) => doSessQryAll());
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

  doSessQryAll() {
    var postdata = {
      "qrymode": "allbystore",
      "store_id": "${thestore['id']}",
      "pos_id" : "${struser['id']}",
      "mobapp": mobAppVal,
      "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
    };
    var posthdr = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer $usertoken'
    };
    // showAlertDialog(context);
    http.post(rescafSessQryEndPoint, body: postdata, headers: posthdr).then((result) {
      // hideAlertDialog(context);
      if (result.statusCode == 200) {
        var resary = jsonDecode(result.body);
        setState(() {
          List<RescafCounted> tmprescafsess = [];
          resary['data'].asMap().forEach((i, v) {
            tmprescafsess.add(RescafCounted.fromJsonDet(v));
          });
          tmprescafsess.asMap().forEach((sk, sv) {
            if (rescafsess.where((sesselem) => (sesselem.id == sv.id)).isNotEmpty) {
              syncSessList(sv,rescafsess.indexWhere((sesselem) => (sesselem.id == sv.id))); 
            } else {
              rescafsess.add(sv);
            }
          });
          rescafsess.removeWhere((element) => (tmprescafsess.where((bkelement) => bkelement.id == element.id).isEmpty));
          rescafsess.sort((b, a) => a.created.compareTo(b.created));
        });
        // logMessage(tmprescafsess.toString());
      } else {
        throw Exception(kResCafPosApiDataError);
      }
    }).catchError((error) {
       logError(error);
    });
  }

  syncSessList(RescafCounted fromSess, int toSessIdx) {
    setState(() {
      rescafsess[toSessIdx].id = fromSess.id;
      rescafsess[toSessIdx].storeid = fromSess.storeid;
      rescafsess[toSessIdx].storename = fromSess.storename;
      rescafsess[toSessIdx].detail = fromSess.detail;
      rescafsess[toSessIdx].sessid = fromSess.sessid;
      rescafsess[toSessIdx].posid = fromSess.posid;
      rescafsess[toSessIdx].ordercount = fromSess.ordercount;
      rescafsess[toSessIdx].orders = fromSess.orders;
      rescafsess[toSessIdx].subtotal = fromSess.subtotal;
      rescafsess[toSessIdx].tax = fromSess.tax;
      rescafsess[toSessIdx].total = fromSess.total;
      rescafsess[toSessIdx].ipaddress = fromSess.ipaddress;
      rescafsess[toSessIdx].remotehost = fromSess.remotehost;
      rescafsess[toSessIdx].comment = fromSess.comment;
      rescafsess[toSessIdx].note = fromSess.note;
      rescafsess[toSessIdx].created = fromSess.created;
      rescafsess[toSessIdx].posname = fromSess.posname;
      rescafsess[toSessIdx].posusername = fromSess.posusername;
    });
  }

  Widget getFinishedSess()
  {
    setState(() {
      
    });
      if (rescafsess.isNotEmpty) {
        return _sessCardView(rescafsess);
      } else {
        return const Text("");
      }
  }

  ListView _sessCardView(List<RescafCounted> data) {
    return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          reverse: false,
          shrinkWrap: true,
          padding: EdgeInsets.all(getProportionateScreenHeight(3)),
          itemCount: data.length,
          itemBuilder: (context, index) {
            String currency = thestore['currency'];
            String sesscntnbr = txtResCafSessCntNbr + rescafsess[index].id.toString() + '\n';
            String actorders = txtResCafSessOrders + rescafsess[index].detail.length.toString() + '\n' + txtResCafSessCntTot + posCcy.format(rescafsess[index].total) + ' ' + currency;
            String posnameinfo = rescafsess[index].posname + ' [' + rescafsess[index].posusername + ']\n';
            String sesscountedat = txtResCafSessCntAt + dateDbFormat.format(rescafsess[index].created);
            return _sesstile(index, sesscntnbr + actorders, posnameinfo + sesscountedat, '' , Icons.card_giftcard);
          },
      );
  }

  Card _sesstile(int index, String title, String subtitle, String trailing, IconData icon) => Card(
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
              title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(16), color: (index == rescafcursessidx)? kResCafColorSel : kResCafColor)),
              subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (index == rescafcursessidx)? kResCafColorSel : kResCafColor)),
              trailing: Text(trailing),
              contentPadding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(5), horizontal: getProportionateScreenWidth(10)),
              dense:false,
              onTap: () => picksessitem(index, rescafsess[index].id)
          ),
          ButtonTheme( // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  TextButton(
                    child: Text(txtResCafPrnTransfer),
                    onPressed: () {
                      countTicketPrint();
                    },
                  ),
                ]
              ),
            ),
        ]),
    );

  picksessitem(sessidx, sessid) {
    setState(() {
      rescafcursessidx = sessidx;
      rescafcursessid = sessid;
    });
  }

  Widget getSessOrdersList()
  {
    setState(() {
      
    });
    if (rescafcursessid > 0) {
      return _sessOrdersListView();
    } else {
      return Container();
    }
  }

  ListView _sessOrdersListView() {
    var tmpsessid = rescafcursessid;
    var data = rescafsess[rescafcursessidx].detail;
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
            final String orderstatus = txtResCafStatus + ((data[index].rescafcheckout == 0)? txtResCafChkoutWa : txtResCafChkoutCh) + ' / ' + ((data[index].rescafpaid == 0)? txtResCafPayWa : txtResCafPayPa);
            final String subtitletext = txtOrdListTot + posCcy.format(total) + ' ' + currency + ', ' + txtOrdItemCount + "$itemcount" + orderstatus;
            final String taxtext = txtOrdTax + posCcy.format(tax) + ' ' + currency;
            return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _ordertile(tmpsessid, index, titletext , subtitletext , taxtext , Icons.shopping_cart, data[index].id),
                    (rescafcursessorderid == data[index].id)?
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
                          return _orderitemtile(tmpsessid, theorderid, index, detidx, detorddetid, dettitletext, detsubtitletext, itemstatus, Icons.shopping_cart_sharp);
                        }) : Container(),
                  ],
            );
          },
        );
  }

  ListTile _ordertile(int sessid, int index, String title, String subtitle, String trailtext, IconData icon, int orderid) => ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(14), color: (rescafcursessorderid == orderid)? kResCafDetColorSel : kResCafDetColor)),
        subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (rescafcursessorderid == orderid)? kResCafDetColorSel : kResCafDetColor)),
        trailing: Text(trailtext,style: TextStyle(fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(12), color: (rescafcursessorderid == orderid)? kResCafDetColorSel : kResCafDetColor)),
        contentPadding: EdgeInsets.fromLTRB(getProportionateScreenWidth(5), getProportionateScreenHeight(1), getProportionateScreenHeight(1), getProportionateScreenHeight(1)),
        dense:true,
        onTap: () => pickorder(sessid,index,orderid),
  );

  ListTile _orderitemtile(int tabid, int orderid, int index, int detidx, detorddetid, String title, String subtitle, String trailtext, IconData icon) => ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w400,fontSize: getProportionateScreenHeight(14), color: (rescafcursessorderid == orderid && rescafcursessorderdetidx == detidx)? kResCafDetColorSel : kResCafDetColor)),
        subtitle: Text(subtitle, style: TextStyle( fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(13), color: (rescafcursessorderid == orderid && rescafcursessorderdetidx == detidx)? kResCafDetColorSel : kResCafDetColor)),
        trailing: Text(trailtext,style: TextStyle(fontWeight: FontWeight.w400, fontSize: getProportionateScreenHeight(14), color: (rescafcursessorderid == orderid && rescafcursessorderdetidx == detidx)? kResCafDetStatusColor : kResCafDetStatusColorSel)),
        contentPadding: EdgeInsets.fromLTRB(getProportionateScreenWidth(20), getProportionateScreenHeight(1), getProportionateScreenHeight(1), getProportionateScreenHeight(1)),
        dense:true,
        onTap: () => pickorderitem(orderid,detidx,detorddetid),
  );


  pickorder(sessid,index,orderid) {
    setState(() {
      rescafcursessid = sessid;
      rescafcursessorderidx = index;
      rescafcursessorderid = orderid;
    });
  }

  pickorderitem(orderid,detidx,detorddetid) {
    setState(() {
      rescafcursessorderid = orderid;
      rescafcursessorderdetidx = detidx;
    });
  }

  countTicketPrint() {
    if (rescafcursessid>0) {
      rescafsess[rescafcursessidx].detail.sort((a, b) => a.created.compareTo(b.created));
      cashPrintHdrTxt = '';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnHdrStore + thestore['store_name']+'\n';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnHdrPos + rescafsess[rescafcursessidx].posusername + '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + thestore['store_addr'] + '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + thestore['store_addr2']+ '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnBdyTel + thestore['store_phone']+ '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + txtCashPrnBdyEmail + thestore['store_email']+ '\n';
      cashPrintHdrTxt = cashPrintHdrTxt + DateFormat.yMd().add_jms().format(DateTime.now()) + '\n';
      cashPrintBodyTxt = '____________________________________\n\n';
      double cursesstotal = 0;
      double cursesssubtotal = 0;
      double cursesstax = 0;
      int cursessords = 0;
      rescafsess[rescafcursessidx].detail.asMap().forEach((di, dv) {
        cursesstotal += dv.total;
        cursesssubtotal += dv.subtotal;
        cursesstax += dv.tax;
        cursessords++;
      });
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyNOfOrd + cursessords.toString() + ' orders\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdySubTot + posCcy.format(cursesssubtotal) + ' ' + thestore['currency'] + '\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyTaxTot + posCcy.format(cursesstax) + ' ' + thestore['currency'] + '\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyCashTot + posCcy.format(cursesstotal) + ' ' + thestore['currency'] + '\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyStartTime + DateFormat.yMd().add_jms().format(rescafsess[rescafcursessidx].detail.first.created) + '\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyTransferTime + DateFormat.yMd().add_jms().format(rescafsess[rescafcursessidx].created) + '\n';
      cashPrintBodyTxt = cashPrintBodyTxt + '____________________________________\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdySignToTran + '\n\n\n\n';
      cashPrintBodyTxt = cashPrintBodyTxt + rescafsess[rescafcursessidx].posname + ' [' + rescafsess[rescafcursessidx].posusername + ']' + '\n\n\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdySignature + '\n\n\n';
      cashPrintBodyTxt = cashPrintBodyTxt + txtCashPrnBdyConform + '\n\n\n';
      cashPrintBodyTxt = cashPrintBodyTxt + '____________________________________\n';
      cashPrintFooterTxt = '';
      cashPrintFooterTxt = cashPrintFooterTxt + '\n\n';
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
                        pw.Center(child: pw.Text(cashPrintHdrTxt, style: pw.TextStyle(font: printttf, fontSize: 12))),
                        pw.Center(child: pw.Text(cashPrintBodyTxt, style: pw.TextStyle(font: printttf, fontSize: 10))),
                        pw.Center(child: pw.Text(cashPrintFooterTxt, style: pw.TextStyle(font: printttf, fontSize: 14))),
                        pw.Center(child: pw.Text(txtCashPrnBdyThks, style: pw.TextStyle(font: printttf, fontSize: 16))),
                      ]
                  ),
                );
            }));
      Printing.layoutPdf(onLayout: (PdfPageFormat format) => doc.save());
    }
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

}




