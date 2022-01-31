class UsdModel {
  double price;
  double volume24h;
  num volumeChange24h;
  num percentChange1h;
  double percentChange24h;
  double percentChange7d;
  double percentChange30d;
  num percentChange60d;
  num percentChange90d;
  num marketCap;
  num marketCapDominance;
  num fullyDilutedMarketCap;
  String lastUpdated;

  UsdModel(
      {this.price,
        this.volume24h,
        this.volumeChange24h,
        this.percentChange1h,
        this.percentChange24h,
        this.percentChange7d,
        this.percentChange30d,
        this.percentChange60d,
        this.percentChange90d,
        this.marketCap,
        this.marketCapDominance,
        this.fullyDilutedMarketCap,
        this.lastUpdated});

  UsdModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    volume24h = json['volume_24h'];
    volumeChange24h = json['volume_change_24h'];
    percentChange1h = json['percent_change_1h'];
    percentChange24h = json['percent_change_24h'];
    percentChange7d = json['percent_change_7d'];
    percentChange30d = json['percent_change_30d'];
    percentChange60d = json['percent_change_60d'];
    percentChange90d = json['percent_change_90d'];
    marketCap = json['market_cap'];
    marketCapDominance = json['market_cap_dominance'];
    fullyDilutedMarketCap = json['fully_diluted_market_cap'];
    lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['volume_24h'] = this.volume24h;
    data['volume_change_24h'] = this.volumeChange24h;
    data['percent_change_1h'] = this.percentChange1h;
    data['percent_change_24h'] = this.percentChange24h;
    data['percent_change_7d'] = this.percentChange7d;
    data['percent_change_30d'] = this.percentChange30d;
    data['percent_change_60d'] = this.percentChange60d;
    data['percent_change_90d'] = this.percentChange90d;
    data['market_cap'] = this.marketCap;
    data['market_cap_dominance'] = this.marketCapDominance;
    data['fully_diluted_market_cap'] = this.fullyDilutedMarketCap;
    data['last_updated'] = this.lastUpdated;
    return data;
  }
}