// import 'dart:io';

// import 'dart:convert';
// import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
// import 'package:pdf/pdf.dart';
// import 'dart:typed_data';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart'; 
import 'package:storeoperations_app/constants.dart';
import 'package:storeoperations_app/strconsts.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/app_globals.dart';
// import 'package:storeoperations_app/helper/keyboard.dart';
import 'package:storeoperations_app/components/default_button.dart';
import 'package:storeoperations_app/components/custom_surfix_icon.dart';
// import 'package:new_virtual_keyboard/virtual_keyboard.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:audiofileplayer/audiofileplayer.dart';

class StockOutBody extends StatefulWidget {

  const StockOutBody({Key? key}) : super(key: key);

  @override
  _StockOutBody createState() => _StockOutBody();

}

class _StockOutBody extends State<StockOutBody> with AfterLayoutMixin<StockOutBody> {

  final _formKey = GlobalKey<FormState>();
  int stkquantity = 1;
  String stkcomment = '';
  String itmstkfilter = '';
  bool needkitchen = true;
  bool needinventory = false;
  final List<String> errors = [];
  List<ResCafProduct> prodsfilter = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      itmstkfilter = '';
      resCafProdItmFilterTxtCtrl.text = '';
      prodsfilter = rescafprods;
    });
  }

  @override
  Widget build(BuildContext context) {
    gtextTranslate(context);
    return Form(
            key: _formKey,
            child: ConstrainedBox(constraints: BoxConstraints(maxWidth: rescafProdScrlWid,maxHeight: rescafProdScrlHei),
              child: Row(children: [
                      Column(children: [
                          Container(
                            width: rescafProdScrlWid * (1/2),
                            height: rescafProdScrlHei,
                            color: kPosBaseColor,
                            padding: EdgeInsets.all(defResCafProdEdge),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: rescafProdScrlWid * (1/2),
                                maxHeight: rescafProdScrlHei,
                              ),
                              child: SingleChildScrollView(
                                physics: const ScrollPhysics(),
                                child: Container(
                                  width: rescafProdScrlWid * (1/2),
                                  height: rescafProdScrlHei, 
                                  color: kPosBaseColor,
                                  child: Stack(
                                    children: [
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: prodsfilter.length,
                                          itemBuilder: (context, index) {
                                            String tmpprodcode = prodsfilter[index].prodcode;
                                            final String activetext = (prodsfilter[index].prodactive >= 1)? txtResCafStocks + prodsfilter[index].stockunits.toString() + txtResCafStockActive : txtResCafStocks + prodsfilter[index].stockunits.toString() + txtResCafStockInActive  ;
                                            return ListTile(
                                                title: Text(prodsfilter[index].prodname, style: TextStyle(fontWeight: FontWeight.w500,fontSize: defUIsize16, color: (prodsfilter[index].id == rescafstkprodid)? resCafProdSelColor : resCafProdInActiveColor)),
                                                subtitle: Text(tmpprodcode + '\n'+ thestore['currency'] +': ' + prodsfilter[index].prodpricesell.toString(), 
                                                            style: TextStyle( fontWeight: FontWeight.w500, fontSize: defUIsize12, color: (prodsfilter[index].id == rescafstkprodid)? resCafProdSelColor : resCafProdInActiveColor)),
                                                leading: Image.network(imagehost+prodsfilter[index].prodico, fit: BoxFit.cover, height: defUIsize30, width: defUIsize30),
                                                trailing: Text(activetext,
                                                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: defUIsize12,color: 
                                                      (prodsfilter[index].stockunits >= prodsfilter[index].minstock*2) ? Colors.white : 
                                                      (prodsfilter[index].stockunits > (prodsfilter[index].minstock*1.5).toInt())? Colors.blue : 
                                                      (prodsfilter[index].stockunits > (prodsfilter[index].minstock).toInt())? Colors.yellow : Colors.red)),
                                                onTap: () => {
                                                  setState(() {
                                                    rescafstkprodid = prodsfilter[index].id;
                                                  })
                                                },
                                              );
                                          },
                                        ),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),  
                        ],
                      ),
                      Column(children: [
                        Container(
                            width: rescafProdScrlWid * (1/2),
                            height: rescafProdScrlHei,
                            color: kPosBaseColor,
                            padding: EdgeInsets.all(defResCafProdEdge),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: rescafProdScrlWid * (1/2),
                                maxHeight: rescafProdScrlHei,
                              ),
                              child: SingleChildScrollView(
                                physics: const ScrollPhysics(),
                                child: Column(children: [
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      buildPickItmFilterField(),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      FuncButton100(text: lblStockOut, state: btnStateResCafStkOut,
                                        press: () {
                                          if (rescafstkprodid > 0) {
                                            dbStkIn(rescafstkprodid);
                                          }
                                        },
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      buildPickItmFormField(),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      buildPickItmCommentField(),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      FuncButton100(text: lblDone, state: btnStateResCafStkInDone,
                                        press: () {
                                          if (rescafstkprodid > 0) {
                                            hideStkInDialog(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
              );
    
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

  dbStkIn(prodid) {
    var postdata = {
        "mobapp" : mobAppVal,
        "id" : "$prodid",
        "qrymode" : rescafstkoutmode,
        "store_id" : "${thestore['id']}",
        "inv_id" : "${struser['id']}",
        "prod_id" : "$prodid",
        "quantity" : "$stkquantity",
        "stkcomment" : stkcomment,
        "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
        };
    http.post(
        rescafProdUpdEndPoint, 
        body: postdata,
        headers: posthdr
      ).then((result) {
          if (result.statusCode == 200) {
            var resary = jsonDecode(result.body);
            ResCafProduct tmpprod = ResCafProduct.fromJsonDet(resary['data']);
            if (rescafprods.where((prodelem) => (prodelem.id == tmpprod.id)).isNotEmpty) {
              syncProdList(tmpprod,rescafprods.indexWhere((prodelem) => (prodelem.id == tmpprod.id)));
            }
            setState(() {
              itmstkfilter = '';
            });
          } else {
            throw Exception(krescafProdqryErr);
          }
      }).catchError((error) {
        // print(error);
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
  
  setQuality(value) {
    setState(() {
      if (resCafProdItmTxtCtrl.text != '') {
        stkquantity = int.tryParse(value)!;
      }
    });
  }

  Container buildPickItmFormField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth/2,
      color: kResCafBaseColor,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth/2,
        ),
        child: TextFormField(
          controller: resCafProdItmTxtCtrl,
          keyboardType: TextInputType.number,
          onTap: () {
            
          },
          onSaved: (newValue) => setQuality(newValue),
          onChanged: (value) {
            if (value.isNotEmpty) {
              removeError(error: kResCafPickItmNullErr);
            }
            setQuality(value);
            return;
          },
          validator: (value) {
            if (value!.isEmpty) {
              addError(error: kResCafPickItmNullErr);
              return "";
            }
            return null;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblResCafPickItmsText,
            hintText: hintResCafPickItmsText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

  setComment(value) {
    setState(() {
      stkcomment = value;
    });
  }

  Container buildPickItmCommentField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth,
      color: kResCafBaseColor,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth,
        ),
        child: TextFormField(
          maxLines: 1,
          controller: resCafProdItmCommentTxtCtrl,
          onTap: () {
            
          },
          onSaved: (newValue) => setComment(newValue),
          onChanged: (value) {
            setComment(value);
            return;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblResCafStkOutCommentText,
            hintText: hintResCafStkOutCommentText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

  setFilter(value) {
    setState(() {
      itmstkfilter = value;
      if (itmstkfilter.isEmpty) {
        prodsfilter = rescafprods;
      } else {
        prodsfilter = rescafprods.where((prodelem) => (prodelem.prodname.toLowerCase().contains(itmstkfilter.toLowerCase())||prodelem.prodcode.contains(itmstkfilter.toLowerCase()))).toList();
        if (prodsfilter.isNotEmpty) {
          rescafstkprodid = rescafprods.where((prodelem) => (prodelem.prodname.toLowerCase().contains(itmstkfilter.toLowerCase())||prodelem.prodcode.contains(itmstkfilter.toLowerCase()))).toList().first.id;
        }
      }
    });
  }

  Container buildPickItmFilterField() {
    return Container(
      height: defTxtInpHeight,
      width: defTxtInpWidth,
      color: kResCafBaseColor,
      padding: EdgeInsets.all(defTxtInpEdge),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: defTxtInpMaxHeight,
          maxWidth: defTxtInpMaxWidth,
        ),
        child: TextFormField(
          maxLines: 1,
          controller: resCafProdItmFilterTxtCtrl,
          onTap: () {
            
          },
          onSaved: (newValue) => setFilter(newValue),
          onChanged: (value) {
            setFilter(value);
            return;
          },
          decoration: InputDecoration(counterText: ' ', counterStyle: const TextStyle(fontSize: 0), helperStyle: const TextStyle(fontSize: 0), errorStyle: const TextStyle(fontSize: 0),
            labelText: lblResCafPickItmFilterText,
            hintText: hintResCafPickItmFilterText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

}

