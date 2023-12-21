class CategoriesModel {
  late bool status;
  List<CategoriesDataModel> data = [];

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['data']['data']
        .forEach((element) => data.add(CategoriesDataModel.fromJson(element)));
  }
}

// class DataModel{
//   json['data']['data'].forEach((element) => data.add(element));
// }

class CategoriesDataModel {
  late String name;
  late String image;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}
