class CryptoCurrencyData {
  String? symbol;
  String? name;
  String? image;
  num? currentPrice;
  int? marketCapRank;
  num? priceChangePercentage;
  

  CryptoCurrencyData({
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCapRank,
    this.priceChangePercentage,
  });

  CryptoCurrencyData.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = json['current_price'];
    marketCapRank = json['market_cap_rank'];
    priceChangePercentage = json["price_change_percentage_24h"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap_rank'] = this.marketCapRank;
    data["price_change_percentage_24h"] = this.priceChangePercentage;

    return data;
  }

  void forEach(Null Function(String key, dynamic val) param0) {}
}
