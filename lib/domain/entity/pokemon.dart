class Pokemon {
  const Pokemon({
    required int id,
    required String name,
    required String sprite,
    required int height,
    required int weight,
    required List<String> abilities,
    required List<String> types,
  });
}

class PokemonData {
  final String name;
  final String url;

  const PokemonData({required this.name, required this.url});

  List<Object?> get props => [name, url];
}
