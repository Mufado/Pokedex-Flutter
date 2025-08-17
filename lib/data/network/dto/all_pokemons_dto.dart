import 'package:json_annotation/json_annotation.dart';

part 'all_pokemons_dto.g.dart';

@JsonSerializable()
class AllPokemons {
  List<PokemonName> results;

  AllPokemons({required this.results});

  factory AllPokemons.fromJson(Map<String, dynamic> json) =>
      _$AllPokemonsFromJson(json);
}

@JsonSerializable()
class PokemonName {
  String name;

  PokemonName({required this.name});

  factory PokemonName.fromJson(Map<String, dynamic> json) =>
      _$PokemonNameFromJson(json);
}
