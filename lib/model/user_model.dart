class UserModel{
  String name;
  String email;
  String mobile;
  String type;
  String password;
  String confirm_password;
  String userId;
  String id;

  UserModel(this.name, this.email,this.type, this.mobile, this.password,
      this.confirm_password, this.userId,this.id);

  factory UserModel.fromJson(Map<String,dynamic> regMap,String id){
   return UserModel(regMap['name'], regMap['email'],
       regMap['type'],regMap['phone'],
       regMap['password'], regMap['confirm_password'],regMap['localId'],id) ;
  }
}