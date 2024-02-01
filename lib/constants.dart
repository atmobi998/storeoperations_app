import 'package:flutter/material.dart';
import 'package:storeoperations_app/size_config.dart';
import 'package:storeoperations_app/appbuildmode.dart';

const kPrimaryColor = Color(0xFF498cf2);
const kPrimaryLightColor = Color(0xFFFFECDF);
const colors = [Color(0xFF498cf2), Color(0xFF0c55c3)];
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF498cf2), Color(0xFF0c55c3)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kAnimationDuration = Duration(milliseconds: 200);
final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
const Color inActiveIconColor = Color(0xFFB6B6B6);
const kPosBaseColor = Colors.grey;
const kPosNameColor = Colors.black87;
const kPosCurNbrColor = Colors.black87;
const kPosDetColor = Colors.black87;
const kPosDetColorSel = Colors.white;

const kResCafBaseColor = Colors.grey;
const kResCafColor = Colors.black87;
const kResCafColorSel = Colors.blue;
const Color resCafProdInActiveColor = Colors.white;
const Color resCafProdSelColor = Colors.yellow;
const kResCafDetColor = Colors.black87;
const kResCafDetColorSel = Colors.white;
const kResCafDetStatusColor = Colors.yellow;
const kResCafDetStatusColorSel = Colors.yellowAccent;


const defaultDuration = Duration(milliseconds: 250);

double defInpFormMaxWidth = getProportionateScreenWidth(500);
double defInpFormWidth = getProportionateScreenWidth(500);

double defListFormMaxWidth = getProportionateScreenWidth(600);
double defListFormWidth = getProportionateScreenWidth(600);

double defTxtInpWidth = getProportionateScreenWidth(400);
double defTxtInpMaxWidth = getProportionateScreenWidth(400);
double defTxtInpHeight = getProportionateScreenHeight(79);
double defTxtInpMaxHeight = getProportionateScreenHeight(79);
double defTxtInpEdge = getProportionateScreenHeight(1);
double defNavBoxEdge = getProportionateScreenHeight(30);

double defResCafProdEdge = getProportionateScreenHeight(10);
double defResCafProdFormEdge = getProportionateScreenHeight(30);

double defTxtBoxWidth = getProportionateScreenWidth(400);
double defTxtBoxMaxWidth = getProportionateScreenWidth(400);
double defTxtBoxHeight = getProportionateScreenHeight(130);
double defTxtBoxMaxHeight = getProportionateScreenHeight(140);
double defTxtBoxEdge = getProportionateScreenHeight(1);
int defTxtBoxLines02 = 2;
int defTxtBoxLines03 = 3;

double defSrearchInpWidth = getProportionateScreenWidth(400);
double defSrearchInpMaxWidth = getProportionateScreenWidth(400);
double defSrearchInpHeight = getProportionateScreenHeight(79);
double defSrearchInpMaxHeight = getProportionateScreenHeight(79);

double defFormFieldEdges01 = getProportionateScreenHeight(1);
double defFormFieldEdges02 = getProportionateScreenHeight(2);
double defFormFieldEdges05 = getProportionateScreenHeight(5);
double defFormFieldEdges30 = getProportionateScreenHeight(30);
double defFormFieldEdges20 = getProportionateScreenHeight(20);
double defFormFieldEdges10 = getProportionateScreenHeight(10);

double prodListScrlHeight = getProportionateScreenHeight(431);
double catListScrlHeight = getProportionateScreenHeight(431);
double storeListScrlHeight = getProportionateScreenHeight(431);
double posListScrlHeight = getProportionateScreenHeight(431);

double defUIsize60 = getProportionateScreenHeight(60);
double defUIsize50 = getProportionateScreenHeight(50);
double defUIsize40 = getProportionateScreenHeight(40);
double defUIsize30 = getProportionateScreenHeight(30);
double defUIsize20 = getProportionateScreenHeight(20);
double defUIsize18 = getProportionateScreenHeight(18);
double defUIsize16 = getProportionateScreenHeight(16);
double defUIsize14 = getProportionateScreenHeight(14);
double defUIsize13 = getProportionateScreenHeight(13);
double defUIsize12 = getProportionateScreenHeight(12);
double defUIsize11 = getProportionateScreenHeight(11);
double defUIsize10 = getProportionateScreenHeight(10);

double halfScrlWid = getHalfScreenWidth();
double halfScrlHei = getHalfScreenHeight();

double rescafProdScrlWid = halfScrlWid * 2;
double rescafProdScrlHei = halfScrlHei * 2 - 10;

double halfScrlWid1b4 = halfScrlWid * (1/4);
double halfScrlHei1b4 = halfScrlHei * (1/4);

double halfScrlWid2b4 = halfScrlWid * (2/4);
double halfScrlHei2b4 = halfScrlHei * (2/4);

double halfScrlWid3b4 = halfScrlWid * (3/4);
double halfScrlHei3b4 = halfScrlHei * (3/4);

double halfScrlWid1b3 = halfScrlWid * (1/3);
double halfScrlHei1b3 = halfScrlHei * (1/3);

double halfScrlWid2b3 = halfScrlWid * (2/3);
double halfScrlHei2b3 = halfScrlHei * (2/3);

double halfScrlWid4b3 = halfScrlWid * (4/3);
double halfScrlHei4b3 = halfScrlHei * (4/3);

double fullScrlWid = getScreenWidth();
double fullScrlHei = getScreenHeight();

double pct80ScrlWid = fullScrlWid * (80/100);
double pct80ScrlHei = fullScrlHei * (80/100);

double pct82ScrlWid = fullScrlWid * (82/100);
double pct82ScrlHei = fullScrlHei * (82/100);

double pct83ScrlWid = fullScrlWid * (83/100);
double pct83ScrlHei = fullScrlHei * (83/100);

double pct84ScrlWid = fullScrlWid * (84/100);
double pct84ScrlHei = fullScrlHei * (84/100);

double pct85ScrlWid = fullScrlWid * (85/100);
double pct85ScrlHei = fullScrlHei * (85/100);

double pct77ScrlWid = fullScrlWid * (77/100);
double pct77ScrlHei = fullScrlHei * (77/100);

double pct20ScrlWid = fullScrlWid * (20/100);
double pct20ScrlHei = fullScrlHei * (20/100);

double pct15ScrlWid = fullScrlWid * (15/100);
double pct15ScrlHei = fullScrlHei * (15/100);

double pct12ScrlWid = fullScrlWid * (12/100);
double pct12ScrlHei = fullScrlHei * (12/100);

double pct10ScrlWid = fullScrlWid * (10/100);
double pct10ScrlHei = fullScrlHei * (10/100);

double pct08ScrlWid = fullScrlWid * (8/100);
double pct08ScrlHei = fullScrlHei * (8/100);

const String kMapAPIkey = 'Map key from Google Console';

// Rest URIs

const String mobAppVal = 'storeoperations_app'; 
const String imagehost = (appbuildmode == 'Release')? 'https://metroeconomics.com/' : 'http://metroeconomics.com/';
const String kapihost = (appbuildmode == 'Release')? 'https://metroeconomics.com/' : 'http://metroeconomics.com/';
const testposcode = (appbuildmode == 'Release')? '' : 'UJGyYWDU5J2Dni';
const testpasscode = (appbuildmode == 'Release')? '' : '12348765';

final Uri loginEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "profile/token") : Uri.http("metroeconomics.com", "profile/token");
final Uri registerEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "profile/register") : Uri.http("metroeconomics.com", "profile/register");
final Uri profileeditEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "profile/profileedit") : Uri.http("metroeconomics.com", "profile/profileedit");
final Uri forgotqryEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "profile/forgot") : Uri.http("metroeconomics.com", "profile/forgot");

final Uri loginPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/postoken") : Uri.http("metroeconomics.com", "mobusr/postoken");
final Uri addprodPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/addprod") : Uri.http("metroeconomics.com", "mobusr/addprod");
final Uri editprodPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/editprod") : Uri.http("metroeconomics.com", "mobusr/editprod");
final Uri prodqryPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/prodqry") : Uri.http("metroeconomics.com", "mobusr/prodqry");
final Uri addsessPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/addsess") : Uri.http("metroeconomics.com", "mobusr/addsess");
final Uri editsessPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/editsess") : Uri.http("metroeconomics.com", "mobusr/editsess");
final Uri tktaddPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/tktadd") : Uri.http("metroeconomics.com", "mobusr/tktadd");
final Uri tkteditPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/tktedit") : Uri.http("metroeconomics.com", "mobusr/tktedit");
final Uri tktqryPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/tktqry") : Uri.http("metroeconomics.com", "mobusr/tktqry");
final Uri detaddPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/detadd") : Uri.http("metroeconomics.com", "mobusr/detadd");
final Uri detdelPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/detdel") : Uri.http("metroeconomics.com", "mobusr/detdel");
final Uri deteditPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/detedit") : Uri.http("metroeconomics.com", "mobusr/detedit");
final Uri detqryPosEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobusr/detqry") : Uri.http("metroeconomics.com", "mobusr/detqry");

final Uri rescafOrdAddEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/ordadd") : Uri.http("metroeconomics.com", "mobrescaf/ordadd");
final Uri rescafOrdEditEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/ordedit") : Uri.http("metroeconomics.com", "mobrescaf/ordedit");
final Uri rescafOrdQryEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/ordqry") : Uri.http("metroeconomics.com", "mobrescaf/ordqry");
final Uri rescafOrdDetAddEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/orddetadd") : Uri.http("metroeconomics.com", "mobrescaf/orddetadd");
final Uri rescafOrdDetEditEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/orddetedit") : Uri.http("metroeconomics.com", "mobrescaf/orddetedit");
final Uri rescafOrdDetDelEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/orddetdel") : Uri.http("metroeconomics.com", "mobrescaf/orddetdel");
final Uri rescafOrdDetQryEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/orddetqry") : Uri.http("metroeconomics.com", "mobrescaf/orddetqry");
final Uri rescafSessQryEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/sessqry") : Uri.http("metroeconomics.com", "mobrescaf/sessqry");
final Uri rescafProdUpdEndPoint = (appbuildmode == 'Release')? Uri.https("metroeconomics.com", "mobrescaf/produpd") : Uri.http("metroeconomics.com", "mobrescaf/produpd");

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}
