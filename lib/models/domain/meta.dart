class Meta {
  int width;
  int height;

  Meta({
    required this.width,
    required this.height,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      width: json["width"],
      height: json["height"],
    );
  }
}