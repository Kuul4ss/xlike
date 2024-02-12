
import 'package:xlike/models/meta.dart';

class Image {
  String? path;
  String? name;
  String? type;
  int? size;
  String? mime;
  Meta? meta;
  String? url;

  Image({
    required this.path,
    required this.name,
    required this.type,
    required this.size,
    required this.mime,
    required this.meta,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      path: json["path"],
      name: json["name"],
      type: json["type"],
      size: json["size"],
      mime: json["mime"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      url: json["url"],
    );
  }
}