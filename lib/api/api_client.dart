import 'dart:convert';

import 'package:crypto_currencies/crypto_currency_data.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const _url =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=15';

  Future<List<CryptoCurrencyData>> getCryptoCurrencies() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      List<CryptoCurrencyData> ccDataList = (json.decode(response.body) as List)
          .map((data) => CryptoCurrencyData.fromJson(data))
          .toList();
          print(json.decode(response.body).runtimeType); 
      return ccDataList;
    } else {
      throw Exception('Failed to load');
    }
  }
}
