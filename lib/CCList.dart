import 'package:crypto_currencies/CCData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CCList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CCListStare();
  }
}

class CCListStare extends State<CCList>{
  List<CCData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bitcoin pulsar'),
      ),
      body: Container(
        child: ListView(
          children: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  _loadCC() async{
    final response = await http.get(Uri.parse('https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=BTC,ETH,LTC,LUNA'), 
    headers: {'X-CMC_PRO_API_KEY': 'e19f523d-ec32-48e7-99e5-3f0b98ea886b'});
    if(response.statusCode == 200){

      var allData = (json.decode(response.body) as Map)['data'] as Map<String, dynamic>;

      var ccDataList = <CCData>[];
      allData.forEach((String key, dynamic val) {
        var record = CCData(name: val[0]['name'], symbol: val[0]['symbol'],rank: val[0]['cmc_rank'], price: val[0]['quote']['USD']['price']);
        ccDataList.add(record);
       });
      
      setState(() {
        data = ccDataList;
      });
    }
  }

  List<Widget> _buildList(){
    return data.map((CCData f) => ListTile(
      title: Text(f.symbol),
      subtitle: Text(f.name),
      leading: CircleAvatar(child: Text(f.rank.toString()),),
      trailing: Text('\$${f.price.toStringAsFixed(2)}'),
    )).toList();
  }

}