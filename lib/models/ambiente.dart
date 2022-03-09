// To parse this JSON data, do
//
//     final ambiente = ambienteFromMap(jsonString);

import 'dart:convert';

import 'artefacto.dart';

class Ambiente {
  Ambiente({
    this.artefacto,
    required this.name,
    this.picture,
    this.id,
  });

  Map<String, Artefacto>? artefacto;
  String name;
  String? picture;
  String? id;

  factory Ambiente.fromJson(String str) => Ambiente.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ambiente.fromMap(Map<String, dynamic> json) => Ambiente(
        artefacto: Map.from(json["artefacto"]).map(
            (k, v) => MapEntry<String, Artefacto>(k, Artefacto.fromMap(v))),
        name: json["name"].toString(),
        picture: json["picture"],
      );

  Map<String, dynamic> toMap() => {
        "artefacto": Map.from(artefacto!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toMap())),
        "name": name,
        "picture": picture,
      };

  Ambiente copy() => Ambiente(
        artefacto: artefacto,
        name: name,
        picture: picture,
        id: id,
      );
}
