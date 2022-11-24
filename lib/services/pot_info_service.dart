import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import '../models/pot_info_model.dart';

Future<PotInfo> fetchPotInfo() async {
  var url = dotenv.get('GET_URL');
  var uri = Uri.parse(url);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    print(response.body);
    return PotInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Fail to load PotInfo');
  }
}
