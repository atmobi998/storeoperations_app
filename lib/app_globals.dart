// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_new

library globals;

// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
// import 'package:storepos_app/constants.dart';
// import 'package:storepos_app/components/default_button.dart';
// import 'package:storepos_app/components/custom_surfix_icon.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context);
}

final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

bool enableRetailer = false;
bool enableResCaf = true;

var admcurprod;
var admcurprodid;
var curprodactive;

var isLoggedIn = false;
var reguser;
var regstore;
var struser;
var thestore;
var possess;
var curprod;
var curprodcode;
var curprodid;
List<Ticket> cursess = [];
var cursessid=0;
var curtktid=cursessid;
var curtktdetid=0;
List<Product> curtktdet  = [];
var curtkt = Ticket.fromArray([curtktid,curtktid,curtktdet,new DateTime.now(),new DateTime.now(),curtkttotal,curtkttax,curtkttotal,0.0,new DateTime.now(),1]);
double curtkttotal = 0.0;
double curtkttax = 0.0;
double curtktcash = 0.0;
double curtktchange = 0.0;
String rescafProdListTxt = '';

List<RescafTable> strtabs = [];
List<RescafOrder> strtaborders = [];
List<RescafOrder> strpaidorders = [];
List<RescafOrdProd> strtabordprods = [];
List<RescafOrdProd> strallinvordprods = [];
List<RescafOrdProd> strallkitordprods = [];
List<RescafOrdProd> strallfrontordprods = [];
List<RescafOrdProd> strallposordprods = [];

int rescafcurtableid = 9999;
int rescafcurorderid = 0;
int rescafcurorderidx = 0;
int rescafcurorddetid = 0;
int rescafcurorddetidx = 0;
int rescafcurprodid = 0;
int rescafstkprodid = 0;
List<ResCafProduct> rescafprods = [];
String rescafadditemmode = 'new';
String rescafCashHdrTot = '';
String rescafCashHdrTax = '';
double ordspaidtottal = 0.0;
double ordspaidtax = 0.0;
String rescafstkinmode = 'stkin';
String rescafstkoutmode = 'stkout';

int rescafcursessid = 0;
int rescafcursessidx = 0;
int rescafcursessorderid = 0;
int rescafcursessorderidx = 0;
int rescafcursessorderdetid = 0;
int rescafcursessorderdetidx = 0;
List<RescafCounted> rescafsess = [];

DateFormat dateDbFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

var prodbycode;
var prodbyid;
var curpickitm = 1 ;
final posCcy = NumberFormat("#,##0.0", "en_US");
double secstartcash = 0.0;
double seccurcash = 0.0;
double secendcash = 0.0;
String sectimestart = '';
String seccurtime = '';
String secendtime = '';
int sectotcurtkt = 0;
int sectotendtkt = 0;

var btnPosStateEnter = false;
var btnPosStateSave = false;
var btnPosStateLoad = false;
var btnPosStateChange = false;
var btnPosStateDelete = false;
var btnPosStateScan = false;
var btnPosStateScanS = false;
var btnPosStateStart = false;
var btnPosStateEnd = false;
var btnPosStateBreak = false;
var btnPosStateCash = false;
var btnPosStateFind = false;
var btnPosStateCal = false;
var btnPosStateKeyb = true;
var btnPosStateExit = false;
var btnPosStateCancel = true;
var btnPosStateCashContinue = true;
var btnPosStateSetup = false;
var btnPosStateSetupContinue = true;

var btnStateResCafFront = false;
var btnStateResCafInventory = false;
var btnStateResCafKitchen = false;
var btnStateResCafPOS = false;
var btnStateResCafSessPOS = false;
var btnStateDelivered = false;
var btnStateKitchenAccept = false;
var btnStateKitchenDone = false;
var btnStateInvAccept = false;
var btnStateInvDone = false;
var btnStateResCafExit = true;
var btnStateResCafBack = true;
var btnStateResCafStkIn = true;
var btnStateResCafStkInCancel = true;
var btnStateResCafStkInDone = true;
var btnStateResCafStkOut = true;
var btnStateResCafCount = false;
var btnStateGoToPOS = true;


var btnStateResCafPosChkout = false;
var btnStateResCafPosPaid = false;
var btnStateResCafExitConfirm = true;
var btnStateResCafExitCancel = true;

var btnStateResCafCountConfirm = true;
var btnStateResCafCountCancel = true;


var btnStateResCafItemAdd = true;
var resCafProdItmTxtCtrl =  TextEditingController();
var resCafProdItmCommentTxtCtrl =  TextEditingController();
var resCafProdItmFilterTxtCtrl =  TextEditingController();

var btnStateRetailFront = false;
var btnStateRetailInventory = false;
var btnStateRetailKitchen = false;
var btnStateRetailFood = false;
var btnStateRetailPOS = false;

var prodCodeTxtCtrl =  TextEditingController();
var prodItmTxtCtrl =  TextEditingController();
var storecodeTxtCtrl =  TextEditingController();
var poscodeTxtCtrl =  TextEditingController();
var passcodeTxtCtrl =  TextEditingController();
var storecodeState = false;
var poscodeState = false;
var passcodeState = false;
String cashAlertTxt = '';
String cashSaveAlertTxt = '';
String cashPrintHdrTxt = '';
String cashPrintBodyTxt = '';
String cashPrintFooterTxt = '';
double tktcash = 0;
double tktcashchange = 0;
var tktcashTxtCtrl =  TextEditingController();
var tktcashchangeTxtCtrl =  TextEditingController();

String startCashAlertTxt = 'Session start cash:';
var sessstartcashTxtCtrl =  TextEditingController();
double sessstartcash = 0.0;

String usertoken = '';
String loginusercode = '';
String loginstorecode = '';
String loginpasscode = '';

Codec<String, String> stringToBase64 = utf8.fuse(base64);

class DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

AlertDialog doingapialert = AlertDialog(
  content: Row(
    children: [
      const CircularProgressIndicator(),
      Container(margin: const EdgeInsets.only(left: 5), child: const Text("Loading data")),
    ],
  ),
);

AlertDialog loginapialert = AlertDialog(
  content: Row(
    children: [
      const CircularProgressIndicator(),
      Container(
          margin: const EdgeInsets.only(left: 5),
          child: const Text("Signing into Store Operations")),
    ],
  ),
);

showLoginDialog(BuildContext context) {
  AlertDialog alert = loginapialert;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = doingapialert;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

hideAlertDialog(BuildContext context) {
  Navigator.pop(context);
}

hideCashDialog(BuildContext context) {
  Navigator.pop(context);
}

hideCountDialog(BuildContext context) {
  Navigator.pop(context);
}

hideExitDialog(BuildContext context) {
  Navigator.pop(context);
}

hideSessSaveDialog(BuildContext context) {
  Navigator.pop(context);
}

hideItemAddDialog(BuildContext context) {
  Navigator.pop(context);
}

hideStkInDialog(BuildContext context) {
  Navigator.pop(context);
}

hideStkOutDialog(BuildContext context) {
  Navigator.pop(context);
}

class Ticket {

  int id;
  int index;
  List<Product> detail;
  DateTime created;
  DateTime lastupd;
  double tkttotal;
  double tkttax;
  double tktcash;
  double tktchange;
  DateTime lastsaved;
  int needsave;

  Ticket({required this.id, required this.index, required this.detail, required this.created, required this.lastupd, required this.tkttotal, required this.tkttax, 
          required this.tktcash, required this.tktchange, required this.lastsaved, required this.needsave});

  factory Ticket.fromArray(ary) {
    return Ticket(
      id: ary[0],
      index: ary[1],
      detail: ary[2],
      created: ary[3],
      lastupd: ary[4],
      tkttotal: ary[5],
      tkttax: ary[6],
      tktcash: ary[7],
      tktchange: ary[8],
      lastsaved: ary[9],
      needsave: ary[10],
    );
  }
}

class ResCafProduct {

  int id;
  int storeid;
  String storename;
  int catid;
  String catname;
  String prodname;
  String prodcode;
  String prodslug;
  String proddesc;
  int prodsort;
  String prodico;
  String prodimga;
  String prodimgb;
  String prodimgc;
  double prodpricesell;
  double prodpricebuy;
  double prodtaxrate;
  int prodactive;
  int stockunits;
  int minstock;

  ResCafProduct({required this.id, required this.storeid, required this.storename, required this.catid, required this.catname, required this.prodname, required this.prodcode, 
      required this.prodslug, required this.proddesc, required this.prodsort, required this.prodico, required this.prodimga, required this.prodimgb, required this.prodimgc, 
      required this.prodactive, required this.prodpricesell, required this.prodpricebuy, required this.prodtaxrate, required this.stockunits, required this.minstock});

  factory ResCafProduct.fromArray(ary) {
    return ResCafProduct(
      id: ary['id'],
      storeid: ary['store_id'],
      storename: ary['store_name'],
      catid: ary['cat_id'],
      catname: ary['cat_name'],
      prodname: ary['name'],
      prodcode: ary['prod_code'],
      prodslug: ary['slug'],
      proddesc: ary['description'],
      prodsort: ary['sort'],
      prodico: ary['prod_ico'],
      prodimga: ary['prod_imga'],
      prodimgb: ary['prod_imgb'],
      prodimgc: ary['prod_imgc'],
      prodpricesell: ary['pricesell'].toDouble(),
      prodpricebuy: ary['pricebuy'].toDouble(),
      prodtaxrate: ary['taxrate'].toDouble(),
      prodactive: ary['active'],
      stockunits: ary['stockunits'],
      minstock: ary['minstock'],
    );
  }

  factory ResCafProduct.fromJsonDet(json) {
    return ResCafProduct(
      id: json['id'],
      storeid: json['store_id'],
      storename: json['store_name'],
      catid: json['cat_id'],
      catname: json['cat_name'],
      prodname: json['name'],
      prodcode: json['prod_code'],
      prodslug: json['slug'],
      proddesc: json['description'],
      prodsort: json['sort'],
      prodico: json['prod_ico'],
      prodimga: json['prod_imga'],
      prodimgb: json['prod_imgb'],
      prodimgc: json['prod_imgc'],
      prodpricesell: json['pricesell'].toDouble(),
      prodpricebuy: json['pricebuy'].toDouble(),
      prodtaxrate: json['taxrate'].toDouble(),
      prodactive: json['active'],
      stockunits: json['stockunits'],
      minstock: json['minstock'],
    );
  }

}

class Product {

  int id;
  int storeid;
  String storename;
  int catid;
  String catname;
  String prodname;
  String prodslug;
  String proddesc;
  int prodsort;
  String prodico;
  String prodimga;
  String prodimgb;
  String prodimgc;
  double prodpricesell;
  double prodpricebuy;
  double prodtaxrate;
  int prodactive;
  int stockunits;
  int pickitm;
  int detid;

  Product({required this.id, required this.storeid, required this.storename, required this.catid, required this.catname, required this.prodname, 
      required this.prodslug, required this.proddesc, required this.prodsort, required this.prodico, required this.prodimga, required this.prodimgb, required this.prodimgc, 
      required this.prodactive, required this.prodpricesell, required this.prodpricebuy, required this.prodtaxrate, required this.stockunits, required this.pickitm, required this.detid});

  factory Product.fromArray(ary) {
    return Product(
      id: ary['id'],
      storeid: ary['store_id'],
      storename: ary['store_name'],
      catid: ary['cat_id'],
      catname: ary['cat_name'],
      prodname: ary['name'],
      prodslug: ary['slug'],
      proddesc: ary['description'],
      prodsort: ary['sort'],
      prodico: ary['prod_ico'],
      prodimga: ary['prod_imga'],
      prodimgb: ary['prod_imgb'],
      prodimgc: ary['prod_imgc'],
      prodpricesell: ary['pricesell'].toDouble(),
      prodpricebuy: ary['pricebuy'].toDouble(),
      prodtaxrate: ary['taxrate'].toDouble(),
      prodactive: ary['active'],
      stockunits: ary['stockunits'],
      pickitm: ary['pickitm'],
      detid: ary['detid'],
    );
  }

  factory Product.fromJsonDet(json) {
    return Product(
      id: json['product']['id'],
      storeid: json['product']['store_id'],
      storename: json['product']['store_name'],
      catid: json['product']['cat_id'],
      catname: json['product']['cat_name'],
      prodname: json['product']['name'],
      prodslug: json['product']['slug'],
      proddesc: json['product']['description'],
      prodsort: json['product']['sort'],
      prodico: json['product']['prod_ico'],
      prodimga: json['product']['prod_imga'],
      prodimgb: json['product']['prod_imgb'],
      prodimgc: json['product']['prod_imgc'],
      prodpricesell: json['product']['pricesell'].toDouble(),
      prodpricebuy: json['product']['pricebuy'].toDouble(),
      prodtaxrate: json['product']['taxrate'].toDouble(),
      prodactive: json['product']['active'],
      stockunits: json['product']['stockunits'],
      pickitm: json['quantity'],
      detid: json['id'],
    );
  }

}

class RescafTable {

  int id;
  int storeid;
  String storename;
  List<RescafOrder> orders = [];
  String tablename;

  RescafTable({required this.id, required this.storeid, required this.storename, required this.orders, required this.tablename});

  factory RescafTable.fromArray(ary) {
    return RescafTable(
      id: ary[0],
      storeid: ary[1],
      storename: ary[2],
      orders: ary[3],
      tablename: ary[4],
    );
  }

}

class RescafOrder {

  int id;
  int storeid;
  String storename;
  List<RescafOrdProd> detail;
  int sessid;
  int posid;
  int frontid;
  int kitchenid;
  int invid;
  int secposid;
  int secfrontid;
  int seckitid;
  int secinvid;
  int rescaf;
  int rescaftab;
  int rescaftake;
  int itemcount;
  double subtotal;
  double tax;
  double total;
  double cash;
  double cashchg;
  double shipfee;
  String status;
  int rescafcheckout;
  String rescafcheckoutlog;
  int rescafpaid;
  String rescafpaidlog;
  int paid;
  int shipped;
  DateTime created;

  RescafOrder({required this.id, required this.storeid, required this.storename, required this.detail, required this.sessid, required this.posid, required this.frontid, required this.kitchenid, required this.invid, 
              required this.secposid, required this.secfrontid, required this.seckitid, required this.secinvid, required this.rescaf, required this.rescaftab, 
              required this.rescaftake, required this.itemcount, required this.subtotal, required this.tax, required this.total, required this.cash, required this.cashchg, 
              required this.shipfee, required this.status, required this.rescafcheckout, required this.rescafcheckoutlog, required this.rescafpaid, required this.rescafpaidlog, 
              required this.paid, required this.shipped, required this.created});

  factory RescafOrder.fromArray(ary) {
    return RescafOrder(
      id: ary['id'],
      storeid: ary['store_id'],
      storename: ary['store_name'],
      detail: modelAddOrdDetail(ary['detail']),
      sessid: ary['sess_id'],
      posid: ary['pos_id'],
      frontid: ary['front_id'],
      kitchenid: ary['kitchen_id'],
      invid: ary['inv_id'],
      secposid: ary['secpos_id'],
      secfrontid: ary['secfront_id'],
      seckitid: ary['seckit_id'],
      secinvid: ary['secinv_id'],
      rescaf: ary['rescaf'],
      rescaftab: ary['rescaf_tab'],
      rescaftake: ary['rescaf_take'],
      itemcount: ary['item_count'],
      subtotal: ary['subtotal'].toDouble(),
      tax: ary['tax'].toDouble(),
      total: ary['total'].toDouble(),
      cash: ary['cash'].toDouble(),
      cashchg: ary['cashchg'].toDouble(),
      shipfee: ary['shipfee'].toDouble(),
      status: ary['status'],
      rescafcheckout: ary['rescaf_checkout'],
      rescafcheckoutlog: ary['rescafcheckout_log'],
      rescafpaid: ary['rescaf_paid'],
      rescafpaidlog: ary['rescafpaid_log'],
      paid: ary['paid'],
      shipped: ary['shipped'],
      created: DateTime.parse(ary['created']),
    );
  }

  factory RescafOrder.fromJsonDet(json) {
    return RescafOrder(
      id: json['id'],
      storeid: json['store_id'],
      storename: json['store_name'],
      detail: modelAddOrdDetail(json['detail']),
      sessid: json['sess_id'],
      posid: json['pos_id'],
      frontid: json['front_id'],
      kitchenid: json['kitchen_id'],
      invid: json['inv_id'],
      secposid: json['secpos_id'],
      secfrontid: json['secfront_id'],
      seckitid: json['seckit_id'],
      secinvid: json['secinv_id'],
      rescaf: json['rescaf'],
      rescaftab: json['rescaf_tab'],
      rescaftake: json['rescaf_take'],
      itemcount: json['item_count'],
      subtotal: json['subtotal'].toDouble(),
      tax: json['tax'].toDouble(),
      total: json['total'].toDouble(),
      cash: json['cash'].toDouble(),
      cashchg: json['cashchg'].toDouble(),
      shipfee: json['shipfee'].toDouble(),
      status: json['status'],
      rescafcheckout: json['rescaf_checkout'],
      rescafcheckoutlog: json['rescafcheckout_log'],
      rescafpaid: json['rescaf_paid'],
      rescafpaidlog: json['rescafpaid_log'],
      paid: json['paid'],
      shipped: json['shipped'],
      created: DateTime.parse(json['created']),
    );
  }

}

List<RescafOrdProd> modelAddOrdDetail(detail) {
  List<RescafOrdProd> tmpdetail = [];
  if (detail.length>0) {
    detail.asMap().forEach((di, dv) {
      tmpdetail.add(RescafOrdProd.fromJsonDet(dv));
    });
  }
  return tmpdetail;
}


class RescafOrdProd {

	int id;
	int orderid;
	int prodid;
	String prodcode;
	String prdname;
	int quantity;
	double price;
	double tax;
	double subtotal;
	int kitchenneed;
	int kitchenaccept;
	int kitchendone;
  String kitchenstatus;
	int kitchenid;
	int invneed;
	int invaccept;
	int invdone;
  String invstatus;
	int invid;
	int delivered;
	String frontstatus;
	int frontid;
	int rescaf;
	int rescaftab;
	int rescaftake;
  int secfrontid;
  String secfrontstatus;
  int seckitid;
  String seckitstatus;
  int secinvid;
  String secinvstatus;
  int secposid;
  String secposstatus;
  DateTime created;

  RescafOrdProd({required this.id, required this.orderid, required this.prodid, required this.prodcode, required this.prdname, required this.quantity, required this.price, required this.tax, 
                required this.subtotal, required this.kitchenneed, required this.kitchenaccept, required this.kitchendone, required this.kitchenstatus, required this.kitchenid, required this.invneed, 
                required this.invaccept, required this.invdone, required this.invstatus, required this.invid, required this.delivered, required this.frontstatus, required this.frontid, 
                required this.rescaf, required this.rescaftab, required this.rescaftake, required this.secfrontid, required this.secfrontstatus, required this.seckitid, required this.seckitstatus, 
                required this.secinvid, required this.secinvstatus, required this.secposid, required this.secposstatus, required this.created});

  factory RescafOrdProd.fromArray(ary) {
    return RescafOrdProd(
      id: ary['id'],
      orderid: ary['order_id'],
      prodid: ary['prod_id'],
      prodcode: ary['prod_code'],
      prdname: ary['prd_name'],
      quantity: ary['quantity'],
      price: ary['price'].toDouble(),
      tax: ary['tax'].toDouble(),
      subtotal: ary['subtotal'].toDouble(),
      kitchenneed: ary['kitchen_need'],
      kitchenaccept: ary['kitchen_accept'],
      kitchendone: ary['kitchen_done'],
      kitchenstatus: ary['kitchen_status'],
      kitchenid: ary['kitchen_id'],
      invneed: ary['inv_need'],
      invaccept: ary['inv_accept'],
      invdone: ary['inv_done'],
      invstatus: ary['inv_status'],
      invid: ary['inv_id'],
      delivered: ary['delivered'],
      frontstatus: ary['front_status'],
      frontid: ary['front_id'],
      rescaf: ary['rescaf'],
      rescaftab: ary['rescaf_tab'],
      rescaftake: ary['rescaf_take'],
      secfrontid: ary['secfront_id'],
      secfrontstatus: ary['secfront_status'],
      seckitid: ary['seckit_id'],
      seckitstatus: ary['seckit_status'],
      secinvid: ary['secinv_id'],
      secinvstatus: ary['secinv_status'],
      secposid: ary['secpos_id'],
      secposstatus: ary['secpos_status'],
      created: DateTime.parse(ary['created']),
    );
  }

  factory RescafOrdProd.fromJsonDet(json) {
    return RescafOrdProd(
      id: json['id'],
      orderid: json['order_id'],
      prodid: json['prod_id'],
      prodcode: json['prod_code'],
      prdname: json['prd_name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
      tax: json['tax'].toDouble(),
      subtotal: json['subtotal'].toDouble(),
      kitchenneed: json['kitchen_need'],
      kitchenaccept: json['kitchen_accept'],
      kitchendone: json['kitchen_done'],
      kitchenstatus: json['kitchen_status'],
      kitchenid: json['kitchen_id'],
      invneed: json['inv_need'],
      invaccept: json['inv_accept'],
      invdone: json['inv_done'],
      invstatus: json['inv_status'],
      invid: json['inv_id'],
      delivered: json['delivered'],
      frontstatus: json['front_status'],
      frontid: json['front_id'],
      rescaf: json['rescaf'],
      rescaftab: json['rescaf_tab'],
      rescaftake: json['rescaf_take'],
      secfrontid: json['secfront_id'],
      secfrontstatus: json['secfront_status'],
      seckitid: json['seckit_id'],
      seckitstatus: json['seckit_status'],
      secinvid: json['secinv_id'],
      secinvstatus: json['secinv_status'],
      secposid: json['secpos_id'],
      secposstatus: json['secpos_status'],
      created: DateTime.parse(json['created']),
    );
  }

}


class RescafCounted {

  int id;
  int storeid;
  String storename;
  List<RescafOrder> detail;
  int sessid;
  int posid;
  int ordercount;
  String orders;
  double subtotal;
  double tax;
  double total;
  String ipaddress;
  String remotehost;
  String comment;
  String note;
  DateTime created;
  String posname;
  String posusername;

  RescafCounted({required this.id, required this.storeid, required this.storename, required this.detail, required this.sessid, required this.posid, 
              required this.ordercount, required this.orders, required this.subtotal, required this.tax, required this.total, required this.ipaddress, 
              required this.remotehost, required this.comment, required this.note, required this.created, required this.posname, required this.posusername});

  factory RescafCounted.fromArray(ary) {
    return RescafCounted(
      id: ary['id'],
      storeid: ary['store_id'],
      storename: ary['store_name'],
      detail: modelAddSessDetail(ary['detail']),
      sessid: ary['sess_id'],
      posid: ary['pos_id'],
      ordercount: ary['order_count'],
      orders: ary['orders'],
      subtotal: ary['subtotal'].toDouble(),
      tax: ary['tax'].toDouble(),
      total: ary['total'].toDouble(),
      ipaddress: ary['ip_address'],
      remotehost: ary['remote_host'],
      comment: ary['comment'],
      note: ary['note'],
      created: DateTime.parse(ary['created']),
      posname: ary['pos_name'],
      posusername: ary['pos_username'],
    );
  }

  factory RescafCounted.fromJsonDet(json) {
    return RescafCounted(
      id: json['id'],
      storeid: json['store_id'],
      storename: json['store_name'],
      detail: modelAddSessDetail(json['detail']),
      sessid: json['sess_id'],
      posid: json['pos_id'],
      ordercount: json['order_count'],
      orders: json['orders'],
      subtotal: json['subtotal'].toDouble(),
      tax: json['tax'].toDouble(),
      total: json['total'].toDouble(),
      ipaddress: json['ip_address'],
      remotehost: json['remote_host'],
      comment: json['comment'],
      note: json['note'],
      created: DateTime.parse(json['created']),
      posname: json['pos_name'],
      posusername: json['pos_username'],
    );
  }

}

List<RescafOrder> modelAddSessDetail(detail) {
  List<RescafOrder> tmpdetail = [];
  if (detail.length>0) {
    detail.asMap().forEach((di, dv) {
      tmpdetail.add(RescafOrder.fromJsonDet(dv));
    });
  }
  return tmpdetail;
}
