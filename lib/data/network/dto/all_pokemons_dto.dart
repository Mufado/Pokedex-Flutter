import 'package:json_annotation/json_annotation.dart';

part 'all_pokemons_dto.g.dart';

@JsonSerializable()
class AllPokemons {
  List<PokemonDataDTO> results;

  AllPokemons({required this.results});

  factory AllPokemons.fromJson(Map<String, dynamic> json) =>
      _$AllPokemonsFromJson(json);
}

@JsonSerializable()
class PokemonDataDTO {
  String name;
  String url;

  PokemonDataDTO({required this.name, required this.url});

  factory PokemonDataDTO.fromJson(Map<String, dynamic> json) =>
      _$PokemonDataDTOFromJson(json);
}
