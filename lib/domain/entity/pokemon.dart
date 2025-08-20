class Pokemon {
  final int id;
  final String name;
  final String? spriteUrl;
  final int height;
  final int weight;
  final List<String> abilities;
  final List<String> types;

  const Pokemon({
    required this.id,
    required this.name,
    this.spriteUrl,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.types,
  });
}

class PokemonData {
  final String name;
  final String url;

  const PokemonData({required this.name, required this.url});

  List<Object?> get props => [name, url];
}

class SearchPokemonResult {
  final List<PokemonData> pokemonData;
  final int? nextOffset;

  const SearchPokemonResult({required this.pokemonData, this.nextOffset});
}
