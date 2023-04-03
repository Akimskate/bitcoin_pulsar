import 'package:crypto_currencies/api/api_client.dart';
import 'package:crypto_currencies/chart_widget.dart';
import 'package:crypto_currencies/theme/theme_model.dart';
import 'package:crypto_currencies/token_info.dart';
import 'package:flutter/material.dart';

import 'package:crypto_currencies/crypto_currency_data.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class CryptoCurrencyList extends StatefulWidget {
  const CryptoCurrencyList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CryptoCurrencyListStore();
  }
}

class CryptoCurrencyListStore extends State<CryptoCurrencyList> {
  List<CryptoCurrencyData> _tokensList = [];
  var isLoaded = false;
  var isTokenPressed = false;

  List<TokenInfo> tokenInfo = [];

  late int _pageNumber;

  @override
  void initState() {
    super.initState();
    _pageNumber = 1;
    _tokensList = [];

    getData();
  }

  getData() async {
    _checkStatusCode();
    var data = (await ApiClient().getCryptoCurrencies(_pageNumber));
    
    setState(() {
      isLoaded = true;
      _pageNumber = _pageNumber + 1;
      _tokensList.addAll(data);
    });
  }

  Future<void> _pullRefresh(BuildContext context) async {
    var data = (await ApiClient().refreshCryptoCurrencies(_tokensList.length));
    setState(() {
      isLoaded = true;
      _tokensList.replaceRange(0, _tokensList.length, data);
    });
    print(_tokensList.length);
   
  }

  Future<void> _checkStatusCode() async {
    // final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/ping'));
    // if (response.statusCode == 200) {
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Error fetching data: ${response.statusCode}'),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    try {
      
      final response =
          await http.get(Uri.parse('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd'));
      // Do something with the response.
      if(response.statusCode == 200){
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('data procced: ${response.statusCode}'),
      //     backgroundColor: Colors.green,
      //   ),
      // );
      
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching data: ${response.statusCode}'),
          backgroundColor: Colors.red,
        ),
      );
      }
    } catch (e) {
      // Handle the exception.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
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
            onRefresh: () => _pullRefresh(context),
            child: ListView.builder(
              shrinkWrap: false,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: _tokensList.length,
              itemBuilder: (BuildContext context, int index) {
                final token = _tokensList[index];
                if (index == _tokensList.length - 3) {
                  getData();
                }
                return Card(
                  child: ListTile(
                      enabled: !isTokenPressed,
                      title: Text(token.name ?? ''),
                      subtitle: Text(token.symbol!.toUpperCase()),
                      leading: Image.network(
                        token.image!,
                        height: 40,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${token.currentPrice!.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            token.priceChangePercentage!.toStringAsFixed(2) +
                                '%',
                            style: token.priceChangePercentage! >= 0
                                ? const TextStyle(
                                    color: Color.fromARGB(255, 27, 245, 35),
                                  )
                                : const TextStyle(
                                    color: Color.fromARGB(255, 246, 68, 55),
                                  ),
                          ),
                        ],
                      ),
                      onTap: () async {
                        setState(() {
                          isTokenPressed = true;
                        });
                        String? cryptocurrency = token.id;
                        final tokenInfo =
                            await ApiClient().getTokenInfo(cryptocurrency!);
                        await ApiClient().getHistoryTokenPrice(cryptocurrency);
                        print(tokenInfo);
                        setState(() {
                          isTokenPressed = false;
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ChartWidget(tokenInfo: tokenInfo),
                        ));
                      }),
                );
              },
            ),
          ),
        ),
      );
    });
  }
}
