class HomeModel {
  late bool status;
  // String? message;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    // message = json['message'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  late String ad;

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });
    ad = json['ad'];
  }
}

class BannerModel {
  late int id;
  late String img;
  // String? category;
  // String? product;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    // category = json['category'];
    // product = json['product'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  // late String description;
  // late List<String> images;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    // description = json['description'];
    // images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
