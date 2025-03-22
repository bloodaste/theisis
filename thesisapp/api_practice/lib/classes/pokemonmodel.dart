class Model {
  final String name;
  final String url;

  Model({
    required this.name,
    required this.url,
    // required this.weight,
  });

  factory Model.fromJson(Map<String, dynamic> e) {
    return Model(
      name: e['name'] ?? 'Unknown', // Provide a default value if name is null
      url: e['url'] ?? 'No URL',
    );
  }
}

// class Infospokemon {
//   final String sprite;
//   final String stats;

//   Infospokemon({required this.stats, required this.sprite});
// }
