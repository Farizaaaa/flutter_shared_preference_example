class ContactModelClass {
  //variables
  String name;
  String number;

  //initialize
  ContactModelClass({required this.name, required this.number});

  //fromjson
  factory ContactModelClass.fromJson(Map<String, dynamic> json) =>
      ContactModelClass(name: json["name"], number: json["number"]);

  //toJson
  Map<String, dynamic> toJson() {
    return {"name": name, "number": number};
  }
}
