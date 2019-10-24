class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  bool check;

  CartInfoModel(
      {this.goodsId,
      this.goodsName,
      this.count,
      this.price,
      this.images,
      this.check});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['check'] = this.check;
    return data;
  }
}
