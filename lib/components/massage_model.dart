class Massage{
  final String text;
  final String sender;
  Massage({required this.text,required this.sender});

 factory Massage.fromjson(Map<String,dynamic> json){
    return Massage(
      text: json["text"], 
      sender: json["sender"]
    );
  }
}