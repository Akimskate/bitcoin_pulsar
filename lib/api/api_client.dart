import 'dart:convert';

import 'package:crypto_currencies/crypto_currency_data.dart';
import 'package:crypto_currencies/token_history_price.dart';
import 'package:crypto_currencies/token_info.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<List<CryptoCurrencyData>> getCryptoCurrencies(int pageNumber) async {
    var url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=$pageNumber';
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      List<CryptoCurrencyData> ccDataList =
          (json.decode(response.body) as List).map((data) => CryptoCurrencyData.fromJson(data)).toList();
      return ccDataList;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<CryptoCurrencyData>> refreshCryptoCurrencies(int itemsLength) async {
    var url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=$itemsLength';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<CryptoCurrencyData> ccDataList =
          (json.decode(response.body) as List).map((data) => CryptoCurrencyData.fromJson(data)).toList();
      if (kDebugMode) {
        print(json.decode(response.body).runtimeType);
      }
      return ccDataList;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> getHistoryTokenPrice(String cryptocurrency) async {
    var url = 'https://api.coingecko.com/api/v3/coins/$cryptocurrency/ohlc?vs_currency=usd&days=365';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.isNotEmpty) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            var map = values[i];
            candleList.add(map);
            List<String> name = ["time", "open", "high", "low", "close"];
            final json = Map<String, dynamic>.fromIterables(
              name,
              map,
            );
            wickList.add(TokenHistoryPrice.fromJson(json));
          }
        }
        return wickList;
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  Future<TokenInfo> getTokenInfo(String cryptocurrency) async {
    final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/coins/$cryptocurrency'));
    if (response.statusCode == 200) {
      final tokenInfo = TokenInfo.fromJson(json.decode(response.body));
      if (kDebugMode) {
        print(tokenInfo);
      }
      return tokenInfo;
    } else {
      throw Exception('Failed to load');
    }
  }
}
