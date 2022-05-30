class ArticleModel{
  String? article;
  String? firstName;
  String? secondName;
  String? uid;
  DateTime? dateTime;
  ArticleModel({
    this.article,
    this.firstName,
    this.secondName,
    this.uid,
    this.dateTime
  });
  factory ArticleModel.fromMap(map){
    return ArticleModel(
        uid: map['uid'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        article: map['article'],
        dateTime: map['date']
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'firstName':firstName,
      'secondName':secondName,
      'article':article,
      'date':dateTime
    };
  }
}