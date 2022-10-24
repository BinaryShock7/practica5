class CharacterDao {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  String? image;
  String? url;
  String? created;

  CharacterDao({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.image,
    this.url,
    this.created,
  });

  factory CharacterDao.fromJSON(Map<String, dynamic> mapa)
  {
    return CharacterDao(
      id: mapa['id'],
      name: mapa['name'],
      status: mapa['status'],
      species: mapa['species'],
      type: mapa['type'],
      gender: mapa['gender'],
      image: mapa['image'],
      url: mapa['url'],
      created: mapa['created'],
    );
  }
}
