class DiaryModel {
  int id;
  String description;
  String image;
  String place;
  String feeling;

  DiaryModel({this.id, this.description, this.feeling, this.image, this.place});

  factory DiaryModel.fromDatabaseJson(Map<String, dynamic> data) => DiaryModel(
      id: data['id'],
      description: data['description'],
      feeling: data['feeling'],
      image: data['image'],
      place: data['place']);

  Map<String, dynamic> toDatabaseJson() => {
        "id": this.id,
        "description": this.description,
        "feeling": this.feeling,
        "image": this.image,
        "place": this.place,
      };
}
