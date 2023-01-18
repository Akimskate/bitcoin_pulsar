import 'dart:convert';

import 'package:crypto_currencies/api/api_client.dart';
import 'package:crypto_currencies/chart_widget.dart';
import 'package:crypto_currencies/theme/theme_model.dart';
import 'package:flutter/material.dart';

import 'package:crypto_currencies/crypto_currency_data.dart';
import 'package:provider/provider.dart';

class CryptoCurrencyList extends StatefulWidget {
  const CryptoCurrencyList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CryptoCurrencyListStore();
  }
}

class CryptoCurrencyListStore extends State<CryptoCurrencyList> {
  List<CryptoCurrencyData> data = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    data = (await ApiClient().getCryptoCurrencies());
    if (data != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> _pullRefresh() async {
    setState(() {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Bitcoin pulsar'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  themeNotifier.isDark
                      ? themeNotifier.isDark = false
                      : themeNotifier.isDark = true;
                },
                icon: Icon(themeNotifier.isDark
                    ? Icons.nightlight_round
                    : Icons.wb_sunny))
          ],
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(child: CircularProgressIndicator()),
          child: RefreshIndicator(
            onRefresh: _pullRefresh,
            child: ListView(
              children: _buildList(),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.refresh),
        //   onPressed: () => getData(),
        // ),
      );
    });
  }

  List<Widget> _buildList() {
    return data
        .map((CryptoCurrencyData items) => Card(
              child: ListTile(
                  title: Text(items.name!),
                  subtitle: Text(items.symbol!.toUpperCase()),
                  leading: Image.network(
                    items.image!,
                    height: 40,
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${items.currentPrice!.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        items.priceChangePercentage!.toStringAsFixed(2) + '%',
                        style: items.priceChangePercentage! >= 0
                            ? const TextStyle(
                                color: Color.fromARGB(255, 27, 245, 35),
                              )
                            : const TextStyle(
                                color: Color.fromARGB(255, 246, 68, 55),
                              ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChartWidget(),
                    ));
                  }),
            ))
        .toList();
  }
}
