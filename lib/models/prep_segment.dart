class PrePostSegment{

  String? name;
  String? rating;
  String? description;

  PrePostSegment();

  PrePostSegment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['rating'] = rating;
    return data;
  }
}