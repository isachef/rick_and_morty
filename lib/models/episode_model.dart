// To parse this JSON data, do
//
//     final episodeModel = episodeModelFromJson(jsonString);

import 'dart:convert';

class EpisodeModel {
    EpisodeModel({
        this.id,
        this.name,
        this.airDate,
        this.episode,
        this.characters,
        this.url,
        this.created,
    });

    int? id;
    String? name;
    String ?airDate;
    String ?episode;
    List<String>? characters;
    String ?url;
    DateTime? created;

    factory EpisodeModel.fromRawJson(String str) => EpisodeModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        airDate: json["air_date"] == null ? null : json["air_date"],
        episode: json["episode"] == null ? null : json["episode"],
        characters: json["characters"] == null ? null : List<String>.from(json["characters"].map((x) => x)),
        url: json["url"] == null ? null : json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "air_date": airDate == null ? null : airDate,
        "episode": episode == null ? null : episode,
        "characters": characters == null ? null : List<dynamic>.from(characters!.map((x) => x)),
        "url": url == null ? null : url,
        "created": created == null ? null : created!.toIso8601String(),
    };
}
