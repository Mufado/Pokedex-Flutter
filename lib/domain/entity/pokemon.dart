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

class NamedAPIResource {
  final String name;
  final String url;

  const NamedAPIResource({required this.name, required this.url});

  List<Object?> get props => [name, url];

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NamedAPIResource &&
            other.name == name &&
            other.runtimeType == runtimeType;
  }

  @override
  int get hashCode => name.hashCode;
}

class SearchPokemonResult {
  final List<NamedAPIResource> pokemonResources;
  final int? nextOffset;

  const SearchPokemonResult({required this.pokemonResources, this.nextOffset});
}

class FilterOption {
  final String name;
  final String? apiName;

  const FilterOption({required this.name, this.apiName});
}
