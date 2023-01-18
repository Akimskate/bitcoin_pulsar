import 'package:crypto_currencies/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'crypto_currency_list.dart';

void main() => runApp(CryptoCurrencyTracker());


class CryptoCurrencyTracker extends StatelessWidget {
  const CryptoCurrencyTracker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create:(_) => ThemeModel(),
    child: Consumer(
      builder: (context, ThemeModel themeNotifier, child) {
    return MaterialApp(
      title: 'Bitcoin-pulsar',
      
      theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
      home: CryptoCurrencyList(),
    );
  }));

}}