import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import '../styles/color.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String data = '', date = '', isWatering = 'OFF', isLighting = 'OFF';
  num temp = 0, humi = 0, soilHumi = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var url = 'http://203.250.32.29:3000/view/home';
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (mounted) {
      setState(() {
        var jsonData = jsonDecode(response.body);
        temp = jsonData['potList'][0]['sensorData']['temp'];
        humi = jsonData['potList'][0]['sensorData']['humi'];
        soilHumi = jsonData['potList'][0]['sensorData']['soilHumi'];
        isWatering = jsonData['potList'][0]['stateData']['isWatering'] == 0
            ? 'OFF'
            : 'ON';
        isLighting = jsonData['potList'][0]['stateData']['isLighting'] == 0
            ? 'OFF'
            : 'ON';

        DateFormat now = DateFormat('yyyy-MM-dd HH:mm');
        date = now.format(DateTime.now());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 30, bottom: 10),
            alignment: Alignment.center,
            child: Text(
              'μΌμ νν©',
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            height: 180,
            margin: EdgeInsets.fromLTRB(20, 5, 20, 10),
            decoration: BoxDecoration(
              color: createMaterialColor(Color(0xff153228)),
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
                        'μΈλΆ μ¨λ',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$tempβ',
                        style: TextStyle(fontSize: 30, color: Colors.white),
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
                        'μΈλΆ μ΅λ',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$humi%',
                        style: TextStyle(fontSize: 30, color: Colors.white),
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
                        'ν μ μ΅λ',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        '$soilHumi%',
                        style: TextStyle(fontSize: 30, color: Colors.white),
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
              'μλ νν©',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            height: 120,
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
              color: createMaterialColor(Color(0xff153228)),
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
                          'νν',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          isWatering,
                          style: TextStyle(fontSize: 30, color: Colors.white),
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
                            'μ‘°λͺ',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            isLighting,
                            style: TextStyle(fontSize: 30, color: Colors.white),
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
              'κ°±μ  μκ° : $date',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getData,
        tooltip: 'λ²νΌμ λλ₯΄λ©΄ λ°μ΄ν°κ° κ°±μ λ©λλ€.',
        child: const Icon(Icons.autorenew),
      ),
    );
  }
}
