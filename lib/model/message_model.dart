class MessageModel {
  String name;
  String email;
  String phone;
  String title;
  String content;
  String from;
  String to;
  String date;
  String id;
  bool isSelected;

  MessageModel(this.name, this.email, this.phone, this.title, this.content,
      this.from, this.to, this.date,this.id,this.isSelected);

  factory MessageModel.fromJson(Map<String, dynamic> map,String idd) {
    return MessageModel(map['name'], map['email'], map['email'], map['title'],
        map['content'], map['from'], map['to'], map['date'],
    idd,false);
  }

}
