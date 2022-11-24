import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

var postUrl = dotenv.get('POST_URL');
String? date;

// 유량을 기준으로 급수하기 위한 POST
void sendDataAmountWatering(
  String inputNum,
) async {
  try {
    DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
    date = now.format(DateTime.now());

    Map data = {
      'tId': date,
      'potId': 1,
      'code': 'C_M_002',
      'paramsDetail': {
        'flux': int.parse(inputNum),
      }
    };

    var body = jsonEncode(data);

    await http.post(Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json'}, body: body);

    showToast('${inputNum}mL가 급수됩니다.');
  } catch (e) {
    showToast('서버와 통신에 실패하였습니다.');
  }
}

// 시간을 기준으로 급수하기 위한 POST
void sendDataTimeWatering(String inputNum) async {
  try {
    DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
    date = now.format(DateTime.now());

    Map data = {
      'tId': date,
      'potId': 1,
      'code': 'C_M_001',
      'paramsDetail': {
        'controlTime': int.parse(inputNum),
      }
    };

    var body = jsonEncode(data);

    await http.post(Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json'}, body: body);

    showToast('$inputNum초 동안 급수됩니다.');
  } catch (e) {
    showToast('서버와 통신에 실패하였습니다.');
  }
}

// 조명을 켜기 위한 POST
void sendDataLightingOn() async {
  try {
    DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
    date = now.format(DateTime.now());

    Map data = {'tId': date, 'potId': 1, 'code': 'C_M_003', 'paramsDetail': {}};

    var body = jsonEncode(data);

    await http.post(Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json'}, body: body);

    showToast('조명이 켜졌습니다.');
  } catch (e) {
    showToast('서버와 통신에 실패하였습니다.');
  }
}

// 조명을 끄기 위한 POST
void sendDataLightingOff() async {
  try {
    DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
    date = now.format(DateTime.now());

    Map data = {'tId': date, 'potId': 1, 'code': 'C_M_004', 'paramsDetail': {}};

    var body = jsonEncode(data);

    await http.post(Uri.parse(postUrl),
        headers: {'Content-Type': 'application/json'}, body: body);

    showToast('조명이 꺼졌습니다.');
  } catch (e) {
    showToast('서버와 통신에 실패하였습니다.');
  }
}

// Toast 메시지를 띄움
void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    fontSize: 20,
    textColor: Colors.black,
    toastLength: Toast.LENGTH_SHORT,
  );
}
