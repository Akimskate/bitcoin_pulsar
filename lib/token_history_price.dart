class TokenHistoryPrice {
  final num? time;
  final num? open;
  final num? high;
  final num? low;
  final num? close;

  TokenHistoryPrice({
    this.time,
    this.open,
    this.high,
    this.low,
    this.close,
  });
  factory TokenHistoryPrice.fromJson(Map<String, dynamic> json) {
    return TokenHistoryPrice(
      time: json['time'],
      open: json['open'],
      high: json['high'],
      low: json['low'],
      close: json['close'],
    );
  }
}

var candleList = [];
List<TokenHistoryPrice> wickList = [];