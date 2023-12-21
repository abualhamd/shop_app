class FavoriteModel {
  late bool status;
  List<int> data = [];
  // late int total;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    json['data']['data']
        .forEach((element) => data.add(FavoriteDataModel.fromJson(element).id));
    // total = json['data']['total'];
  }
}

class FavoriteDataModel {
  late int id;

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    id = json['product']['id'];
  }
}
