import 'package:shop_app/models/home_model.dart';

class SearchModel{
  late bool status;
  List products = [];

  SearchModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    json['data']['data'].forEach((element) => products.add(SearchProductModel(element)));
  }

}

class SearchProductModel extends ProductModel{
  SearchProductModel(Map<String, dynamic>json):super.fromJson(json);

}