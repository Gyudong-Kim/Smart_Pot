import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/color_theme.dart';
import '../services/pot_info_service.dart';
import '../models/pot_info_model.dart';

class PotInfoScreen extends StatefulWidget {
  const PotInfoScreen({super.key});

  @override
  State<PotInfoScreen> createState() => _PotInfoScreenState();
}

class _PotInfoScreenState extends State<PotInfoScreen> {
  late Future<PotInfo> futurePotInfo;
  String? date;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // PotInfo 데이터 가져오기
  void fetchData() {
    setState(() {
      futurePotInfo = fetchPotInfo();
      DateFormat now = DateFormat('yyyy-MM-dd HH:mm');
      date = now.format(DateTime.now());
    });
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
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 60,
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  alignment: Alignment.center,
                  child: Text(
                    '센서 현황',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Container(
                  height: 180,
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
                  decoration: BoxDecoration(
                    color: ColorTheme.createMaterialColor(Color(0xff153228)),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(children: [
                    Expanded(
                      flex: 1,
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '외부 온도',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${snapshot.data?.temp}℃',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '외부 습도',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${snapshot.data?.humi}%',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '토양 습도',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              '${snapshot.data?.soilHumi}%',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
                Container(
                  height: 55,
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  alignment: Alignment.center,
                  child: Text(
                    '작동 현황',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 50),
                  ),
                ),
                Container(
                  height: 120,
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  decoration: BoxDecoration(
                    color: ColorTheme.createMaterialColor(Color(0xff153228)),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '펌프',
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: (snapshot.data?.isWatering == 0)
                                  ? Text(
                                      'OFF',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    )
                                  : Text(
                                      'ON',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '조명',
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: (snapshot.data?.isLighting == 0)
                                    ? Text(
                                        'OFF',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      )
                                    : Text(
                                        'ON',
                                        style: TextStyle(
                                            fontSize: 30, color: Colors.white),
                                      ),
                              ),
                            ),
                          ],
                        )),
                  ]),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    '갱신 시간 : $date',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            );
          }
        },
      ),
      // 데이터 갱신 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: fetchData,
        tooltip: '버튼을 누르면 데이터가 갱신됩니다.',
        child: const Icon(Icons.autorenew),
      ),
    );
  }
}
