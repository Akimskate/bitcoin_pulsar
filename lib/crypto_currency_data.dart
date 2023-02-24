class CryptoCurrencyData {
  String? id;
  String? symbol;
  String? name;
  String? image;
  num? currentPrice;
  int? marketCapRank;
  num? priceChangePercentage;
  

  CryptoCurrencyData(key, value, {
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCapRank,
    this.priceChangePercentage,
  });

  CryptoCurrencyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCapRank = json['market_cap_rank'];
    priceChangePercentage = json["price_change_percentage_24h"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['image'] = image;
    data['current_price'] = currentPrice;
    data['market_cap_rank'] = marketCapRank;
    data["price_change_percentage_24h"] = priceChangePercentage;

    return data;
  }

  void forEach(Null Function(String key, dynamic val) param0) {}
}
