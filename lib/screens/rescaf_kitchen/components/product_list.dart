// import 'dart:io';

// import 'dart:convert';
// import 'dart:async';
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

class ProdFormBody extends StatefulWidget {

  const ProdFormBody({Key? key}) : super(key: key);

  @override
  _ProdFormBody createState() => _ProdFormBody();

}

class _ProdFormBody extends State<ProdFormBody> with AfterLayoutMixin<ProdFormBody> {

  final _formKey = GlobalKey<FormState>();
  int itmaddquantity = 1;
  String itmaddcomment = '';
  String itmaddfilter = '';
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
      itmaddfilter = '';
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
                                                title: Text(prodsfilter[index].prodname, style: TextStyle(fontWeight: FontWeight.w500,fontSize: defUIsize16, color: (prodsfilter[index].id == rescafcurprodid)? resCafProdSelColor : resCafProdInActiveColor)),
                                                subtitle: Text(tmpprodcode + '\n'+ thestore['currency'] +': ' + prodsfilter[index].prodpricesell.toString(), 
                                                            style: TextStyle( fontWeight: FontWeight.w500, fontSize: defUIsize12, color: (prodsfilter[index].id == rescafcurprodid)? resCafProdSelColor : resCafProdInActiveColor)),
                                                leading: Image.network(imagehost+prodsfilter[index].prodico, fit: BoxFit.cover, height: defUIsize30, width: defUIsize30),
                                                trailing: Text(activetext,
                                                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: defUIsize12,color: 
                                                      (prodsfilter[index].stockunits >= prodsfilter[index].minstock*2) ? Colors.white : 
                                                      (prodsfilter[index].stockunits > (prodsfilter[index].minstock*1.5).toInt())? Colors.blue : 
                                                      (prodsfilter[index].stockunits > (prodsfilter[index].minstock).toInt())? Colors.yellow : Colors.red)),
                                                onTap: () => {
                                                  setState(() {
                                                    rescafcurprodid = prodsfilter[index].id;
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
                                      FuncButton100(text: (rescafadditemmode == 'new')? lblResCafItemAdd : lblResCafItemChange, state: btnStateResCafItemAdd,
                                        press: () {
                                          if (rescafcurprodid > 0) {
                                            hideItemAddDialog(context);
                                            dbAddItem(rescafcurprodid,rescafcurorderid);
                                          }
                                        },
                                      ),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      buildPickItmFormField(),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      buildPickItmCommentField(),
                                      SizedBox(height: getProportionateScreenHeight(defFormFieldEdges10)),
                                      Container(
                                        alignment: Alignment.center,
                                        width: defTxtInpWidth,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: needkitchen,
                                              activeColor: resCafProdSelColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  needkitchen = value!;
                                                  needinventory = !needkitchen;
                                                });
                                              },
                                            ),
                                            Text(lblNeedKitchen, style: TextStyle(fontWeight: FontWeight.w400,fontSize: defUIsize12,color: resCafProdInActiveColor)),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: defTxtInpWidth,
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: needinventory,
                                              activeColor: resCafProdSelColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  needinventory = value!;
                                                  needkitchen = !needinventory;
                                                });
                                              },
                                            ),
                                            Text(lblNeedInventory, style: TextStyle(fontWeight: FontWeight.w400,fontSize: defUIsize12,color: resCafProdInActiveColor)),
                                            const Spacer(),
                                          ],
                                        ),
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

  dbAddItem(prodid,orderid) {
    var postdata = {
        "mobapp" : mobAppVal,
        "id" : (rescafadditemmode == 'new')? '' : "$rescafcurorddetid",
        "qrymode" : rescafadditemmode,
        "store_id" : "${thestore['id']}",
        "front_id" : "${struser['id']}",
        "prod_id" : "$prodid",
        "order_id" : "$orderid",
        "quantity" : "$itmaddquantity",
        "front_status" : itmaddcomment,
        "kitchen_need" : (needkitchen)? "1":"0",
        "inv_need" : (needinventory)? "1":"0",
        "rescaf" : "1",
        "rescaf_tab" : "$rescafcurtableid",
        "rescaf_take" : (rescafcurtableid == 0)? "1" : "0",
        "created" : dateDbFormat.format(DateTime.now()), "time" : dateDbFormat.format(DateTime.now()),
      };
    var posthdr = {
        'Accept': 'application/json',
        'Authorization' : 'Bearer $usertoken'
        };
    // showAlertDialog(context);
    http.post(
        rescafOrdDetAddEndPoint, 
        body: postdata,
        headers: posthdr
      ).then((result) {
          // hideAlertDialog(context);
          if (result.statusCode == 200) {
            // var resary = jsonDecode(result.body);
            setState(() {
              itmaddfilter = '';
            });
          } else {
            throw Exception(krescafProdqryErr);
          }
      }).catchError((error) {
        // print(error);
      });
  }

  
  setQuality(value) {
    setState(() {
      if (resCafProdItmTxtCtrl.text != '') {
        itmaddquantity = int.tryParse(value)!;
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
      itmaddcomment = value;
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
            labelText: lblResCafPickItmCommentText,
            hintText: hintResCafPickItmCommentText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const CustomSurffixIcon(svgIcon: "assets/icons/TextIcon.svg"),
          ),
        ),
      ),
    );
  }

  setFilter(value) {
    setState(() {
      itmaddfilter = value;
      if (itmaddfilter.isEmpty) {
        prodsfilter = rescafprods;
      } else {
        prodsfilter = rescafprods.where((prodelem) => (prodelem.prodname.toLowerCase().contains(itmaddfilter.toLowerCase())||prodelem.prodcode.contains(itmaddfilter.toLowerCase()))).toList();
        if (prodsfilter.isNotEmpty) {
          rescafcurprodid = rescafprods.where((prodelem) => (prodelem.prodname.toLowerCase().contains(itmaddfilter.toLowerCase())||prodelem.prodcode.contains(itmaddfilter.toLowerCase()))).toList().first.id;
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

