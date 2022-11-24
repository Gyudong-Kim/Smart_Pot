import 'package:flutter/material.dart';
import '../services/pot_control_service.dart';
import '../services/pot_info_service.dart';
import '../models/pot_info_model.dart';

class PotControlScreen extends StatefulWidget {
  const PotControlScreen({super.key});

  @override
  State<PotControlScreen> createState() => _PotControlScreenState();
}

class _PotControlScreenState extends State<PotControlScreen> {
  late Future<PotInfo> futurePotInfo;

  bool isTime = false, isLighting = false;
  String watering = '유량 제어', lighting = '조명 OFF';
  String? date;
  final inputController = TextEditingController();
  @override
  void initState() {
    super.initState();
    futurePotInfo = fetchPotInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futurePotInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            // 소프트웨어 키보드 사용 시 화면 스크롤 가능하게 하기 위함
            return SingleChildScrollView(
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
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.black),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Switch(
                                    value: isTime,
                                    onChanged: (value) {
                                      if (mounted) {
                                        setState(() {
                                          isTime = value;
                                          watering = isTime == false
                                              ? '유량 제어'
                                              : '시간 제어';
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
                                      hintText: isTime == false
                                          ? '급수 유량을 입력하세요.'
                                          : '급수 시간을 입력하세요.',
                                      labelText:
                                          isTime == false ? '유량(mL)' : '시간(초)'),
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
                                      if (isTime == false) {
                                        sendDataAmountWatering(
                                            inputController.text);
                                      } else {
                                        sendDataTimeWatering(
                                            inputController.text);
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
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.black),
                                    )),
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
                                          lighting = (isLighting == false)
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
            );
          }
        },
      ),
    );
  }
}
