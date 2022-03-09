import 'dart:convert';

class Artefacto {
  Artefacto({
    this.available,
    required this.name,
    id,
  });

  bool? available;
  String name;
  String? id;

  factory Artefacto.fromJson(String str) => Artefacto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Artefacto.fromMap(Map<String, dynamic> json) => Artefacto(
        available: json["available"],
        name: json["name"],
        id: json['id'],
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        'id': id,
      };

  Artefacto copy() => Artefacto(
        name: name,
        available: available,
        id: id,
      );
}
