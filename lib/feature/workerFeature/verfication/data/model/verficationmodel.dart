class Verficationmodel {
  final int id;
  final String name;
  Verficationmodel({required this.id, required this.name});
  factory Verficationmodel.fromjson(Map<String, dynamic> json) {
    return Verficationmodel(id: json["id"] ?? 0, name: json["name"] ?? "");
  }
}

class VerficationInitList {
  final List<Verficationmodel> info;
  VerficationInitList({required this.info});
  factory VerficationInitList.fromjson(List<dynamic> json) {
    return VerficationInitList(
      info: json.map((element) => Verficationmodel.fromjson(element)).toList(),
    );
  }
}
