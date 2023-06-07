class Photo {
  final int id;
  final String name;
  final int owner;

  Photo({required this.id, required this.name, required this.owner});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      name: json['name'],
      owner: json['owner'],
    );
  }
}
