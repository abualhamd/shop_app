class ProfileModel{
  late String name;
  late String email;
  late String phone;

  ProfileModel.fromJson(Map<String, dynamic> json){
    name = json['data']['name'];
    email = json['data']['email'];
    phone = json['data']['phone'];
  }
}