import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sky_scrapper_currency_converter/GlobalClass/global.dart';

class apiHelper {
  apiHelper._();

  static final apiHelper api = apiHelper._();

  fetchCurrencyData({dynamic From, dynamic To, dynamic amount}) async {
    http.Response res = await http.get(Uri.parse(
        'https://api.exchangerate.host/convert?from=$From&to=$To&amount=4'));
    print(from);
    print(to);
    print(res.body);
    if (res.statusCode == 200) {
      Map decodeCode = jsonDecode(res.body);
      global allData = global.fromMap(data: decodeCode);
      return allData;
    }
  }
}
