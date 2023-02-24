import 'dart:convert';

TokenInfo tokenInfoFromJson(String str) => TokenInfo.fromJson(json.decode(str));

String tokenInfoToJson(TokenInfo data) => json.encode(data.toJson());

class TokenInfo {
  TokenInfo({
    required this.id,
    required this.symbol,
    required this.name,
    required this.description,
    required this.links,
    required this.image,
    required this.marketData,
  });

  String id;
  String symbol;
  String name;
  Description description;
  Links links;
  Images image;
  MarketData marketData;

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        description: Description.fromJson(json["description"]),
        links: Links.fromJson(json["links"]),
        image: Images.fromJson(json["image"]),
        marketData: MarketData.fromJson(json["market_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "description": description.toJson(),
        "links": links.toJson(),
        "image": image.toJson(),
        "market_data": marketData.toJson(),
      };
}

class Description {
  Description({
    required this.en,
  });

  String en;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Images {
  Images({
    required this.thumb,
    required this.small,
    required this.large,
  });

  String thumb;
  String small;
  String large;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumb: json["thumb"],
        small: json["small"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "thumb": thumb,
        "small": small,
        "large": large,
      };
}

class Links {
  Links({
    required this.homepage,
  });

  List<String> homepage;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        homepage: List<String>.from(json["homepage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "homepage": List<dynamic>.from(homepage.map((x) => x)),
      };
}

class MarketData {
  CurrentPrice? currentPrice;
  double? priceChange24h;
  double? priceChangePercentage24h;

  MarketData(
      {this.currentPrice, this.priceChange24h, this.priceChangePercentage24h});

  MarketData.fromJson(Map<String, dynamic> json) {
    currentPrice = json['current_price'] != null
        ? CurrentPrice.fromJson(json['current_price'])
        : null;
    priceChange24h = json['price_change_24h'];
    priceChangePercentage24h = json['price_change_percentage_24h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (currentPrice != null) {
      data['current_price'] = currentPrice!.toJson();
    }
    data['price_change_24h'] = priceChange24h;
    data['price_change_percentage_24h'] = priceChangePercentage24h;
    return data;
  }
}

class CurrentPrice {
  CurrentPrice({
    required this.usd,
  });
  num? usd;

  CurrentPrice.fromJson(Map<String, dynamic> json) {
    usd = json['usd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};

    data['usd'] = usd;

    return data;
  }
}
