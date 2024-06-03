import 'package:crypto_currencies/splash_screen/splash_screen.dart';
import 'package:crypto_currencies/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const CryptoCurrencyTracker());

class CryptoCurrencyTracker extends StatelessWidget {
  const CryptoCurrencyTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeModel(),
        child: Consumer(builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            title: 'Bitcoin-pulsar',
            theme: themeNotifier.isDark
                ? ThemeData.dark()
                : ThemeData(brightness: Brightness.light, primarySwatch: Colors.blueGrey),
            home: Splash(),
          );
        }));
  }
}
