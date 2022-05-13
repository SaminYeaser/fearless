class UserModel{
  String? email;
  String? firstName;
  String? secondName;
  String? uid;
  UserModel({
    this.email,
    this.firstName,
    this.secondName,
    this.uid
  });
  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      email: map['email']
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'firstName':firstName,
      'secondName':secondName,
      'email':email
    };
  }
}