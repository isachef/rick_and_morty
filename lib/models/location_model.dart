// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

class LocationModel {
    LocationModel({
        this.id,
        this.name,
        this.type,
        this.dimension,
        this.residents,
        this.url,
        this.created,
    });

    int ?id;
    String ?name;
    String ?type;
    String ?dimension;
    List<String>? residents;
    String ?url;
    DateTime ?created;

    factory LocationModel.fromRawJson(String str) => LocationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        type: json["type"] == null ? null : json["type"],
        dimension: json["dimension"] == null ? null : json["dimension"],
        residents: json["residents"] == null ? null : List<String>.from(json["residents"].map((x) => x)),
        url: json["url"] == null ? null : json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "type": type == null ? null : type,
        "dimension": dimension == null ? null : dimension,
        "residents": residents == null ? null : List<dynamic>.from(residents!.map((x) => x)),
        "url": url == null ? null : url,
        "created": created == null ? null : created!.toIso8601String(),
    };
}
