
class Movie {
  int id;
  String title;
  int duration;
  String description;
  String author;
  int releaseYear;
  int length;
  int numberOfViews;
  int photoId;

  Movie(
      {required this.id,
        required this.title,
        required this.duration,
        required this.description,
        required this.author,
        required this.releaseYear,
        required this.length,
        required this.numberOfViews,
        required this.photoId,
       });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      description: json['description'],
      author: json['author'],
      releaseYear: json['releaseYear'],
      length: json['length'],
      numberOfViews: json['numberOfViews'],
      photoId: json['photoId'],
       );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['duration'] = duration;
    data['description'] = description;
    data['author'] = author;
    data['releaseYear'] = releaseYear;
    data['length'] = length;
    data['numberOfViews'] = numberOfViews;
    data['photoId'] = photoId;
    return data;
  }
}
