import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool isReserve = false, isLighting = false;
  String watering = '유량 제어', lighting = '조명 OFF', date = '';
  final inputController = TextEditingController();
  var getUrl = 'http://203.250.32.29:3000/view/home';
  var postUrl = 'http://203.250.32.29:3000/control/code';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await http.get(Uri.parse(getUrl));
    if (mounted) {
      setState(() {
        var jsonData = jsonDecode(response.body);
        isLighting = jsonData['potList'][0]['stateData']['isLighting'] == 0
            ? false
            : true;
        lighting = isLighting == false ? '조명 OFF' : '조명 ON';
      });
    }
  }

  void sendDataAmountWatering() async {
    try {
      DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
      date = now.format(DateTime.now());

      Map data = {
        'tId': date,
        'potId': 1,
        'code': 'C_M_002',
        'paramsDetail': {
          'flux': int.parse(inputController.text),
        }
      };

      var body = jsonEncode(data);

      final response = await http.post(Uri.parse(postUrl),
          headers: {'Content-Type': 'application/json'}, body: body);

      showToast('${inputController.text}mL가 급수됩니다.');
    } catch (e) {
      showToast('서버와 통신에 실패하였습니다.');
      print(e);
    }
  }

  void sendDataTimeWatering() async {
    try {
      DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
      date = now.format(DateTime.now());

      Map data = {
        'tId': date,
        'potId': 1,
        'code': 'C_M_001',
        'paramsDetail': {
          'controlTime': int.parse(inputController.text),
        }
      };

      var body = jsonEncode(data);

      final response = await http.post(Uri.parse(postUrl),
          headers: {'Content-Type': 'application/json'}, body: body);

      showToast('${inputController.text}초 동안 급수됩니다.');
    } catch (e) {
      showToast('서버와 통신에 실패하였습니다.');
      print(e);
    }
  }

  void sendDataLightingOn() async {
    try {
      DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
      date = now.format(DateTime.now());

      Map data = {
        'tId': date,
        'potId': 1,
        'code': 'C_M_003',
        'paramsDetail': {}
      };

      var body = jsonEncode(data);

      final response = await http.post(Uri.parse(postUrl),
          headers: {'Content-Type': 'application/json'}, body: body);

      showToast('조명이 켜졌습니다.');
    } catch (e) {
      showToast('서버와 통신에 실패하였습니다.');
      print(e);
    }
  }

  void sendDataLightingOff() async {
    try {
      DateFormat now = DateFormat('yyyy-MM-ddTHH:mm:ss');
      date = now.format(DateTime.now());

      Map data = {
        'tId': date,
        'potId': 1,
        'code': 'C_M_004',
        'paramsDetail': {}
      };

      var body = jsonEncode(data);

      final response = await http.post(Uri.parse(postUrl),
          headers: {'Content-Type': 'application/json'}, body: body);

      showToast('조명이 꺼졌습니다.');
    } catch (e) {
      showToast('서버와 통신에 실패하였습니다.');
      print(e);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Text(
                '급수 제어',
                style: TextStyle(fontSize: 50),
              ),
            ),
            Container(
              height: 120,
              margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              watering,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Switch(
                              value: isReserve,
                              onChanged: (value) {
                                if (mounted) {
                                  setState(() {
                                    isReserve = value;
                                    watering =
                                        isReserve == false ? '유량 제어' : '시간 제어';
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            controller: inputController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: isReserve == false
                                    ? '급수 유량을 입력하세요.'
                                    : '급수 시간을 입력하세요.',
                                labelText:
                                    isReserve == false ? '유량(mL)' : '시간(초)'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            height: 55,
                            width: 90,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                if (isReserve == false) {
                                  sendDataAmountWatering();
                                } else {
                                  sendDataTimeWatering();
                                }
                              },
                              child: Text(
                                "전송",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Container(),
                  // ),
                ],
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 90),
              alignment: Alignment.center,
              child: Text(
                '조명 제어',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 50),
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              lighting,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Switch(
                              value: isLighting,
                              onChanged: (value) {
                                if (mounted) {
                                  setState(() {
                                    isLighting = value;
                                    lighting = isLighting == false
                                        ? '조명 OFF'
                                        : '조명 ON';
                                    if (isLighting == false) {
                                      sendDataLightingOff();
                                    } else {
                                      sendDataLightingOn();
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
