class UserModel{
  String name;
  String email;
  String mobile;
  String type;
  String password;
  String confirm_password;
  String userId;

  UserModel(this.name, this.email,this.type, this.mobile, this.password,
      this.confirm_password, this.userId);

  factory UserModel.fromJson(Map<String,String> regMap){
   return UserModel(regMap['name'], regMap['email'],
       regMap['type'],regMap['mobile'],
       regMap['password'], regMap['confirm_password'],regMap['localId']) ;
  }
}