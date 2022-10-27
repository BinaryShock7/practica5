class LocationDao {
  int? id;
  String? name;
  String? type;
  String? dimension;
  String? url;
  String? created;

  LocationDao({
    this.id,
    this.name,
    this.type,
    this.dimension,
    this.url,
    this.created,
  });

  factory LocationDao.fromJSON(Map<String, dynamic> mapa)
  {
    return LocationDao(
      id: mapa['id'],
      name: mapa['name'],
      type: mapa['type'],
      dimension: mapa['dimension'],
      url: mapa['url'],
      created: mapa['created'],
    );
  }
}
